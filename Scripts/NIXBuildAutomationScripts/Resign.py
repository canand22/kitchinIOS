#!/usr/bin/env python

# Created by Yuri Govorushchenko, 2013
# Inspired by Xcode's PackageApplication script

from __future__ import print_function

import argparse
from difflib import SequenceMatcher
import os
import plistlib
import pprint
import re
import shutil
import subprocess
import tempfile
import filecmp
import codecs

from contextlib import contextmanager

ENTITLEMENTS_KEY           = "Entitlements"
APPLICATION_IDENTIFIER_KEY = "application-identifier"
KEYCHAIN_ACCESS_GROUPS_KEY = "keychain-access-groups"

class color:
    ''' See http://stackoverflow.com/a/287944 '''

    BOLD = "\033[1m"
    UNDERLINE = '\033[4m'
    BLINK = '\033[5m'

    HEADER = '\033[95m'+BOLD
    OKBLUE = '\033[94m'+BOLD
    WARNING = '\033[93m'+BOLD
    FAIL = '\033[91m'+BOLD
    ENDC = '\033[0m'

    @staticmethod
    def disable():
        color.BOLD = ''
        color.UNDERLINE = ''
        color.BLINK = ''
        
        color.HEADER = ''
        color.OKBLUE = ''
        color.WARNING = ''
        color.FAIL = ''
        color.ENDC = ''

class ProfileInfo:
    ''' Helper class '''

    def __init__(self, path, name, app_id, device_count):
        self.path = path
        self.name = name
        self.app_id = app_id
        self.device_count = device_count

    def __repr__(self):
        return "<'{}', '{}', '{}', {}>".format(self.path, self.name, self.app_id, self.device_count)


def resign(app_product_path, new_ipa_path, new_bundle_id=None, new_bundle_name=None, new_entitlements_path=None, profile_type="developer"):
    ''' Set new_bundle_id/new_bundle_name to None in case bundle id should stay the same. '''

    if not new_bundle_id:
        new_bundle_id = get_bundle_id(app_product_path)

    if not new_bundle_name:
        new_bundle_name = get_bundle_name(app_product_path)

    if new_bundle_id == "com.nixsolutions.ApplicationResignTest":
        print(color.FAIL + "error: change RESIGNED_BUNDLE_ID value in the project settings! " + color.UNDERLINE + "com.nixsolutions.ApplicationResignTest" + color.ENDC + color.FAIL + " is not allowed" + color.ENDC)
        exit(1)

    profiles_and_identities = None

    if profile_type == "developer":
        profiles_and_identities = list(get_matching_developer_profiles_and_identities(new_bundle_id))
    elif profile_type == "adhoc":
        profiles_and_identities = list(get_matching_adhoc_profiles_and_identities(new_bundle_id))
    else:
        profiles_and_identities = list(get_matching_appstore_profiles_and_identities(new_bundle_id))

    if not profiles_and_identities:
        throw_match_error()

    print(color.HEADER + "--> Matching profiles and identities:" + color.ENDC)
    pprint.pprint(profiles_and_identities)

    print("--> Looking for the best match among found profiles, based on similarity between profile's app id and desired bundle id...")
    best_match = find_best_match_for_bundle_id(profiles_and_identities, new_bundle_id)
    print(color.HEADER + "--> Best match: {}".format(best_match) + color.ENDC)

    profile_info = best_match[0]
    identity_name = best_match[1]

    print(color.BOLD + "==> Sign with profile '" + color.BLINK + color.UNDERLINE + profile_info.name + color.ENDC +
          color.BOLD + "', identity '" + color.UNDERLINE + identity_name + color.ENDC + color.BOLD + "'..." + color.ENDC)

    package_application(app_product_path, new_ipa_path, new_bundle_id, new_bundle_name, new_entitlements_path, profile_info.path, identity_name)


def throw_match_error():
    print(color.FAIL + "error: no mathching profiles found, read logs for more info" + color.ENDC)
    exit(1)


def find_best_match_for_bundle_id(profiles_and_identities, new_bundle_id):
    def app_id_similarity_to_new_bundle_id(match):
        app_id = match[0].app_id
        ratio = SequenceMatcher(None, new_bundle_id, app_id).ratio()
        print("\tsimilarity ratio: '{}' <--> '{}' = {}".format(new_bundle_id, app_id, ratio))
        return ratio

    return max(profiles_and_identities, key=app_id_similarity_to_new_bundle_id)


def package_application(app_product_path, new_ipa_path, new_bundle_id, new_bundle_name, new_entitlements_path, profile_path, identity_name):
    '''
        Re-signs and packages specified app product.
        Does NOT check that new bundle id corresponds to profile.
        Automatically constructs new entitlements in case they are not specified.
        new_entitlements_path can be set to None or ''. In this case the entitlements will be taken from the exisitng product or generated automatically.
        If re-signing with a distribution profile and get-task-allow is set to true, the AppStore will reject the submission. So the function automatically fixes the value of this entitlements field.
    '''

    with create_temp_dir() as tmp_dir:
        dest_app_dir = os.path.join(tmp_dir, "Payload")
        dest_app_product_path = os.path.join(dest_app_dir, os.path.basename(app_product_path))

        print("--> Create '{}'...".format(dest_app_dir))
        os.mkdir(dest_app_dir)

        print("--> Copy '{}' into '{}'...".format(app_product_path, dest_app_product_path))
        shutil.copytree(app_product_path, dest_app_product_path)

        is_provision_replaced = replace_provision(dest_app_product_path, profile_path)
        is_bundle_id_or_name_changed = rename_bundle_id_and_name(dest_app_product_path, new_bundle_id, new_bundle_name)

        resource_rules_path = os.path.join(dest_app_product_path, "ResourceRules.plist")
        codesign_args = ["/usr/bin/codesign", "--force",
                         "--sign", identity_name,
                         "--resource-rules={}".format(resource_rules_path)]

        # now let's figure out the entitlements...
        selected_entitlements_path = None

        if new_entitlements_path:
            # a) use explicitly set entitlements
            print(color.HEADER + "--> Using explicitly set entitlements from '{}'".format(new_entitlements_path) + color.ENDC)

            # make a copy to not mess up the original file
            tmp_file = tempfile.NamedTemporaryFile(delete=False)
            selected_entitlements_path = tmp_file.name

            shutil.copyfile(new_entitlements_path, selected_entitlements_path)

        else:
            should_generate_entitlements_manually = is_provision_replaced or is_bundle_id_or_name_changed

            if not should_generate_entitlements_manually:
                # b) existing entitlements are OK
                entitlements_file = get_entitlements_from_app(dest_app_product_path)
                selected_entitlements_path = entitlements_file.name

                # leave only plist data in file
                plist = get_plist_from_file(selected_entitlements_path)
                plistlib.writePlist(plist, selected_entitlements_path)

                print(color.HEADER + "--> Using existing entitlements" + color.ENDC)
            else:
                # c) no entitlements is bad, so we will construct them manually
                selected_entitlements_path = generate_temp_entitlements_file_from_profile(profile_path, new_bundle_id)

                print(color.HEADER + "--> Using automatically generated entitlements from '{}'".format(selected_entitlements_path) + color.ENDC)

        # crucial for submission
        fix_get_task_allow(selected_entitlements_path, identity_name)

        print("--> Entitlements:\n" + color.WARNING + open(selected_entitlements_path).read() + color.ENDC)

        codesign_args += ['--entitlements', selected_entitlements_path, dest_app_product_path]

        try:
            print(color.HEADER + "--> Codesign with params {}...".format(codesign_args) + color.ENDC)
            subprocess.check_call(codesign_args)
        finally:
            print("--> Remove temp entitlements file '{}'".format(selected_entitlements_path))
            os.remove(selected_entitlements_path)

        check_signature(dest_app_product_path)

        if os.path.exists(new_ipa_path):
            print("--> Remove old '{}'...".format(new_ipa_path))
            os.remove(new_ipa_path)

        print("--> Zip '{}' into '{}'...".format(tmp_dir, new_ipa_path))
        os.chdir(tmp_dir)
        subprocess.check_call(["/usr/bin/zip", "--symlinks", "--verbose", "--recurse-paths", new_ipa_path, "."])


def check_signature(app_product_path):
    print("--> Check signature...")
    return subprocess.call(["/usr/bin/codesign", "--verify", "-vvvv", app_product_path])


@contextmanager
def create_temp_dir():
    ''' returns path to new temp dir, guarantees to remove it '''

    path = tempfile.mkdtemp()

    try:
        print("Created temp dir '{}'".format(path))
        yield path
    finally:
        print("Remove temp dir '{}'...".format(path))
        shutil.rmtree(path)

def replace_provision(app_product_path, provision_path):
    embedded_provision_path = os.path.join(app_product_path, "embedded.mobileprovision")
    is_provision_the_same = filecmp.cmp(provision_path, embedded_provision_path)

    if not is_provision_the_same:
        print("--> Embed profile '{}'...".format(provision_path))
        shutil.copyfile(provision_path, embedded_provision_path)

    return not is_provision_the_same

def rename_bundle_id_and_name(app_product_path, new_bundle_id, new_bundle_name):
    original_bundle_id = get_bundle_id(app_product_path)
    original_bundle_name = get_bundle_name(app_product_path)
    original_bundle_display_name = get_bundle_display_name(app_product_path)

    info_plist_path = os.path.join(app_product_path, "Info.plist")

    is_bundle_id_the_same   = False
    is_bundle_name_the_same = False

    if new_bundle_id == original_bundle_id:
        print(color.HEADER + "--> Bundle id '{}' will not be modified".format(new_bundle_id) + color.ENDC)
        is_bundle_id_the_same = True
    else:
        print(color.HEADER + "--> Rename bundle id from '{}' into '{} in '{}'...".format(original_bundle_id, new_bundle_id, info_plist_path) + color.ENDC)
        subprocess.check_call(["/usr/libexec/PlistBuddy", info_plist_path, "-c", "Set :CFBundleIdentifier {}".format(new_bundle_id)])

    if new_bundle_name == original_bundle_name == original_bundle_display_name:
        print(color.HEADER + "--> Bundle name '{}' will not be modified".format(new_bundle_name) + color.ENDC)
        is_bundle_name_the_same = True
    else:
        print(color.HEADER + "--> Rename bundle name/bundle display name from '{}'/'{}' into '{}' in '{}'...".format(
            original_bundle_name, original_bundle_display_name, new_bundle_name, info_plist_path) + color.ENDC)
        subprocess.check_call(["/usr/libexec/PlistBuddy", info_plist_path, "-c", "Set :CFBundleName {}".format(new_bundle_name)])
        subprocess.check_call(["/usr/libexec/PlistBuddy", info_plist_path, "-c", "Set :CFBundleDisplayName {}".format(new_bundle_name)])

    return is_bundle_id_the_same or is_bundle_name_the_same

def get_bundle_id(app_product_path):
    info_plist_path = os.path.join(app_product_path, "Info.plist")
    return subprocess.check_output(["/usr/libexec/PlistBuddy", info_plist_path, "-c", "Print :CFBundleIdentifier"]).strip()


def get_bundle_name(app_product_path):
    info_plist_path = os.path.join(app_product_path, "Info.plist")
    return subprocess.check_output(["/usr/libexec/PlistBuddy", info_plist_path, "-c", "Print :CFBundleName"]).strip()


def get_bundle_display_name(app_product_path):
    info_plist_path = os.path.join(app_product_path, "Info.plist")
    return subprocess.check_output(["/usr/libexec/PlistBuddy", info_plist_path, "-c", "Print :CFBundleDisplayName"]).strip()


def get_entitlements_from_app(app_product_path):
    ''' Returns None if entitlements cannot be read (e.g. when signature is modified), otherwise - temp file with entitlements. User is responsible for removing temp file. '''

    entitlements_file = tempfile.NamedTemporaryFile(delete=False)

    print("--> Copy entitlements from '{}' into '{}'...".format(app_product_path, entitlements_file.name))

    try:
        subprocess.check_call(["codesign", "-d", app_product_path, "--entitlements", entitlements_file.name])
    except subprocess.CalledProcessError:
        return None

    return entitlements_file


def app_id_prefix_from_profile(profile_path):
    plist = get_plist_from_file(profile_path)
    profile_name, app_id, certs, device_count = parse_profile(profile_path)
    app_id_prefix = app_id[:app_id.index('.')]

    return app_id_prefix


def identity_is_for_development(identity_name):
    return identity_name.startswith("iPhone Developer")


def identity_is_for_distribution(identity_name):
    return identity_name.startswith("iPhone Distribution")


def generate_temp_entitlements_file_from_profile(profile_path, bundle_id):
    ''' User is responsible for removing temp file. Always sets the same get-task-allow. '''

    generated_entitlements_file = tempfile.NamedTemporaryFile(mode="w+r", bufsize=0, delete=False)  # we make sure that all writing is unbuffered, since file is going to be opened until app is closed
    generated_entitlements_path = generated_entitlements_file.name

    print(color.HEADER + "--> Automatically generate new entitlements at '{}'...".format(generated_entitlements_path) + color.ENDC)

    app_id_prefix = app_id_prefix_from_profile(profile_path)
    application_identifier = app_id_prefix + "." + bundle_id

    plist = get_plist_from_file(profile_path)
    profile_entitlements = plist[ENTITLEMENTS_KEY]
    profile_entitlements[APPLICATION_IDENTIFIER_KEY] = application_identifier
    profile_entitlements[KEYCHAIN_ACCESS_GROUPS_KEY][0] = application_identifier

    profile_entitlements_string = plistlib.writePlistToString(profile_entitlements)
    generated_entitlements_file.write(profile_entitlements_string)

    print("--> Lint new entitlements...")
    subprocess.check_call(['/usr/bin/plutil', '-lint', generated_entitlements_path])

    return generated_entitlements_path


def fix_get_task_allow(entitlements_path, identity_name):
    print("--> Fix get-task-allow if needed...")

    plist = plistlib.readPlist(entitlements_path)

    # this entitlements field must be set to False for distribution
    new_value = not identity_is_for_distribution(identity_name)
    plist["get-task-allow"] = new_value

    plistlib.writePlist(plist, entitlements_path)

    print("--> get-task-allow = {}".format(new_value))


def get_matching_developer_profiles_and_identities(new_bundle_id):
    ''' Generator. Use it to match only developer profiles. '''

    for match in get_matching_profiles_and_identities(new_bundle_id):
        identity_name = match[1]

        if not identity_is_for_development(identity_name):
            print(color.WARNING + "\t--> Skipping, because looking only for developer profiles" + color.ENDC)
        else:
            yield match


def get_matching_appstore_profiles_and_identities(new_bundle_id):
    ''' Generator. Use it to match only Appstore distribution profiles. '''

    for match in get_matching_profiles_and_identities(new_bundle_id):
        device_count = match[0].device_count
        identity_name = match[1]

        if not identity_is_for_distribution(identity_name):
            print(color.WARNING + "\t--> Skipping, because looking only for Appstore distribution profiles" + color.ENDC)
        elif device_count > 0:
            print(color.WARNING + "\t--> Skipping, because profile contains devices" + color.ENDC)
        else:
            yield match

def get_matching_adhoc_profiles_and_identities(new_bundle_id):
    ''' Generator. Use it to match only AdHoc distribution profiles. '''
    
    for match in get_matching_profiles_and_identities(new_bundle_id):
        device_count = match[0].device_count
        identity_name = match[1]
        
        if not identity_is_for_distribution(identity_name):
            print(color.WARNING + "\t--> Skipping, because looking only for AdHoc distribution profiles" + color.ENDC)
        elif device_count == 0:
            print(color.WARNING + "\t--> Skipping, because profile doesn't contains devices" + color.ENDC)
        else:
            yield match

def get_matching_profiles_and_identities(new_bundle_id):
    ''' Generator. Finds matching profile and identity based on specified bundle id. Matches only valid identities. '''

    profiles_path = os.path.expanduser("~/Library/MobileDevice/Provisioning Profiles/")

    print(color.BOLD + "--> Scan profiles at '{}'...".format(profiles_path) + color.ENDC)
    for filename in os.listdir(profiles_path):
        if file_is_not_profile(filename):
            continue

        print(color.UNDERLINE + "Profile '{}', ".format(filename), end='')

        profile_path = os.path.join(profiles_path, filename)
        profile_name, app_id, certs, device_count = parse_profile(profile_path)

        print("name = '{}', app id='{}', {} device(s)".format(profile_name, app_id, device_count) + color.ENDC)

        if not bundle_id_corresponds_to_app_id(new_bundle_id, app_id):
            print(color.WARNING + "\t--> Can't use this profile, because app id '{}' doesn't allow new bundle id '{}'".format(app_id, new_bundle_id) + color.ENDC)
            continue

        print(color.HEADER + "\t--> Profile's app id '{}' allows new bundle id '{}'".format(app_id, new_bundle_id) + color.ENDC)

        print("\t--> Scan certs...")
        for identity_name in get_matching_identities_from_certs(certs):
            match = (ProfileInfo(profile_path, profile_name, app_id, device_count), identity_name)

            print(color.HEADER + "\t--> Match found: {}".format(match) + color.ENDC)

            yield match


def file_is_not_profile(filename):
    root, ext = os.path.splitext(filename)
    return ext != '.mobileprovision'


def parse_profile(profile_path):
    plist = get_plist_from_file(profile_path)

    profile_name = plist["Name"]
    app_id = plist[ENTITLEMENTS_KEY][APPLICATION_IDENTIFIER_KEY]
    certs = plist["DeveloperCertificates"]

    devices = []
    try:
        devices = plist["ProvisionedDevices"]
    except KeyError:
        pass

    return profile_name, app_id, certs, len(devices)


def get_plist_from_file(path):
    content = open(path).read()

    plist_start_index = content.index("<?xml")
    plist_end_index = content.index("</plist>")+len("</plist>")
    profile_plist_str = content[plist_start_index:plist_end_index]

    return plistlib.readPlistFromString(profile_plist_str)


def bundle_id_corresponds_to_app_id(bundle_id, app_id):
    app_id_without_seed_id = app_id[app_id.index(".")+1:]
    app_id_without_seed_id_regexp = app_id_without_seed_id.replace(".", r"\.").replace("*", ".*")

    match = re.match(app_id_without_seed_id_regexp, bundle_id)

    return bool(match)


def get_matching_identities_from_certs(certs):
    '''  Generator. Returns list of valid identities based on the list of embedded certs from the profile file. '''

    for cert in certs:
        cert_str = parse_cert(cert)
        identity_name = get_identity_name_from_cert(cert_str)
        identity_name = identity_name.decode("string_escape")

        print("\tIdentity '{}'...".format(identity_name), end='')

        if not identity_is_valid(identity_name):
            print(color.WARNING + "invalid" + color.ENDC)
            continue

        print(color.HEADER + "valid!" + color.ENDC)

        yield identity_name


def parse_cert(cert):
    openssl_decoder = subprocess.Popen(["openssl", "x509", "-inform", "DER", "-subject"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    cert_str, stderr = openssl_decoder.communicate(str(cert.data))

    return cert_str


def get_identity_name_from_cert(cert):
    search_result = re.search('CN=(.+?)/OU=', cert)
    if not search_result:
        search_result = re.search('CN=(.+?)/O=', cert)
    return search_result.group(1)


def identity_is_valid(identity_name):
    return (identity_name in valid_keychain_identities_cache)


def get_valid_keychain_identities():
    keychain_path = os.path.expanduser("~/Library/Keychains/XCodeKeys.keychain");
    security_report = subprocess.check_output(["Scripts/NIXBuildAutomationScripts/Utils/identitieslist", "-k", keychain_path])
    entries = re.split(r"\n", security_report)

    identities = set()
    for entry in entries:
        identities.add(entry)

    return identities

valid_keychain_identities_cache = get_valid_keychain_identities()

def main():
    do_not_use_color = os.environ.get("RESIGN_NO_COLOR")
    if do_not_use_color:
        color.disable()
    
    parser = argparse.ArgumentParser(description="Resigns specified .app product and packages it into .ipa file. Finds best matching provisioning profile based on specified options.")

    parser.add_argument("--app-product-path", required=True, help="full path to input .app folder")
    parser.add_argument("--new-ipa-path", required=True, help="full path to output .ipa file")
    parser.add_argument("--profile-type", required=True, choices=["developer", "appstore", "adhoc"], help="type of profile to resign with")

    parser.add_argument("--new-bundle-id", help="optional")
    parser.add_argument("--new-bundle-name", help="optional")
    parser.add_argument("--new-entitlements-path", help="optional")

    args = parser.parse_args()

    resign(args.app_product_path,
           args.new_ipa_path,
           args.new_bundle_id,
           args.new_bundle_name,
           args.new_entitlements_path,
           args.profile_type)

    return 0

if __name__ == "__main__":
    exit(main())
    
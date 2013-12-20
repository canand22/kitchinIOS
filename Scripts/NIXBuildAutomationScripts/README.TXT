How to use these scripts:

1. Add scripts from latest tag via svn:externals.

2. Copy MAKEFILE.EXAMPLE into Makefile in project root dir. If you already have one, please check it, it could be outdated. Make sure you can see scripts and edit Makefile from the project tree in Xcode.

3. Update settings in Makefile.

4. Add next run script build steps into all targets:

./PATH/TO/SCRIPTS/SaveRevision.sh - this should be executed as the very first step. It's important to run this script before anything starts compiling, because it checks if the working copy is clean.

These ones must be the last steps:

./PATH/TO/SCRIPTS/SaveBuildEnvVars.sh
./PATH/TO/SCRIPTS/UpdateBuildNumber.sh
./PATH/TO/SCRIPTS/UpdateRevisionNumber.sh

5. Add next keys into project's Info.plist:

CFBundleShortVersionString - release version (e.g. 1.3.10)
CFBundleVersion - this will be non-release iteration number (build number, e.g. 1234). Will be changed in built application after UpdateBuildNumber.sh so you can leave value of this key empty
RevisionNumber (string) - this will contain the revision of working copy from which the product is built

6. Define RESIGNED_BUNDLE_ID and RESIGNED_ENTITLEMENTS_PATH custom fields in app target's build settings.

NOTES:
- Don't use other scripts directly. They won't work if running not from project's dir (where *.xcodeproj is located)!
- Please turn off "Show environment variables in build log" option in every single "run script" build phase to make build logs more readable.
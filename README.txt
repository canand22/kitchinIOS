How to configure template project:

o Rename project from "NIXProject" into <your project name>.

o Rename Product Name in target "Application" from "Application" into <your app name>. This will automatically update Bundle Identifier in Info.plist (via BUNDLE_ID target setting).

o In target "Application" update RESIGNED_BUNDLE_ID. It will be set in Info.plist during resigning.

o In target "Application" set RESIGNED_ENTITLEMENTS_PATH if needed.

NOTES:
- Target "Application" is always built for NIX devices. In order to get build for customer devices or Appstore developer must resign the NIX binary from commandline using "make resign_*".
- Do NOT rename existing files such as plists, Prefix.pch, AppDelegate etc. Most probably there's no reason to do it.
- Do NOT rename targets, because build scripts will stop working correctly.
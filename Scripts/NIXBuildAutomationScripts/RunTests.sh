#!/bin/sh -e

# Script which runs tests in iPhone simulator. Requires GHUnit 0.5.2 or later

currentScriptDir=$(cd "$(dirname "$0")"; pwd)

# load build vars
source "${currentScriptDir}/LoadBuildEnvVars.sh"

echo "--- Project dir = ${PROJECT_DIR}"

# clean simulator (installed apps etc)
echo "--- Clean simulator..."
killAll "iPhone Simulator" || TRUE # don't fail if there is no iPhone Simulator running now
IPHONESIM_SUPPORT_DIR=~/Library/Application\ Support/iPhone\ Simulator/
for IOS_VERSION in $(ls "$IPHONESIM_SUPPORT_DIR");
do
    rm -rf "$IPHONESIM_SUPPORT_DIR/$IOS_VERSION"/Applications/*
done

sleep 2

# remove test logs
echo "--- Remove test logs..."
IPHONESIM_LOG_FILE="${BUILT_PRODUCTS_DIR}/iphonesim_log.txt"
if [ -f "$IPHONESIM_LOG_FILE" ]; then
	rm "$IPHONESIM_LOG_FILE"
fi

# launch app in simulator
echo "--- Launch app in simulator..."

# pick needed ios-sim bin by checking version of xcode
SDK_VERSION=$(echo $SDK_NAME | tr -d '[:alpha:]')
APP_PATH="${BUILT_PRODUCTS_DIR}/${EXECUTABLE_NAME}.app"

XCODE_VERSION=$(xcodebuild -version | grep "Xcode" | sed "s/Xcode\ //" | sed "s/\.//g")

while [ "${#XCODE_VERSION}" -lt "3" ]; do
    XCODE_VERSION="${XCODE_VERSION}0"
done

IOS_SIM_NAME="ios-sim"

if [ "${XCODE_VERSION}" -gt "429" ]; then
    IOS_SIM_NAME="${IOS_SIM_NAME}4.3"
fi

RESULTS_DIR="/tmp/test-results"

if [ -d "$RESULTS_DIR" ]; then
    rm -rf "$RESULTS_DIR"
fi

mkdir "$RESULTS_DIR"

# ios-sim is an utility for launching the ios simulator
"${currentScriptDir}/Utils/$IOS_SIM_NAME" launch "$APP_PATH" --sdk $SDK_VERSION --verbose --setenv GHUNIT_AUTORUN=YES --setenv GHUNIT_AUTOEXIT=YES --setenv WRITE_JUNIT_XML=YES --setenv JUNIT_XML_DIR="$RESULTS_DIR" --stdout "$IPHONESIM_LOG_FILE" --stderr "$IPHONESIM_LOG_FILE" || TRUE # could exit with not 0 status, don't care

# print test logs
echo "--- Test logs:"
if [ -f "$IPHONESIM_LOG_FILE" ]; then
	cat "$IPHONESIM_LOG_FILE"
fi

# save JUnit xml output
echo "--- Copy JUnit XML reports..."

if [ -d "./test-results" ]; then
    rm -rf "./test-results"
fi

cp -r "$RESULTS_DIR" . && rm -rf "$RESULTS_DIR"

echo "--- Generated reports:"
if [ -d "./test-results" ]; then
    ls "./test-results"
fi
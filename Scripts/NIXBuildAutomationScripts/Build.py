#!/usr/bin/env python

# Created by Yuri Govorushchenko, 2013

from __future__ import print_function
import argparse
import subprocess


def main():
    # parse args
    parser = argparse.ArgumentParser(description="Wrapper for xcodebuild utility. Doesn't pass empty fields as params.")
  
    parser.add_argument("--sdk", required=True)
    parser.add_argument("--configuration", required=True)
    
    parser.add_argument("--project", help="optional", default="")
    parser.add_argument("--target", help="optional", default="")
    
    parser.add_argument("--workspace", help="optional", default="")
    parser.add_argument("--scheme", help="optional", default="")
    
    parser.add_argument('other', nargs=argparse.REMAINDER, help="other args to be passed to xcodebuild")
    
    args = parser.parse_args()
    
    assert args.sdk, "sdk must not be empty string"
    assert args.configuration, "configuration must not be empty string"

    # process args
    build_args = ["xcodebuild", "-sdk", args.sdk, "-configuration", args.configuration]

    if args.project:
        build_args += ["-project", args.project]

    if args.target:
        build_args += ["-target", args.target]

    if args.workspace:
        build_args += ["-workspace", args.workspace]

    if args.scheme:
        build_args += ["-scheme", args.scheme]

    build_args += args.other

    print("args: {}".format(build_args))

    subprocess.check_call(build_args)

    return 0

if __name__ == "__main__":
    exit(main())

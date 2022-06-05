#!/usr/bin/env python3

"""release.py

to help in managing releases using `standard-version`_.

Usage in this project:
    npm run new_release -- [major | minor | patch]

NOTE: Before running the script, manually bump the version
in docs/conf.py and stage the file 
(TODO: Need to figure out how to automate this as well)

.. _standard-version: https://github.com/conventional-changelog/standard-version
"""

import argparse
import os
import subprocess
import sys

__author__ = "Victor Miti"
__copyright__ = "Copyright 2021, Victor Miti"
__license__ = "MIT"


def release(args=None):
    """Console script entry point"""

    if not args:
        args = sys.argv[1:]

    parser = argparse.ArgumentParser(
        prog="release",
        description="to help in managing releases using standard-version",
    )

    parser.add_argument(
        "release_type", help="The type of release [ minor | major | patch ].", type=str
    )

    args = parser.parse_args(args)

    if args.release_type in ["major", "minor", "patch"]:
        print("let me retrieve the tag we're bumping from ...")
        get_current_tag = subprocess.getoutput(
            "git describe --abbrev=0 --tags `git rev-list --tags --skip=0  --max-count=1`"
        )
        previous_tag = get_current_tag.rstrip()
        # now we can pass result to standard-release
        os.system(
            f'npm run release -- --commit-all --release-as {args.release_type} --releaseCommitMessageFormat "bump: ✈️ {previous_tag} → v{{{{currentTag}}}}"'
        )
        # push to origin
        os.system("git push --follow-tags origin master")
    else:
        print("accepted release types: minor | major | patch")
        print("please try again")
        sys.exit(1)


if __name__ == "__main__":
    unstaged_str = "not staged for commit"
    uncommitted_str = "to be committed"
    check = subprocess.getoutput("git status")
    if unstaged_str not in check or uncommitted_str not in check:
        release()
    else:
        print("Sorry mate, please ensure there are no pending git operations")

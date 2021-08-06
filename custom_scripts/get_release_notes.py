#!/usr/bin/env python3

"""get_release_notes.py

a small script that reads the CHANGELOG.md and extracts
the content for the latest release.

this is meant to be used in a CI/CD setup for automated
GitHub releases.
"""

import os
# from pathlib import Path

__author__ = "Victor Miti"
__copyright__ = "Copyright 2021, Victor Miti"
__license__ = "MIT"


def get_release_notes():
    """extract content from CHANGELOG.md for use in Github Releases

    we read the file and loop through line by line
    we wanna extract content beginning from the first Heading 2 text
    to the last line before the next Heading 2 text
    """
    pattern_to_match = "## [v"

    count = 0
    lines = []
    heading_text = "## What's changed in this release\n"
    lines.append(heading_text)

    with open("CHANGELOG.md", "r") as c:
        for line in c:
            if pattern_to_match in line and count == 0:
                count += 1
            elif pattern_to_match not in line and count == 1:
                lines.append(line)
            elif pattern_to_match in line and count == 1:
                break

    # home = str(Path.home())
    # release_notes = os.path.join(home, "LATEST_RELEASE_NOTES.md")
    release_notes = os.path.join("../", "LATEST_RELEASE_NOTES.md")
    with open(release_notes, "w") as f:
        print("".join(lines), file=f, end="")


if __name__ == "__main__":
    get_release_notes()

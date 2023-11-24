#!/bin/sh

# https://stackoverflow.com/questions/18951276/echoing-date-automated-git-commit

cd /path/to/the/local/repo/directory/ && \
git add . && \
git commit -m "one-click commit: $(date)"  \

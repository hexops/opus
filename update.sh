#!/usr/bin/env bash
set -euo pipefail

git remote add upstream https://gitlab.xiph.org/xiph/opus.git || true
git fetch upstream
git merge upstream/main || true
git status --porcelain | awk '{if ($1=="DU") print $2}' | xargs git rm

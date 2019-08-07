#!/usr/bin/env bash

base=$(dirname "$0")
git_top=$(git rev-parse --show-toplevel)

set -x
cd "${base}" || exit
cat local cmake clion_extras clion deb >"${git_top}/.gitignore"
git add "${git_top}/.gitignore"

cd "${git_top}" || exit
git add "${git_top}/.gitignore"
git status

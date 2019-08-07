#!/usr/bin/env bash
#
# cctheme - cctheme color generator and switcher
# Copyright (C) 2019 Ioannis Tsagkatakis
#
# This file is part of ctheme.
#
# cctheme is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# ctheme is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with cctheme.  If not, see <http://www.gnu.org/licenses/>.
#

dir=$(dirname "$0")

copyright-header --license AGPL3 -g \
                 --add-path "${dir}/../src"  \
                 --output-dir "${dir}/../" \
                 --copyright-holder 'Ioannis Tsagkatakis' \
                 --copyright-software 'cctheme' \
                 --copyright-software-description 'cctheme terminal apps color generator and switcher' \
                 --copyright-year 2019

# Reset submodules
git submodule foreach git reset --hard

# Reset ext
git checkout HEAD -- src/ext

cd "${dir}/.."
git status
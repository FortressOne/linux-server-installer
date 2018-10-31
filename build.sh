#!/usr/bin/env bash

VERSION="0.1.0"

makeself bin/ "fortressonesv-${VERSION}.run" 'FortressOne Server - A QuakeWorld Team Fortress server installer' ./setup.sh

cp README_TEMPLATE.md README.md
sed -i "s|VERSION|${VERSION}|g" README.md

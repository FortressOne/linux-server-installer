#!/usr/bin/env bash

VERSION="0.1.1"

makeself bin/ "fortressonesv-${VERSION}.run" 'FortressOne Server - QuakeWorld Team Fortress server package for Linux' ./setup.sh

cp README_TEMPLATE.md README.md
sed -i "s|VERSION|${VERSION}|g" README.md

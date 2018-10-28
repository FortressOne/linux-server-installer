#!/usr/bin/env bash

mkdir -p /tmp/fortressonesv/
cp setup.sh /tmp/fortressonesv
cp uninstall.sh /tmp/fortressonesv
rm -rf *
cp /tmp/fortressonesv/* .
rm -rf /tmp/fortressonesv/

rm -rf $HOME/bin/fortressonesv/

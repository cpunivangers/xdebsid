#!/bin/bash

# raz https://github.com/cpunivangers/madebNN
VERSION=$(date +%y%m%d.%H%M)

rm -rf .git
# ajout le 25/09/2026 sinon branche master par defaut
git config --global init.defaultBranch main
git init
git config user.email "christian.pottier@univ-angers.fr"
git config user.name "cpunivangers"
git remote add origin git@github.com:cpunivangers/xdebsid.git
#~ echo "$VERSION" > Version.txt
git add -A
git commit -m "Version $VERSION"
git push -f origin main
git tag -a $VERSION -m "Version $VERSION"
git push origin $VERSION
#~ git release $VERSION -c

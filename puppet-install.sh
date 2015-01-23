#!/bin/bash

TARGET_VERSION="3.7.1"
CURRENT_VERSION=`puppet --version`
echo "Checking Puppet version..."
echo "    Current: $CURRENT_VERSION"
echo "    Target: $TARGET_VERSION"

#if command -v puppet >/dev/null 2>&1; then
if [[ $CURRENT_VERSION < $TARGET_VERSION ]]; then
  echo "Installing Puppet $TARGET_VERSION..."
  wget --quiet -O /tmp/puppetlabs-release-trusty.deb https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
  sudo dpkg -i /tmp/puppetlabs-release-trusty.deb
  sudo apt-get update -qq
  sudo apt-get install -qq puppet
else
  echo "Puppet is up to date"
fi

echo "Installing Puppet Modules..."
puppet module install puppetlabs-apt
puppet module install puppetlabs-vcsrepo
puppet module install maestrodev-wget

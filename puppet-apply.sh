#!/bin/bash

sudo puppet apply --confdir=conf --modulepath=modules:~/.puppet/modules manifests/default.pp

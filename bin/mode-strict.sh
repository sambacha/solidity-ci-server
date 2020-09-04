#!/bin/bash
# SPDX-License-Identifier: MPL-2.0
# `strict enforcement script`

echo " ◉ Strict Pragma Enforcement Enabled "
echo -ne '==> Checking Solidity Pragma...\r'

git grep -Ln 'pragma solidity' * > pragma_version \
    ':^.git*' ':^.ci/*' ':^.solidity-ci.yml' \
    ':^README' ':^MAINTAINERS' ':^VERSION' \
    ':^*/packages' ':^*/README' \
    ':^deployments/' ':^contracts/' ':^src' ':^migrations/' \
    ':^*.sol' ':^*.txt'

echo
echo " Files with the same solidity version "
echo ".____________________________________. "

git grep -l 'pragma solidity' | \
    xargs grep -l 'Redistribution'

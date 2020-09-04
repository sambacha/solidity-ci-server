#!/usr/bin/env bash

alert_lev="$1"
alert_msg="$2"

if [[ -z "$alert_lev" || -z "$alert_msg" ]]
then
    echo "Settings Require either: 1=alert_lev  - or - 2=alert_msg"
    exit 1
fi

if [[ $alert_lev -gt 0 ]]; then
    echo "$alert_msg" | email --username "${USER_EMAIL@ADDRESS}" --from "Solidity-CI Monitor <alerts@solidity-ci.com>" --subject "[ 🆘 - Detection Triggered - 🆘 ][$alert_lev-alert]" --cc records@solidity-ci.com ${USER_EMAIL2@ADDRESS.COM}
fi

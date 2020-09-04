#!/bin/bash
tail -F $HOME/.ethereum/mainnet/mlogs/geth.log | ~/dev/eth/geth-supervisor.sh/mlog-event-pipe.sh
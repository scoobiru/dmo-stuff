# Some simple scripts

This folder contains some example scripts where values are set for parameters which are then used to craft the miner command execution line. This allows for quick duplication of the script for the alternate hosts, wallets, settings, etc.
As currently written, the script should live in the same folder as the binary.

### Loop testing
ALso included in the basic loop scripts are a timed kill loop whereby the compute and workitems parameters are set within the loop. This allows for the values to be adjusted while testing, such that the script can be updated with new values while running. To re-launch the miner with the new parameters, press any key with the original script terminal window in focus.
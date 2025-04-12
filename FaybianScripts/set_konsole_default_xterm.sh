#!/bin/bash

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/konsole 50
sudo update-alternatives --config x-terminal-emulator

# run x-terminal-emulator to verify

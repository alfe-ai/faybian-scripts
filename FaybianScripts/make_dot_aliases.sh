#!/bin/bash
# Creates the .alfe directory and symlinks for git,
# ensuring ~/git points directly to /mnt/part5/dot_fayra/Whimsical/git.
# Removes any existing symlinks before creation.

mkdir -p "${HOME}/.alfe"

if [ -L "${HOME}/.alfe/git" ]; then
    rm -f "${HOME}/.alfe/git"
fi
ln -s "${HOME}/.fayra/Whimsical/git" "${HOME}/.alfe/git"

if [ -L "${HOME}/git" ]; then
    rm -f "${HOME}/git"
fi
ln -s "${HOME}/.fayra/Whimsical/git" "${HOME}/git"

echo "Directory ~/.alfe ensured. Symlinks ~/.alfe/git and ~/git created (overwriting old symlinks)."

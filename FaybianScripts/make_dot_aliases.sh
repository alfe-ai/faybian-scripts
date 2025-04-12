#!/bin/bash
# Creates the .alfe directory and symlinks for git,
# ensuring ~/git points directly to /mnt/part5/dot_fayra/Whimsical/git.

mkdir -p "${HOME}/.alfe"

# Create a direct link from ~/.alfe/git to /mnt/part5/dot_fayra/Whimsical/git
if [ ! -L "${HOME}/.alfe/git" ]; then
    ln -s "/mnt/part5/dot_fayra/Whimsical/git" "${HOME}/.alfe/git"
fi

# Create a direct link from ~/git to the same destination
if [ ! -L "${HOME}/git" ]; then
    ln -s "/mnt/part5/dot_fayra/Whimsical/git" "${HOME}/git"
fi

echo "Directory ~/.alfe ensured. Symlinks fixed for ~/git."

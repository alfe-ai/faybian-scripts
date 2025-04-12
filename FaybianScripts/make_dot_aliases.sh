#!/bin/bash
# Creates the .alfe directory and symlinks for git

mkdir -p "${HOME}/.alfe"
if [ ! -L "${HOME}/.alfe/git" ]; then
    ln -s "${HOME}/.fayra/Whimsical/git" "${HOME}/.alfe/git"
fi

if [ ! -L "${HOME}/git" ]; then
    ln -s "${HOME}/.fayra/Whimsical/git" "${HOME}/git"
fi

echo "Directory ~/.alfe ensured. Symlinks ~/.alfe/git and ~/git created."

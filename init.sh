#!/bin/bash
# Run this when freshly cloning this repo, it sets up the submodules

initmodule()
{
    for path in `cat .gitmodules | sed -n 's/^\s//; s/path = //p'`; do
        git submodule init $path
        git submodule update $path
        pushd $path
        git checkout master
        # Recursively set up any nested subrepos
        if [[ -f .gitmodules ]]; then
            initmodule
        fi
        popd
    done
}
initmodule

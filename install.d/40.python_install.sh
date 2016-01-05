#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "$EUID" -ne 0 ]; then 

    # Make python2 and python3 virtual environments.

    if [ ! -e ~/.local/bin/python3 ]; then
        virtualenv --python=python3 --system-site-packages ~/.local
    fi
    if [ ! -e ~/.local/bin/python2 ]; then
        virtualenv --python=python2 --system-site-packages ~/.local
    fi

    # Install useful packages.

    ~/.local/bin/pip3 install   \
         --upgrade pip          \
        bumpversion             \
        cookiecutter            \
        docopt                  \
        ipython                 \
        know_its_ok             \
        more_itertools          \
        nonstdlib               \
        pytest                  \
        pytest_cov              \
        sh                      \

fi

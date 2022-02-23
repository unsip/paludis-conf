#!/bin/bash
#
# Configure environment for paludis
#

LC_ALL=en_US.UTF-8

AM_OPTS="--ignore-deps"
CMAKE_SILENT=1

ARCH_FLAGS="-march=native"
CFLAGS="-O2 -ggdb -pipe -ftree-vectorize ${ARCH_FLAGS}"
# Suppress useless warnings about unused local typedefs appeared for some packages
CXXFLAGS="${CFLAGS} -Wno-unused-local-typedefs"
LDFLAGS="-Wl,-O1 -Wl,--sort-common -Wl,--as-needed"

x86_64_pc_linux_gnu_CFLAGS="${CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${CXXFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${LDFLAGS}"

# Suppress warnings from hooks
PALUDIS_FILESYSTEM_HOOK_NO_WARNING=yes

# Setup per package environment
[[ -e /usr/libexec/paludis-hooks/setup_pkg_env.bash ]] && source /usr/libexec/paludis-hooks/setup_pkg_env.bash

# Detect terminal width dynamically for better [ ok ] align
save_COLUMNS=${COLUMNS}
COLUMNS=$(stty size 2>/dev/null | cut -d' ' -f2)
test -z "${COLUMNS}" && COLUMNS=${save_COLUMNS}
unset save_COLUMNS
PALUDIS_ENDCOL=$'\e[A\e['$(( ${COLUMNS:-80} - 7 ))'G'


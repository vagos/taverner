#!/usr/bin/env bash
# Title: "title" (PC "year")

# An example template for wine programs

# This is an array as some programs may take arguments, e.g. `foo.exe /S /t`
executable=()

# The prefix is the same as the WINEPREFIX, it gets exported later on
prefix=""

# This example template assume the WINEPREFIX's name and path under C:\ is the 
# same, if it's not, use an alternative path.
# E.g. My prefix might be "game_1.2" but the path is "game"
alt_path=""

# Title and resolution passed to the Virtual Desktop, no one uses wine without
# them, NO ONE! ಠ_ಠ
title=""
resolution=""

# Export any environment variables, useful in some cases, e.g.
export __GL_THREADED_OPTIMIZATIONS=1 
export WINEPREFIX="$prefix"

# From here on, most of the rest is just script logic based on the above

# Get the current resolution if not defined
if [[ -z "$resolution" ]]; then
    # Exit after the first match
    resolution=$(xrandr | awk '/ connected/ { print $3; exit }')
fi

# Build the command based on above variables
wineopts=(explorer /desktop="$title","$resolution")

# If we see arguments, pass them directly to wine instead, useful for running
# winecfg, cmd or regedit on the prefix.  e.g. `foogame regedit` will instead
# of launching `foogame`, open `regedit` using `foogame`s prefix, awesomecakes
if (($# > 0)); then
    executable=("$@")
fi

# Blah blah
cd "$prefix"/drive_c/"${alt_path:-${prefix##*/}}"

# We use `exec` here, but if you wanted to actually do any clean up which is
# sadly needed for some games, remove the call to exec and do clean up after
exec wine "${wineopts[@]}" "${executable[@]}"

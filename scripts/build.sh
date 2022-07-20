#!/bin/bash

## Environment ##
REPO_ROOT=`git rev-parse --show-toplevel`

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   echo "Script for building leetcode solutions."
   echo
   echo "Syntax: ./build.sh [-v|-h]"
   echo "Options:"
   echo "-v|--verbose Enables verbose output."
   echo "-h|--help	Prints this usage."
   echo
}


################################################################################
################################################################################
# Main program                                                                 #
################################################################################
################################################################################

## Parse command line arguments ##
POSITIONAL=()
while [[ $# -gt 0 ]]; do
   key="$1"

   case $key in
      -v|--verbose)
         set -x
         shift
         ;;
      -h|--help)
         Help
         shift
         exit
         ;;
      *)    # unknown option
         shift
         ;;
   esac
done

## List of build targets to generate build environments for ##
declare -a targets=("linux-x86_64")

for target in "${targets[@]}"; do
   ## Create build directories ##
   mkdir -p $REPO_ROOT/build/$target

   ## Fetch dependencies using Conan (skip target if we failed to fetch) ##
   if ! conan install -if $REPO_ROOT/build/$target .; then continue; fi

   ## Configure and generate build environment with CMake ##
   cmake --preset=$target -S $REPO_ROOT -B $REPO_ROOT/build/$target

   ## build ##
   cmake --build $REPO_ROOT/build/$target -- VERBOSE=$VERBOSE
done

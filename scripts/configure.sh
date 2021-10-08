#!/bin/bash

## Global Variables ##
REPO_ROOT=`git rev-parse --show-toplevel`

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   echo "Project's build configuration script."
   echo
   echo "Syntax: ./configure.sh [-v|-h]"
   echo "Options:"
   echo "-v|--verbose Enables verbose output."
   echo "-h|--help    Prints this usage."
   echo
}

################################################################################
# echo_cmd                                                                     #
################################################################################
echo_cmd()
{
   if [[ -v VERBOSE ]]; then printf '%s\n' "${*}"; "${@}"; else "${@}"; fi; echo
}

################################################################################
################################################################################
# Main Program                                                                 #
################################################################################
################################################################################

## Parse command line arguments ##
POSITIONAL=()
while [[ $# -gt 0 ]]; do
   key="$1"

   case $key in
      -v|--verbose)
         VERBOSE=1
         shift
         ;;
      -h|--help)
         Help
         shift
         exit
         ;;
      *)
         Help
         shift
         exit
         ;;
      esac
done

## List of build targets to generate build environments for ##
declare -a targets=("linux-x86_64")

for target in "${targets[@]}"; do
   ## Create build directories ##
   echo_cmd mkdir -p $REPO_ROOT/build/$target

   ## Fetch dependencies using Conan (skip target if we failed to fetch) ##
   if ! conan install -if $REPO_ROOT/build/$target .; then continue; fi

   ## Configure and generate build environment with CMake ##
   cmake --preset=$target
done

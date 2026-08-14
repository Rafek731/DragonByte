#!/usr/bin/env bash

set -euo pipefail

function usage() {
     echo "Usage: $(basename "$0") [-d] <year> <stage> <problem>" >&2
}

if [ $# -eq 0 ]; then
    usage; exit 1
fi

DIR_BEFORE_SCRIPT=$(pwd)
REPO_ROOT="$(dirname $(realpath "$0"))"
TEMPLATES="$REPO_ROOT/utils/templates"

add=true

while getopts "hd" opt; do
    case "${opt}" in
        d) 
            add=false 
            ;;
        h) 
            usage
            exit 0 
            ;;
        \?) 
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

year="${1:-}"
stage="${2:-}"
problem="${3:-}"

if [ -z "$year" ] || [ -z "$stage" ] || [ -z "$problem" ]; then
    echo "Error: Missing arguments." >&2 ; usage
    exit 1
fi

function create_dir_and_cmake() {
    dir=$1
    
    mkdir -p "$dir"
    echo "add_subdirectory($dir)" | sed 's/[[:space:]]//g' >> CMakeLists.txt
    sort -uo CMakeLists.txt CMakeLists.txt
}

function fill_problem_dir() {
    target="$year"_"$stage"_"$problem"
    target_short="$problem"
    problemName="$(tr -d '[[:space:]]' <<< "$problem")"
    sed "s/#TARGET#/$target/g" "$TEMPLATES/cmake_targets.template" | sed "s/#TARGET_SHORT#/$target_short/g" > CMakeLists.txt
    mkdir -p input output answer src
    sed "s/#problemName#/$problemName/g" "$TEMPLATES/solve.template" > src/solve.cpp
    cp "$TEMPLATES/check.template" src/check.cpp
}

function add_problem() {
    cd "$REPO_ROOT/competitions"
    create_dir_and_cmake "$year"
    cd "$year"
    create_dir_and_cmake "$stage"
    cd "$stage"
    create_dir_and_cmake "$problem"
    cd "$problem"

    if ! [ -z "$(ls -A)" ]; then
        echo "Error: problem already exists"
        exit 1
    fi

    fill_problem_dir
    cd "$REPO_ROOT"
}

function remove_problem() {
    mkdir -p "$REPO_ROOT/competitions/$year/$stage/$problem"
    
    cd "$REPO_ROOT/competitions/$year/$stage"
    rm -rf "$problem"
    touch CMakeLists.txt
    sed -i "/add_subdirectory($problem)/d" CMakeLists.txt
    if ! grep -q '[^[:space:]]' CMakeLists.txt 2>/dev/null; then
        rm CMakeLists.txt
    else 
        return
    fi

    cd ..
    if [ -z "$(ls -A "$stage")" ]; then
        rm -rf "$stage"
    fi
    touch CMakeLists.txt
    sed -i "/add_subdirectory($stage)/d" CMakeLists.txt
    if ! grep -q '[^[:space:]]' CMakeLists.txt 2>/dev/null; then
        rm CMakeLists.txt
    else
        return
    fi

    cd ..
    if [ -z "$(ls -A "$year")" ]; then
        rm -rf "$year"
    fi
    touch CMakeLists.txt
    sed -i "/add_subdirectory($year)/d" CMakeLists.txt
    if ! grep -q '[^[:space:]]' CMakeLists.txt 2>/dev/null; then
        rm CMakeLists.txt
    fi
}



if [ "$add" = true ]; then
    add_problem
else
    remove_problem
fi

cd "$DIR_BEFORE_SCRIPT"
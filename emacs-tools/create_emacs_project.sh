#!/bin/bash
# This file is used to create EDE project files for C/C++ project, used for Emacs.

function log() {
    echo `date +"%Y-%m-%d %H:%M:%S"` $* 
}

function add_to_gitignore() {
    x=`grep $1 $gitfile`
    if [ "x$x" == "x" ]; then
        log "Append \"$1\" to $gitfile"
        echo "$1" >> $gitfile
    fi
}

if [ $# -ne 1 ]; then
    echo "Usage $0 project_path"
    exit 1;
fi

# cd project's path, and get the absolute path
cd $1
os=`uname | grep MINGW`
if [ "x$os" != "x" ]; then
    base_path=`pwd | awk '{disk=substr($0, 2, 1); print toupper(disk)":"substr($0, 3)}'`
else
    base_path=`pwd`
fi
log "Base_path: ${base_path}"

# Make sure the .gitignore file do exist
touch ".gitignore"

# Generate tags with GNU global
gtags

# Generate cscope database
cscope-indexer -r

# Create project dir
proj_dir=".emacsprj"
if [ ! -d ${proj_dir} ]; then
    log "mkdir '${proj_dir}'"
    mkdir ${proj_dir}
fi
cd ${proj_dir}

# get include path
inc_dirs=`find ".." -name "*.h" | awk '{n=split($0, a, "/"); print substr($0, 0, length($0) - length(a[n]))}' | sort | uniq`

# create EDE project file
ede_file="ede-project.el"
log "Create file '$ede_file' ..."
echo "(ede-cpp-root-project \"NAME\" :file (expand-file-name \".gitignore\"  current-dir)" > $ede_file
echo "    :include-path '(" >> $ede_file
for one in $inc_dirs
do
    echo "        \"${one##..}\"" >> $ede_file
done
echo "    )" >> $ede_file
echo ")" >> $ede_file

# add directory '.emacsprj' to git's ignore list 
cd ..
gitfile=".git/info/exclude"
if [ -f $gitfile ]; then
    add_to_gitignore "${proj_dir}/"
    add_to_gitignore "GPATH"
    add_to_gitignore "GRTAGS"
    add_to_gitignore "GTAGS"
    add_to_gitignore "cscope.files"
    add_to_gitignore "cscope.out"
fi

log "Exit."


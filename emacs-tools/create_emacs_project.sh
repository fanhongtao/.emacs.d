#!/bin/bash
# This file is used to create EDE project files for C/C++ project, used for Emacs.

function log() {
    echo `date +"%Y-%m-%d %H:%M:%S"` $* 
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

# create project dir
proj_dir=".emacsprj"
if [ ! -d ${proj_dir} ]; then
    log "mkdir '${proj_dir}'"
    mkdir ${proj_dir}
fi
cd ${proj_dir}



# create cscope file
log "Create file 'cscope.files' ..."
find ${base_path} -name "*.[ch]" -o -name "*.cpp" -o -name "*.inl" > cscope.files
cscope -bq

# create ctag file
log "Create file 'tags' ..."
ctags --fields=+aiS --C++-types=+p --extra=+q -L cscope.files

# get include path, so that we can use 'Ctrl-Wgf' or 'Ctrl-gf' to open a include file with filename under cursor 
inc_dirs=`grep "\.h$" cscope.files | awk '{n=split($0, a, "/"); print substr($0, 0, length($0) - length(a[n]))}' | sort | uniq`
tmppath=":include-path '( "
for one in $inc_dirs
do
    tmppath+="\""${one}"\" "
done
tmppath+=" )"

# create EDE project file
log "Create file 'ede-project.el' ..."
echo "(ede-cpp-root-project \"NAME\" :file (expand-file-name \".gitignore\"  current-dir) 
    $tmppath
    )" > ede-project.el

# add directory '.emacsprj' to git's ignore list 
cd ..
file=".git/info/exclude"
if [ -f $file ]; then
    x=`grep ${proj_dir} $file`
    if [ "x$x" == "x" ]; then
        log "Change Git's exclude file."
        echo "${proj_dir}/" >> $file
    fi
fi

log "Exit."


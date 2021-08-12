current_folder=`pwd`

set -x
git submodule update --remote --recursive
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git switch $branch'
set +x
current_folder=`pwd`
remote_url=`git config --get remote.origin.url`
echo $remote_url | grep -Eq ^https && remote_protocol="https"  || remote_protocol="git"
if [ "$remote_protocol" = "https" ]; then
   echo "Clone repos using https..."
   base_url="https://github.com/"
else
   echo "Clone repos using git..."
   base_url="git@github.com:"
fi
# example git URLs, https v.s. git
# https://github.com/biothings/BioThings_Explorer_TRAPI.git
# git@github.com:biothings/BioThings_Explorer_TRAPI.git

set -x
git submodule update --init --recursive
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git switch $branch'

cd "./packages/@biothings-explorer/call-apis"
ln -s ../../../scripts/tsconfig.json_call-apis ./tsconfig.json
cd $current_folder

cd "./packages/@biothings-explorer/bte-trapi"
ln -s ../../../scripts/tsconfig.json_bte-trapi ./tsconfig.json
# no need to do this after we commit the package name change to the repo
if [ "$(uname)" = "Darwin" ]; then
    # sed on mac has a workaround to make it work
    sed -i '' 's/single-hop-app/bte-trapi/g' package.json
else
    sed -i 's/single-hop-app/bte-trapi/g' package.json
fi
cd $current_folder

set +x

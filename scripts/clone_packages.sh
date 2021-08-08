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
git submodule add $base_url"biothings/BioThings_Explorer_TRAPI.git" "./packages/@biothings-explorer/bte-trapi"
git submodule add $base_url"biothings/bte_trapi_query_graph_handler.git" "./packages/@biothings-explorer/query_graph_handler"
git submodule add $base_url"biothings/biolink-model.js.git" "./packages/biolink-model"
git submodule add $base_url"biothings/biomedical_id_resolver.js.git" "./packages/biomedical_id_resolver"
git submodule add $base_url"biothings/smartapi-kg.js.git" "./packages/@biothings-explorer/smartapi-kg"
git submodule add $base_url"biothings/call-apis.js.git" "./packages/@biothings-explorer/call-apis"
git submodule add $base_url"biothings/api-respone-transform.js.git" "./packages/@biothings-explorer/api-response-transform"

git submodule init
git submodule update

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

current_folder=`pwd`

echo '# Generated from "npm run get_rev" on ' $(date)

echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`

cd ./packages/@biothings-explorer/bte-trapi
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

cd ./packages/@biothings-explorer/query_graph_handler
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

cd ./packages/biolink-model
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

cd ./packages/biomedical_id_resolver
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

cd ./packages/@biothings-explorer/smartapi-kg
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

cd ./packages/@biothings-explorer/call-apis
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

cd ./packages/@biothings-explorer/api-response-transform
echo `git ls-remote --get-url` `git rev-parse --short HEAD` `git rev-parse HEAD`
cd $current_folder

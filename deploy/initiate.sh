#!/bin/bash
set -e

### Configuration ###

SERVER=root@68.183.68.55
APP_DIR=/var/www/chai
KEYFILE=
REMOTE_SCRIPT_PATH=/tmp/deploy-myapp.sh


### Library ###

function run()
{
  echo "Running: $@"
  "$@"
}


### Automation steps ###

if [[ "$KEYFILE" != "" ]]; then
  KEYARG="-i $KEYFILE"
else
  KEYARG=
fi


run meteor build --server-only --architecture os.linux.x86_64 ../output
mv ../output/*.tar.gz ./package.tar.gz

run scp $KEYARG package.tar.gz $SERVER:$APP_DIR/
run scp $KEYARG deploy/work.sh $SERVER:$REMOTE_SCRIPT_PATH
echo
echo "---- Running deployment script on remote server ----"
run ssh $KEYARG $SERVER bash $REMOTE_SCRIPT_PATH
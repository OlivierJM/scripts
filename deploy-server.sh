#!/bin/bash
# here you put the directory name of your app
APP_DIR=/var/www/musanga-app
# RESTART_ARGS=
# remember to name the package name as package.tar.gz otherwise it will fail
# Extract newly uploaded package
mkdir -p $APP_DIR/tmp
cd $APP_DIR/tmp
tar xzf $APP_DIR/package.tar.gz
rm -f $APP_DIR/package.tar.gz

# Install dependencies
cd $APP_DIR/tmp/bundle/programs/server
npm install --production
npm prune --production

# Switch directories, restart app

mv $APP_DIR/bundle.old $APP_DIR/bundle-old.old
mv $APP_DIR/bundle $APP_DIR/bundle.old
mv $APP_DIR/tmp/bundle $APP_DIR/bundle
cp -r $APP_DIR/bundle.old/public $APP_DIR/bundle/  #move the public folder to the new bundle

# restart the app in bundle
passenger-config restart-app $APP_DIR/bundle

# passenger-config restart-app --ignore-app-not-running --ignore-passenger-not-running $RESTART_ARGS $APP_DIR/bundle
# rm -rf $APP_DIR/bundle.old

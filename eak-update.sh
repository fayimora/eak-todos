#!/bin/bash
# Ember app kit version update
APPDIR="/Users/fayimora/Code/Javascript/Ember/eak-todos"
PATCHDIR="/tmp/eakpatch"
EAKDIR="/tmp/ember-app-kit-master"

echo "Updating the local clone"
cd ${EAKDIR}
git pull origin master
cd ${APPDIR}

# first generate patches of important files
FILES="bower.json package.json Gruntfile.js karma.conf.js .jshintrc .bowerrc" # app/app.js app/adapters/application.js"

echo "Patching application code with updates"
mkdir -p ${PATCHDIR}

for i in ${FILES}
do
  mkdir -p ${PATCHDIR}/$(dirname ${i})
  diff -Nau ${APPDIR}/${i} ${EAKDIR}/${i} > ${PATCHDIR}/${i}
  patch ${APPDIR}/${i} ${PATCHDIR}/${i}
done

echo "updating tasks directory"
rm -rf ${APPDIR}/tasks/*
cp -r ${EAKDIR}/tasks/* ${APPDIR}/tasks/

cd ${APPDIR}
echo "running npm update"
npm update

echo "running bower update"
bower update

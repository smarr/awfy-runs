#!/bin/bash
#AWFY_REF=`(cd awfy && git rev-parse HEAD)`
PARAMS=("-d" "--without-nice" "--commit-id=\"$CI_BUILD_REF\"" "--environment=Infinity Ubuntu" "--project=AWFY" "--branch=\"$CI_BUILD_REF_NAME\"")
rebench "${PARAMS[@]}" codespeed.conf all

# rebench -d --without-nice codespeed.conf steady-java
# rebench -d --without-nice codespeed.conf steady-crystal
# rebench -d --without-nice codespeed.conf steady-js
# rebench -d --without-nice codespeed.conf ruby-others
# rebench -d --without-nice codespeed.conf steady-ruby
# rebench -d --without-nice codespeed.conf steady-som
# rebench -d --without-nice codespeed.conf pharo
# rebench -d --without-nice codespeed.conf all

DATA_ROOT=~/benchmark-results/are-we-fast-yet

REV=`git rev-parse HEAD | cut -c1-8`

NUM_PREV=`ls -l $DATA_ROOT | grep ^d | wc -l`
NUM_PREV=`printf "%03d" $NUM_PREV`

TARGET_PATH=$DATA_ROOT/$NUM_PREV-$REV
LATEST=$DATA_ROOT/latest

mkdir -p $TARGET_PATH
cp benchmark.data $TARGET_PATH/
rm $LATEST
ln -s $TARGET_PATH $LATEST
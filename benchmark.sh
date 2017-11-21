#!/bin/bash
#AWFY_REF=`(cd awfy && git rev-parse HEAD)`
# CI_BUILD_REF=2cd905bd67a061705eaf8098832f49886d5c9de2
PARAMS=("-d" "--without-nice" "--commit-id=$CI_BUILD_REF" "--environment=Infinity Ubuntu" "--project=AWFY" "--branch=$CI_BUILD_REF_NAME")
git submodule update --recursive

# (cd awfy && ./implementations/setup.sh)

rebench -f "${PARAMS[@]}" codespeed.conf fj-java


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

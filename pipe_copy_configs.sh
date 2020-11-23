#!/bin/bash -x

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_SRC_DIR}"/env.sh

CFG_REPO_LOCAL_PATH=$1
CFG_REPO_URL=$2
CFG_VERSION_TAG=$3

rm   -rf ${CFG_REPO_LOCAL_PATH}
mkdir -p ${CFG_REPO_LOCAL_PATH}
git clone --branch ${CFG_VERSION_TAG} ${CFG_REPO_URL} ${CFG_REPO_LOCAL_PATH}
rm -rf   ${CFG_REPO_LOCAL_PATH}/.git  ${CFG_REPO_LOCAL_PATH}/bitbucket-pipelines.y*ml ${CFG_REPO_LOCAL_PATH}/pom.xml

echo "FINISHED" 

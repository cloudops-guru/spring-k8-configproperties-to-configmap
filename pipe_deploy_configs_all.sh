#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_SRC_DIR}"/env.sh

SRC_PATH_BASE=$1


echo "all:  SRC_PATH_BASE $SRC_PATH_BASE   ENVIRONMENTS  ${ENVIRONMENTS} "


deploy() {
  for environment in $ENVIRONMENTS; do
     ${SCRIPT_SRC_DIR}/pipe_deploy_configs_env.sh  "${environment}"
  done
}
deploy






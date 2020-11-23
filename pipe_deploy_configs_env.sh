#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_SRC_DIR}"/env.sh

ENVIRONMENT=$1
echo "    env:  ENVIRONMENT   " ${ENVIRONMENT}


deploy_env() {
  local env=$1

  # the historical global files
  local src_path="${CONFIG_MAP_PATH_BASE}/${env}"
  # placeholder for the global config map file
   ${SCRIPT_SRC_DIR}/pipe_deploy_configs_file.sh  "$env" "${src_path}/application-env.yml"

  src_path="${src_path}/imported"
  ${SCRIPT_SRC_DIR}/pipe_deploy_configs_file.sh  "$env" "${src_path}/application.yml"
  ${SCRIPT_SRC_DIR}/pipe_deploy_configs_file.sh  "$env" "${src_path}/application-env.yml"

  for service in $SERVICES; do 
      ${SCRIPT_SRC_DIR}/pipe_deploy_configs_service.sh  "${env}" "${service}"
  done

}
deploy_env $ENVIRONMENT






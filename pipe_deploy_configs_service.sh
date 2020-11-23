#!/bin/bash -x

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_SRC_DIR}"/env.sh

ENVIRONMENT=$1
SERVICE=$2

echo "      service:  ENVIRONMENT ${ENVIRONMENT}  SERVICE      ${SERVICE} "

deploy_service() {
  local env=$1
  local service=$2
  local src_path="${CONFIG_MAP_PATH_BASE}/${env}/imported"

  ${SCRIPT_SRC_DIR}/pipe_deploy_configs_file.sh $env "${src_path}/${service}.yml"
  ${SCRIPT_SRC_DIR}/pipe_deploy_configs_file.sh $env "${src_path}/${service}-env.yml"
}

deploy_service ${ENVIRONMENT} ${SERVICE}






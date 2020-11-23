#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_SRC_DIR}"/env.sh

ENVIRONMENT=$1
CFG_MAP_FILE=$2

echo "        file:  ENVIRONMENT   ${ENVIRONMENT} CFG_MAP_FILE  ${CFG_MAP_FILE} "

deploy_file() {
  local environment=$1
  local cfg_map_file=$2

   if [ -f "$cfg_map_file" ]; then
        echo "          found:   $cfg_map_file"
   else
        # echo "$cfg_map_file does not exist"
        return 0
   fi

   kubectl replace -f $cfg_map_file -n $environment
   if [ $? -eq 0 ];  then
       echo "  $cfg_map_file replaced "
   else
       kubectl apply -f $cfg_map_file -n $environment
      echo "  $cfg_map_file applied "
   fi

}
deploy_file ${ENVIRONMENT} ${CFG_MAP_FILE}






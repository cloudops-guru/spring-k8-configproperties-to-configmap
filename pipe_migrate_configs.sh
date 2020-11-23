#!/bin/bash -x

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_SRC_DIR}"/env.sh

SRC_PATH_BASE=$1
CFG_MAP_VER=$2


migrate_file() {
   local orig_cfg_file=$1
   local cfg_map_file=$2
   local cfg_map_name=$3
   local environment=$4
   local cfg_map_ver=$5

   cp $orig_cfg_file $orig_cfg_file.$environment
   cfg_file=$orig_cfg_file.$environment

   if [ -f "$cfg_file" ]; then
        echo "  found:   $cfg_file"
   else
        # echo "$cfg_file does not exist"
        return 0
   fi

  local tmp_file=""
  local cfg_file_name=`basename ${cfg_file}`
  local cfg_map_file_name=`basename ${cfg_map_file}`

  # empty lines are fine but they cannot have spaces
  tmp_file=/tmp/${cfg_file_name}.cfg
  sed  's/ *$//g' $cfg_file  > $tmp_file
  cp    ${tmp_file} $cfg_file

  #  # append the verion to the file
  tmp_file=/tmp/${cfg_file_name}.cfg
  cfg_name=`basename ${cfg_file} | cut -f1 -d'.'`
  cp    ${cfg_file} ${tmp_file}
  echo ""         >> ${tmp_file}
  echo "config:"           >> ${tmp_file}
  echo "  ver: ${cfg_name}_${cfg_map_ver}" >> ${tmp_file}
  echo ""         >> ${tmp_file}
  cp    ${tmp_file} $cfg_file

  kubectl create configmap \
          $cfg_map_name \
           --from-file=$cfg_file \
           -o yaml --dry-run > $cfg_map_file

  # the filename referenced in the cfg map file needs to be application.yml
  tmp_file=/tmp/${cfg_map_file_name}.map
  sed  "s/${cfg_file_name}/application.yml/g" ${cfg_map_file}  > ${tmp_file}
  cp    ${tmp_file} $cfg_map_file

  echo  "  namespace: ${environment}" >> $cfg_map_file

}


migrate_env() {
  local env=$1
  local src_path="${2}"
  local cfg_map_ver="${3}"
  local dst_path="${CONFIG_MAP_PATH_BASE}/${env}/imported"
  echo "*****   $dst_path "
  # git rm -rf $dst_path
  mkdir -p $dst_path

  migrate_file "${src_path}/application.yml"        "${dst_path}/application.yml"      application     $env ${cfg_map_ver}
  migrate_file "${src_path}/application-${env}.yml" "${dst_path}/application-env.yml"  application-env $env ${cfg_map_ver}

  for service in $SERVICES; do
      migrate_file "${src_path}/${service}.yml"        "${dst_path}/${service}.yml"      ${service}     $env ${cfg_map_ver}
      migrate_file "${src_path}/${service}-${env}.yml" "${dst_path}/${service}-env.yml"  ${service}-env $env ${cfg_map_ver}
  done
}

migrate() {
  local cfg_map_ver="${1}"
  for environment in $ENVIRONMENTS; do
     echo "     env: $environment"
     migrate_env $environment "${SRC_PATH_BASE}" ${cfg_map_ver}
  done
}
migrate ${CFG_MAP_VER}






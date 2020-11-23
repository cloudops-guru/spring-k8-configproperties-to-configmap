#!/bin/bash

# variables passed in
PROJECT=myproject
BITBUCKET_REPO_OWNER=myorg_repo
CFG_VERSION_TAG=master
CFG_REPO_LOCAL_PATH=/tmp/configmaps/properties/${PROJECT}-config-repo-k8
CFG_REPO_URL=git@bitbucket.org:${BITBUCKET_REPO_OWNER}/${PROJECT}-config-repo-k8.git

function test_pipe_copy_configs() {
  ./pipe_copy_configs.sh ${CFG_REPO_LOCAL_PATH} ${CFG_REPO_URL} ${CFG_VERSION_TAG}
}
# test_pipe_copy_configs

function test_pipe_migrate_configs() {
  ./pipe_migrate_configs.sh ${CFG_REPO_LOCAL_PATH} ${CFG_VERSION_TAG}
}
 
#test_pipe_migrate_configs

function test_pipe_deploy_configs_all() {
  ./pipe_deploy_configs_all.sh
}
# test_pipe_deploy_configs_all

function test_pipe_deploy_configs_env() {
  ./pipe_deploy_configs_env.sh qa
}
 #test_pipe_deploy_configs_env

function test_pipe_deploy_configs_service() {
  ./pipe_deploy_configs_service.sh  dev xc-transport-registry
}
# test_pipe_deploy_configs_service

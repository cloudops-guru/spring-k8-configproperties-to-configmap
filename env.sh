#List of Envrionemnts [namespaces in kubenetes]
ENVIRONMENTS=" \
dev \
qa \
staging \
prod "
#List of service which we need to generate config map
SERVICES=" \
my-service1 \
my-service2 \
my-service3 \
my-service4 
"

## TODO: temp for testing
#SERVICES=" \
#"

CONFIG_MAP_PATH_BASE="./configmaps"

function dump_env() {
    echo "  ENVIRONMENTS          :  " ${ENVIRONMENTS}
    echo "  SERVICES              :  " ${SERVICES}
    echo "  CONFIG_MAP_PATH_BASE  :  " ${CONFIG_MAP_PATH_BASE}
}

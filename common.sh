#!/bin/bash

source /functions.sh
source /contrail-functions.sh

LOG_LEVEL=${LOG_LEVEL:-SYS_NOTICE}
if [[ "${LOG_LEVEL}" == "SYS_DEBUG" ]] ; then
  set -x
fi

LOG_DIR=${LOG_DIR:-"/var/log/contrail"}
LOG_LOCAL=${LOG_LOCAL:-1}

DEFAULT_IFACE=$(get_default_nic)
DEFAULT_LOCAL_IP=$(get_default_ip)
DEFAULT_HOSTNAME=`uname -n`

CLOUD_ORCHESTRATOR=${CLOUD_ORCHESTRATOR:-none}
AAA_MODE=${AAA_MODE:-'no-auth'}
AUTH_MODE=${AUTH_MODE:-'noauth'}
if [[ $CLOUD_ORCHESTRATOR == 'openstack' ]] ; then
  AUTH_MODE='keystone'
fi
CLOUD_ADMIN_ROLE=${CLOUD_ADMIN_ROLE:-admin}

SSL_ENABLE=${SSL_ENABLE:-False}
SSL_INSECURE=${SSL_INSECURE:-True}
SERVER_CERTFILE=${SERVER_CERTFILE:-'/etc/contrail/ssl/certs/server.pem'}
SERVER_KEYFILE=${SERVER_KEYFILE:-'/etc/contrail/ssl/private/server-privkey.pem'}
SERVER_CA_CERTFILE=${SERVER_CA_CERTFILE:-'/etc/contrail/ssl/certs/ca-cert.pem'}
SERVER_CA_KEYFILE=${SERVER_CA_KEYFILE:-'/etc/contrail/ssl/private/ca-key.pem'}


CONTROLLER_NODES=${CONTROLLER_NODES:-${DEFAULT_LOCAL_IP}}

CONFIG_NODES=${CONFIG_NODES:-${CONTROLLER_NODES}}
CONTROL_NODES=${CONTROL_NODES:-${CONFIG_NODES}}
DNS_NODES=${DNS_NODES:-${CONTROL_NODES}}
CONFIGDB_NODES=${CONFIGDB_NODES:-${CONFIG_NODES}}
ZOOKEEPER_NODES=${ZOOKEEPER_NODES:-${CONFIGDB_NODES}}
RABBITMQ_NODES=${RABBITMQ_NODES:-${CONFIGDB_NODES}}
ANALYTICS_NODES=${ANALYTICS_NODES:-${CONTROLLER_NODES}}
ANALYTICSDB_NODES=${ANALYTICSDB_NODES:-${ANALYTICS_NODES}}
ZOOKEEPER_ANALYTICS_NODES=${ZOOKEEPER_ANALYTICS_NODES:-${ANALYTICSDB_NODES}}
KAFKA_NODES=${KAFKA_NODES:-${ANALYTICSDB_NODES}}
TSN_NODES=${TSN_NODES:-[]}
KUBERNETES_API_NODES=${KUBERNETES_API_NODES:-${CONFIG_NODES}}

CONTROL_INTROSPECT_PORT=${CONTROL_INTROSPECT_PORT:-8083}
BGP_PORT=${BGP_PORT:-179}
BGP_AUTO_MESH=${BGP_AUTO_MESH:-'true'}
XMPP_SERVER_PORT=${XMPP_SERVER_PORT:-5269}
DNS_SERVER_PORT=${DNS_SERVER_PORT:-53}
DNS_INTROSPECT_PORT=${DNS_INTROSPECT_PORT:-8092}
CONFIG_API_PORT=${CONFIG_API_PORT:-8082}
CONFIG_API_INTROSPECT_PORT=${CONFIG_API_INTROSPECT_PORT:-8084}
RABBITMQ_NODE_PORT=${RABBITMQ_NODE_PORT:-5673}
CONFIGDB_PORT=${CONFIGDB_PORT:-9161}
CONFIGDB_CQL_PORT=${CONFIGDB_CQL_PORT:-9041}
ZOOKEEPER_PORT=${ZOOKEEPER_PORT:-2181}
ZOOKEEPER_PORTS=${ZOOKEEPER_PORTS:-2888:3888}
ZOOKEEPER_ANALYTICS_PORT=${ZOOKEEPER_ANALYTICS_PORT:-2182}
WEBUI_JOB_SERVER_PORT=${WEBUI_JOB_SERVER_PORT:-3000}
KUE_UI_PORT=${KUE_UI_PORT:-3002}
WEBUI_HTTP_LISTEN_PORT=${WEBUI_HTTP_LISTEN_PORT:-8180}
WEBUI_HTTPS_LISTEN_PORT=${WEBUI_HTTPS_LISTEN_PORT:-8143}
WEBUI_SSL_KEY_FILE=${WEBUI_SSL_KEY_FILE:-"/etc/pki/ca-trust/source/anchors/contrail_webui_ssl/cs-key.pem"}
WEBUI_SSL_CERT_FILE=${WEBUI_SSL_CERT_FILE:-"/etc/pki/ca-trust/source/anchors/contrail_webui_ssl/cs-cert.pem"}
WEBUI_SSL_CIPHERS=${WEBUI_SSL_CIPHERS:-"ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:AES256-SHA"}
ANALYTICS_API_PORT=${ANALYTCS_API_PORT:-8081}
ANALYTICS_API_INTROSPECT_PORT=${ANALYTICS_API_INTROSPECT_PORT:-8090}
COLLECTOR_PORT=${COLLECTOR_PORT:-8086}
COLLECTOR_INTROSPECT_PORT=${COLLECTOR_INTROSPECT_PORT:-8089}
COLLECTOR_SYSLOG_PORT=${COLLECTOR_SYSLOG_PORT:-514}
COLLECTOR_SFLOW_PORT=${COLLECTOR_SFLOW_PORT:-6343}
COLLECTOR_IPFIX_PORT=${COLLECTOR_IPFIX_PORT:-4739}
COLLECTOR_PROTOBUF_PORT=${COLLECTOR_PROTOBUF_PORT:-3333}
COLLECTOR_STRUCTURED_SYSLOG_PORT=${COLLECTOR_STRUCTURED_SYSLOG_PORT:-3514}
ALARMGEN_INTROSPECT_PORT=${ALARMGEN_INTROSPECT_PORT:-5995}
QUERYENGINE_INTROSPECT_PORT=${QUERYENGINE_INTROSPECT_PORT:-8091}
SNMPCOLLECTOR_INTROSPECT_PORT=${SNMPCOLLECTOR_INTROSPECT_PORT:-5920}
TOPOLOGY_INTROSPECT_PORT=${TOPOLOGY_INTROSPECT_PORT:-5921}
REDIS_SERVER_PORT=${REDIS_SERVER_PORT:-6379}
ANALYTICSDB_PORT=${ANALYTICSDB_PORT:-9160}
ANALYTICSDB_CQL_PORT=${ANALYTICSDB_CQL_PORT:-9042}
CASSANDRA_PORT=${CASSANDRA_PORT:-9160}
CASSANDRA_CQL_PORT=${CASSANDRA_CQL_PORT:-9042}
CASSANDRA_SSL_STORAGE_PORT=${CASSANDRA_SSL_STORAGE_PORT:-7011}
CASSANDRA_STORAGE_PORT=${CASSANDRA_STORAGE_PORT:-7010}
CASSANDRA_JMX_LOCAL_PORT=${CASSANDRA_JMX_LOCAL_PORT:-7200}
KAFKA_PORT=${KAFKA_PORT:-9092}
METADATA_PROXY_SECRET=${METADATA_PROXY_SECRET:-'contrail'}
ENCAP_PRIORITY=${ENCAP_PRIORITY:-'MPLSoUDP,MPLSoGRE,VXLAN'}
REDIS_SERVER_PASSWORD=${REDIS_SERVER_PASSWORD:-""}
EXTERNAL_ROUTERS=${EXTERNAL_ROUTERS:-""}

BGP_ASN=${BGP_ASN:-64512}
SUBCLUSTER=${SUBCLUSTER:-""}
RNDC_KEY=${RNDC_KEY:-"xvysmOR8lnUQRBcunkC6vg=="}

OPENSTACK_LBAAS_AUTH=${OPENSTACK_LBAAS_AUTH:-}
KUBERNETES_LBAAS_AUTH=${KUBERNETES_LBAAS_AUTH:-}

KEYSTONE_AUTH_ADMIN_TENANT=${KEYSTONE_AUTH_ADMIN_TENANT:-admin}
KEYSTONE_AUTH_ADMIN_USER=${KEYSTONE_AUTH_ADMIN_USER:-admin}
KEYSTONE_AUTH_ADMIN_PASSWORD=${KEYSTONE_AUTH_ADMIN_PASSWORD:-contrail123}
KEYSTONE_AUTH_PROJECT_DOMAIN_NAME=${KEYSTONE_AUTH_PROJECT_DOMAIN_NAME:-Default}
KEYSTONE_AUTH_USER_DOMAIN_NAME=${KEYSTONE_AUTH_USER_DOMAIN_NAME:-Default}
KEYSTONE_AUTH_REGION_NAME=${KEYSTONE_AUTH_REGION_NAME:-RegionOne}

KEYSTONE_AUTH_URL_VERSION=${KEYSTONE_AUTH_URL_VERSION:-'/v3'}
KEYSTONE_AUTH_HOST=${KEYSTONE_AUTH_HOST:-'127.0.0.1'}
KEYSTONE_AUTH_PROTO=${KEYSTONE_AUTH_PROTO:-'http'}
KEYSTONE_AUTH_ADMIN_PORT=${KEYSTONE_AUTH_ADMIN_PORT:-'35357'}
KEYSTONE_AUTH_PUBLIC_PORT=${KEYSTONE_AUTH_PUBLIC_PORT:-'5000'}
KEYSTONE_AUTH_URL_TOKENS='/v3/auth/tokens'
if [[ "$KEYSTONE_AUTH_URL_VERSION" == '/v2.0' ]] ; then
  KEYSTONE_AUTH_URL_TOKENS='/v2.0/tokens'
fi
KEYSTONE_AUTH_INSECURE=${KEYSTONE_AUTH_INSECURE:-${SSL_INSECURE}}
KEYSTONE_AUTH_CERTFILE=${KEYSTONE_AUTH_CERTFILE:-}
KEYSTONE_AUTH_KEYFILE=${KEYSTONE_AUTH_KEYFILE:-}
KEYSTONE_AUTH_CA_CERTFILE=${KEYSTONE_AUTH_CA_CERTFILE:-}

BARBICAN_USER=${BARBICAN_USER:-barbican}
BARBICAN_PASSWORD=${BARBICAN_PASSWORD:-${KEYSTONE_AUTH_ADMIN_PASSWORD}}

AUTH_PARAMS=''
if [[ "$AUTH_MODE" == 'keystone' ]] ; then
  AUTH_PARAMS="--admin_password $KEYSTONE_AUTH_ADMIN_PASSWORD"
  AUTH_PARAMS+=" --admin_tenant_name $KEYSTONE_AUTH_ADMIN_TENANT"
  AUTH_PARAMS+=" --admin_user $KEYSTONE_AUTH_ADMIN_USER"
#  AUTH_PARAMS+=" --openstack_ip $KEYSTONE_AUTH_HOST"
fi

CONFIG_SERVERS=${CONFIG_SERVERS:-`get_server_list CONFIG ":$CONFIG_API_PORT "`}
CONFIGDB_SERVERS=${CONFIGDB_SERVERS:-`get_server_list CONFIGDB ":$CONFIGDB_PORT "`}
CONFIGDB_CQL_SERVERS=${CONFIGDB_CQL_SERVERS:-`get_server_list CONFIGDB ":$CONFIGDB_CQL_PORT "`}
ZOOKEEPER_SERVERS=${ZOOKEEPER_SERVERS:-`get_server_list ZOOKEEPER ":$ZOOKEEPER_PORT,"`}
ZOOKEEPER_SERVERS_SPACE_DELIM=${ZOOKEEPER_SERVERS_SPACE_DELIM:-`get_server_list ZOOKEEPER ":$ZOOKEEPER_PORT "`}
ZOOKEEPER_ANALYTICS_SERVERS=${ZOOKEEPER_ANALYTICS_SERVERS:-`get_server_list ZOOKEEPER_ANALYTICS ":$ZOOKEEPER_ANALYTICS_PORT,"`}
ZOOKEEPER_ANALYTICS_SERVERS_SPACE_DELIM=${ZOOKEEPER_ANALYTICS_SERVERS_SPACE_DELIM:-`get_server_list ZOOKEEPER_ANALYTICS ":$ZOOKEEPER_ANALYTICS_PORT "`}
RABBITMQ_SERVERS=${RABBITMQ_SERVERS:-`get_server_list RABBITMQ ":$RABBITMQ_NODE_PORT,"`}
ANALYTICS_SERVERS=${ANALYTICS_SERVERS:-`get_server_list ANALYTICS ":$ANALYTICS_API_PORT "`}
COLLECTOR_SERVERS=${COLLECTOR_SERVERS:-`get_server_list ANALYTICS ":$COLLECTOR_PORT "`}
# redis_servers MUST have same IP-s as analytics IP-s
# but redis must be installed on all nodes where analytics or webui are present
REDIS_SERVERS=${REDIS_SERVERS:-`get_server_list ANALYTICS ":$REDIS_SERVER_PORT "`}
ANALYTICSDB_SERVERS=${ANALYTICSDB_SERVERS:-`get_server_list ANALYTICSDB ":$ANALYTICSDB_PORT "`}
ANALYTICSDB_CQL_SERVERS=${ANALYTICSDB_CQL_SERVERS:-`get_server_list ANALYTICSDB ":$ANALYTICSDB_CQL_PORT "`}
KAFKA_SERVERS=${KAFKA_SERVERS:-`get_server_list KAFKA ":$KAFKA_PORT "`}

ANALYTICS_API_VIP=${ANALYTICS_API_VIP}
CONFIG_API_VIP=${CONFIG_API_VIP}

LINKLOCAL_SERVICE_PORT=${LINKLOCAL_SERVICE_PORT:-80}
LINKLOCAL_SERVICE_NAME=${LINKLOCAL_SERVICE_NAME:-'metadata'}
LINKLOCAL_SERVICE_IP=${LINKLOCAL_SERVICE_IP:-'169.254.169.254'}

# this is group of parameters where OpenStack metadata service can be found
IPFABRIC_SERVICE_PORT=${IPFABRIC_SERVICE_PORT:-8775}
#IPFABRIC_SERVICE_HOST can be derived here and can't have default value

XMPP_SSL_ENABLE=${XMPP_SSL_ENABLE:-${SSL_ENABLE}}
XMPP_SERVER_CERTFILE=${XMPP_SERVER_CERTFILE:-${SERVER_CERTFILE}}
XMPP_SERVER_KEYFILE=${XMPP_SERVER_KEYFILE:-${SERVER_KEYFILE}}
XMPP_SERVER_CA_CERTFILE=${XMPP_SERVER_CA_CERTFILE:-${SERVER_CA_CERTFILE}}

INTROSPECT_SSL_ENABLE=${INTROSPECT_SSL_ENABLE:-${SSL_ENABLE}}
INTROSPECT_SSL_INSECURE=${INTROSPECT_SSL_INSECURE:-${SSL_INSECURE}}
INTROSPECT_CERTFILE=${INTROSPECT_CERTFILE:-${SERVER_CERTFILE}}
INTROSPECT_KEYFILE=${INTROSPECT_KEYFILE:-${SERVER_KEYFILE}}
INTROSPECT_CA_CERTFILE=${INTROSPECT_CA_CERTFILE:-${SERVER_CA_CERTFILE}}

SANDESH_SSL_ENABLE=${SANDESH_SSL_ENABLE:-${SSL_ENABLE}}
SANDESH_CERTFILE=${SANDESH_CERTFILE:-${SERVER_CERTFILE}}
SANDESH_KEYFILE=${SANDESH_KEYFILE:-${SERVER_KEYFILE}}
SANDESH_CA_CERTFILE=${SANDESH_CA_CERTFILE:-${SERVER_CA_CERTFILE}}

if is_enabled ${INTROSPECT_SSL_ENABLE} ; then
  read -r -d '' sandesh_client_config << EOM || true
[SANDESH]
introspect_ssl_enable=${INTROSPECT_SSL_ENABLE}
sandesh_ssl_enable=${SANDESH_SSL_ENABLE}
sandesh_keyfile=${SANDESH_KEYFILE}
sandesh_certfile=${SANDESH_CERTFILE}
sandesh_ca_cert=${SANDESH_CA_CERTFILE}
EOM
else
  read -r -d '' sandesh_client_config << EOM || true
[SANDESH]
introspect_ssl_enable=${INTROSPECT_SSL_ENABLE}
sandesh_ssl_enable=${SANDESH_SSL_ENABLE}
EOM
fi

if is_enabled ${XMPP_SSL_ENABLE} ; then
  read -r -d '' xmpp_certs_config << EOM || true
xmpp_server_cert=${XMPP_SERVER_CERTFILE}
xmpp_server_key=${XMPP_SERVER_KEYFILE}
xmpp_ca_cert=${XMPP_SERVER_CA_CERTFILE}
EOM
else
  xmpp_certs_config=''
fi

# Metadata service SSL opts
METADATA_SSL_ENABLE=${METADATA_SSL_ENABLE:-false}
METADATA_SSL_CERTFILE=${METADATA_SSL_CERTFILE:-}
METADATA_SSL_KEYFILE=${METADATA_SSL_KEYFILE:-}
METADATA_SSL_CA_CERTFILE=${METADATA_SSL_CA_CERTFILE:-}
METADATA_SSL_CERT_TYPE=${METADATA_SSL_CERT_TYPE:-}

# AMQP options
RABBITMQ_VHOST=${RABBITMQ_VHOST:-/}
RABBITMQ_USER=${RABBITMQ_USER:-guest}
RABBITMQ_PASSWORD=${RABBITMQ_PASSWORD:-guest}
RABBITMQ_USE_SSL=${RABBITMQ_USE_SSL:-False}
RABBITMQ_SSL_VER=${RABBITMQ_SSL_VER:-''}
RABBITMQ_CLIENT_SSL_CERTFILE=${RABBITMQ_CLIENT_SSL_CERTFILE:-${SERVER_CERTFILE}}
RABBITMQ_CLIENT_SSL_KEYFILE=${RABBITMQ_CLIENT_SSL_KEYFILE:-${SERVER_KEYFILE}}
RABBITMQ_CLIENT_SSL_CACERTFILE=${RABBITMQ_CLIENT_SSL_CACERTFILE:-${SERVER_CA_CERTFILE}}

# first group is used in analytics and control services
# second group is used in config service, kubernetes_manager, ironic_notification_manager
read -r -d '' rabbitmq_config << EOM || true
rabbitmq_vhost=$RABBITMQ_VHOST
rabbitmq_user=$RABBITMQ_USER
rabbitmq_password=$RABBITMQ_PASSWORD
rabbitmq_use_ssl=$RABBITMQ_USE_SSL
EOM
read -r -d '' rabbit_config << EOM || true
rabbit_vhost=$RABBITMQ_VHOST
rabbit_user=$RABBITMQ_USER
rabbit_password=$RABBITMQ_PASSWORD
rabbit_use_ssl=$RABBITMQ_USE_SSL
EOM

if is_enabled ${RABBITMQ_USE_SSL} ; then
  read -r -d '' rabbitmq_ssl_config << EOM || true
rabbitmq_ssl_version=$RABBITMQ_SSL_VER
rabbitmq_ssl_keyfile=$RABBITMQ_CLIENT_SSL_KEYFILE
rabbitmq_ssl_certfile=$RABBITMQ_CLIENT_SSL_CERTFILE
rabbitmq_ssl_ca_certs=$RABBITMQ_CLIENT_SSL_CACERTFILE
EOM
  read -r -d '' kombu_ssl_config << EOM || true
kombu_ssl_version=$RABBITMQ_SSL_VER
kombu_ssl_certfile=$RABBITMQ_CLIENT_SSL_CERTFILE
kombu_ssl_keyfile=$RABBITMQ_CLIENT_SSL_KEYFILE
kombu_ssl_ca_certs=$RABBITMQ_CLIENT_SSL_CACERTFILE
EOM
fi

# Agent options
AGENT_MODE=${AGENT_MODE:-'kernel'}
VPP_CONTROL_ADDR=${VPP_CONTROL_ADDR:-'192.168.17.15'}
VPP_GATEWAY=${VPP_GATEWAY:-'192.168.17.1'}
DPDK_UIO_DRIVER=${DPDK_UIO_DRIVER-'uio_pci_generic'}
CPU_CORE_MASK=${CPU_CORE_MASK:-'0x01'}
HUGE_PAGES=${HUGE_PAGES:-1024}
HUGE_PAGES_DIR=${HUGE_PAGES_DIR:-'/dev/hugepages'}
DPDK_MEM_PER_SOCKET=${DPDK_MEM_PER_SOCKET:-1024}
DPDK_COMMAND_ADDITIONAL_ARGS=${DPDK_COMMAND_ADDITIONAL_ARGS:-}
VHOST_CONFIG_DIR=${VHOST_CONFIG_DIR:-'/etc/sysconfig/network-scripts'}
TSN_EVPN_MODE=${TSN_EVPN_MODE:-False}
VROUTER_CRYPT_INTERFACE=${VROUTER_CRYPT_INTERFACE:-'crypt0'}
VROUTER_DECRYPT_INTERFACE=${VROUTER_DECRYPT_INTERFACE:-'decrypt0'}
VROUTER_DECRYPT_KEY=${VROUTER_DECRYPT_KEY:-'15'}

# Protocol with port range or port count can be used DIST_SNAT_PROTO_PORT_LIST=${DIST_SNAT_PROTO_PORT_LIST:-tcp:200,udp:2000-3000,tcp:5000-6000,tcp:1000}
DIST_SNAT_PROTO_PORT_LIST=${DIST_SNAT_PROTO_PORT_LIST:-""}
FLOW_EXPORT_RATE=${FLOW_EXPORT_RATE:-0}
FABRIC_SNAT_HASH_TABLE_SIZE=${FABRIC_SNAT_HASH_TABLE_SIZE:-'4096'}

# Qos configuration options
PRIORITY_ID=${PRIORITY_ID:-""}
PRIORITY_BANDWIDTH=${PRIORITY_BANDWIDTH:-""}
PRIORITY_SCHEDULING=${PRIORITY_SCHEDULING:-""}
QOS_QUEUE_ID=${QOS_QUEUE_ID:-""}
QOS_LOGICAL_QUEUES=${QOS_LOGICAL_QUEUES:-""}
QOS_DEF_HW_QUEUE=${QOS_DEF_HW_QUEUE:-False}
PRIORITY_TAGGING=${PRIORITY_TAGGING:-True}

# Session logging options
SLO_DESTINATION=${SLO_DESTINATION:-"collector"}
SAMPLE_DESTINATION=${SAMPLE_DESTINATION:-"collector"}

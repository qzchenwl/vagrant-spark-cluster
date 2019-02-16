#!/bin/bash
set -xe

cat >> /opt/spark-2.2/conf/spark-env.sh << 'EOF'
SPARK_MASTER_HOST=10.0.1.101
HADOOP_CONF_DIR=$HADOOP_HOME/conf
EOF

cat >> /opt/spark-2.2/conf/slaves << EOF
spark-node1
spark-node2
spark-node3
EOF


#!/bin/bash
set -xe

cat >> /opt/spark-2.2/conf/slaves << EOF
spark-node1
spark-node2
EOF


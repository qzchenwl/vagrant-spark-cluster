#!/bin/bash
set -xe

yes | $SPARK_HOME/sbin/stop-all.sh
yes | $HADOOP_HOME/sbin/stop-yarn.sh
yes | $HADOOP_HOME/sbin/stop-dfs.sh


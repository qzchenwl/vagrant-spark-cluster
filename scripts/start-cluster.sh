#!/bin/bash
set -xe

yes | $HADOOP_HOME/sbin/start-dfs.sh
yes | $HADOOP_HOME/sbin/start-yarn.sh
yes | $SPARK_HOME/sbin/start-all.sh


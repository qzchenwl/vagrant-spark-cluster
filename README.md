# vagrant-spark-cluster

Spark cluster of two node. With Hadoop & Yarn.

# Start

```bash
# 1. First download java8, spark-2.2, hadoop-2.7
cd packages
wget -i urls.txt

# 2. Vagrant up
vagrant up

# 3. Start cluster
vagrant ssh spark-node1
bash /vagrant/scripts/start-cluster.sh
```

# References

- https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/
- https://www.quora.com/How-do-I-set-up-Apache-Spark-with-Yarn-Cluster
- https://backtobazics.com/big-data/setup-multi-node-hadoop-2-6-0-cluster-with-yarn/

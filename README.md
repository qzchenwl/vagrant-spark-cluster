# vagrant-spark-cluster

Spark cluster of two node. With Hadoop & Yarn.

# Start

```bash
# 1. First download java8, spark-2.2, hadoop-2.7
you@host ~/vagrant-spark-cluster$ cd packages
you@host ~/vagrant-spark-cluster/packages$ wget -i urls.txt

# 2. Vagrant up
you@host ~/vagrant-spark-cluster$ vagrant up

# 3. Start cluster
you@host ~/vagrant-spark-cluster$ vagrant ssh spark-node1
vagrant@spark-node1 ~$ bash /vagrant/scripts/start-cluster.sh

# 4. Test
[vagrant@spark-node1 /opt/spark-2.2]$ spark-submit --master yarn examples/src/main/python/pi.py
```

# References

- https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/
- https://www.quora.com/How-do-I-set-up-Apache-Spark-with-Yarn-Cluster
- https://backtobazics.com/big-data/setup-multi-node-hadoop-2-6-0-cluster-with-yarn/

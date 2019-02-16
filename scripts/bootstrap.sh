#!/bin/bash
set -xe

IP=$1

sed -i '/127.0.0.1\s\+spark-node/d' /etc/hosts
cat >> /etc/hosts << EOF
10.0.1.101 spark-node1
10.0.1.102 spark-node2
EOF

cat >> /etc/ssh/ssh_config << EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF


cat >> /etc/sysctl.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
sysctl -p

swapoff -a
sed -i '/swap/s/^/#/' /etc/fstab

# Disable firewall
systemctl stop firewalld
systemctl disable firewalld

# Set SELinux in disabled mode
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config

tar xf /vagrant/packages/spark-2.2.3-bin-hadoop2.7.tgz -C /opt
tar xf /vagrant/packages/hadoop-2.7.7.tar.gz -C /opt
tar xf /vagrant/packages/jdk-8u201-linux-x64.tar.gz -C /opt
mv -v /opt/spark-2.2{.3-bin-hadoop2.7,}
mv -v /opt/hadoop-2.7{.7,}
mv -v /opt/jdk1.8{.0_201,}
cp -fv /vagrant/conf/{core-site.xml,hdfs-site.xml,mapred-site.xml,yarn-site.xml,slaves} /opt/hadoop-2.7/etc/hadoop
cat >> /opt/spark-2.2/conf/spark-env.sh << EOF
SPARK_MASTER_HOST=10.0.1.101
SPARK_LOCAL_IP=$IP
HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop
EOF

chown -R vagrant:vagrant /opt/{spark-2.2,hadoop-2.7,jdk1.8}

cat >> /etc/profile.d/custom.sh <<'EOF'
#!/bin/bash
### JAVA ###
export JAVA_HOME=/opt/jdk1.8
export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH

### HADOOP ###
export HADOOP_HOME=/opt/hadoop-2.7
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH

### SPARK ###
export SPARK_HOME=/opt/spark-2.2
export PATH=$SPARK_HOME/sbin:$SPARK_HOME/bin:$PATH
EOF

mkdir -pv /data/hadoop-data/{nn,snn,dn,mapred/{system,local}}
chown -R vagrant:vagrant /data/hadoop-data/{nn,snn,dn,mapred/{system,local}}


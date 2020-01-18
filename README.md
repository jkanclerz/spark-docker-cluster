# Docker based spark cluster

configuration for clustered deployment for spark 

* https://spark.apache.org/docs/latest/spark-standalone.html#installing-spark-standalone-to-a-cluster

## known issue

``/opt/spark/sbin/start-master.sh`` us using ``ps -p`` that is not recognized by alpine linux. This repo contains replaced start scripts within ``scripts/``

## requirements

* docker
* docker-compose
* make

## build images

```sh
make rebuild
```

## start cluster
```sh
docker-compose up --scale spark-worker=3
```

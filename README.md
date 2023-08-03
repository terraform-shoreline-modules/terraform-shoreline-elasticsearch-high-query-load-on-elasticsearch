
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High query load on ElasticSearch service
---

This incident type typically occurs when the number of queries currently in progress on an ElasticSearch service is high, leading to an increased query load. This can result in slower query response times and reduced system performance. It is important to investigate and resolve this issue to ensure optimal performance of the ElasticSearch service.

### Parameters
```shell
# Environment Variables

export NODE_NAME="PLACEHOLDER"

export INDEX_NAME="PLACEHOLDER"
```

## Debug

### Check if ElasticSearch service is running
```shell
systemctl status elasticsearch.service
```

### Check if ElasticSearch is listening on the correct port
```shell
netstat -tuln | grep 9200
```

### Check ElasticSearch query load
```shell
curl -X GET "http://localhost:9200}/_cat/thread_pool?v"
```

### Check ElasticSearch query performance
```shell
curl -X GET "http://localhost:9200/_cat/indices?v"
```

### Check ElasticSearch query logs
```shell
tail -n 100 /var/log/elasticsearch/${NODE_NAME}.log
```

### Check ElasticSearch cluster state
```shell
curl -X GET "http://localhost:9200/_cluster/state?pretty"
```

## Repair

### Stop ElasticSearch service
```shell
sudo systemctl stop elasticsearch
```

### Edit ElasticSearch configuration file to update number of shards and replicas
```shell
sed -i "s/number_of_shards: .*/number_of_shards: $NUM_SHARDS/g" $ES_CONFIG_FILE

sed -i "s/number_of_replicas: .*/number_of_replicas: $NUM_REPLICAS/g" $ES_CONFIG_FILE
```

### Start ElasticSearch service
```shell
sudo systemctl start elasticsearch
```

### Optimize the index
```shell
curl -XPOST 'http://localhost:9200/${INDEX_NAME}/_optimize?max_num_segments=1'
```
sed -i "s/number_of_shards: .*/number_of_shards: $NUM_SHARDS/g" $ES_CONFIG_FILE

sed -i "s/number_of_replicas: .*/number_of_replicas: $NUM_REPLICAS/g" $ES_CONFIG_FILE
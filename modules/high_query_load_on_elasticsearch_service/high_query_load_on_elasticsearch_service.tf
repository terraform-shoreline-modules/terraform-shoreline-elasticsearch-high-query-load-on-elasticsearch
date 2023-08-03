resource "shoreline_notebook" "high_query_load_on_elasticsearch_service" {
  name       = "high_query_load_on_elasticsearch_service"
  data       = file("${path.module}/data/high_query_load_on_elasticsearch_service.json")
  depends_on = [shoreline_action.invoke_change_es_config]
}

resource "shoreline_file" "change_es_config" {
  name             = "change_es_config"
  input_file       = "${path.module}/data/change_es_config.sh"
  md5              = filemd5("${path.module}/data/change_es_config.sh")
  description      = "Edit ElasticSearch configuration file to update number of shards and replicas"
  destination_path = "/agent/scripts/change_es_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_change_es_config" {
  name        = "invoke_change_es_config"
  description = "Edit ElasticSearch configuration file to update number of shards and replicas"
  command     = "`chmod +x /agent/scripts/change_es_config.sh && /agent/scripts/change_es_config.sh`"
  params      = []
  file_deps   = ["change_es_config"]
  enabled     = true
  depends_on  = [shoreline_file.change_es_config]
}


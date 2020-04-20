connection: "youn_bigquery_looker_demo"

include: "/views/bigquery/**/*.view.lkml"                # include all views in the views/ folder in this project

datagroup: youn_bigquery_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_bigquery_model_default_datagroup

explore: delivery_calls {}

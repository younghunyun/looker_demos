connection: "youn_bigquery_looker_demo"

include: "/views/bigquery/*.view.lkml"                # include all views in the views/ folder in this project

datagroup: youn_bq_looker_demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_bq_looker_demo_default_datagroup

explore: call_delivery {}

explore: seoul_weather_2018 {}

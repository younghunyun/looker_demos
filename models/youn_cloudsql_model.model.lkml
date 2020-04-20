connection: "youn_cloudsql_demos"

# include all the views
include: "/views/cloudsql/**/*.view"

datagroup: youn_cloudsql_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_cloudsql_model_default_datagroup

explore: delivery_calls {}

explore: seoul_weather {}

explore: calls_with_weather_custom {}

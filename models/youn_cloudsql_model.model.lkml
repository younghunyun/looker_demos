connection: "youn_cloudsql_demos"

# include all the views
include: "/views/cloudsql/**/*.view"

datagroup: youn_cloudsql_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_cloudsql_model_default_datagroup

explore: delivery_calls {
  join: weather_info {
    type: inner
    sql_on: SUBSTR(${delivery_calls.addr_sido}, 1, 2) = ${weather_info.sido}
      AND ${delivery_calls.addr_gungu} = ${weather_info.gungu}
      AND SUBSTR(${delivery_calls.addr_dong}, 1, 2) = ${weather_info.dong}
      AND ${delivery_calls.call_dt_date} = ${weather_info.dt_date}
      AND ${delivery_calls.call_hr} = ${weather_info.hr}
      ;;
    relationship: one_to_one
  }
}

explore: calls_with_weather {}

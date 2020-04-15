connection: "youn_cloudsql_demos"

# include all the views
include: "/views/cloudsql/**/*.view"

datagroup: youn_demos_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_demos_default_datagroup

explore: delivery_calls {
  join: weather_info {
    type: inner
    sql_on: ${weather_info.dt_date} = ${delivery_calls.call_dt_date} AND ${weather_info.hr} = ${delivery_calls.call_hr} AND ${weather_info.gungu} = ${delivery_calls.addr_gungu} ;;
    relationship: one_to_one
  }
}

explore: calls_with_weather {}

# explore: ga_sessions_flatten {}
#
# explore: seoul_households {}
#
# explore: seoul_population {}
#
# explore: seoul_weather {}
#
# explore: skdata_delivery_calls {}
#
# explore: test_table {}
#
# explore: weather_info {}

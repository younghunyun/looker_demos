connection: "youn_bigquery_looker_demo"

include: "/views/bigquery/*.view.lkml"                # include all views in the views/ folder in this project

datagroup: youn_bq_looker_demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_bq_looker_demo_default_datagroup

explore: call_delivery {
  join: seoul_weather_2018 {
    type: inner
    sql_on: ${call_delivery.date_date} = ${seoul_weather_2018.date} AND ${call_delivery.time_tier} = ${seoul_weather_2018.hour} AND ${call_delivery.addr_sigungu} = ${seoul_weather_2018.gungu} ;;
    relationship: one_to_one
  }
}

# explore: seoul_weather_2018 {}

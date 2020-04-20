connection: "youn_bigquery_looker_demo"

include: "/views/bigquery/**/*.view"                # include all views in the views/ folder in this project

datagroup: youn_bigquery_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_bigquery_model_default_datagroup

explore: calls_with_weather {
  join: seoul_weather {
    type: inner
    sql_on: ${calls_with_weather.addr_sido} = ${seoul_weather.sido}
      AND ${calls_with_weather.addr_sigungu} = ${seoul_weather.gungu}
      AND SUBSTR(${calls_with_weather.addr_dong}, 0, 2) = ${seoul_weather.dong}
      AND ${calls_with_weather.date} = ${seoul_weather.date}
      AND ${calls_with_weather.time_tier} = ${seoul_weather.hour} ;;
    relationship: one_to_one
  }
}

explore: seoul_weather {
  hidden: yes
}

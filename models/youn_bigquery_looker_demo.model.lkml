connection: "youn_bigquery_looker_demo"

include: "/views/bigquery/*.view.lkml"                # include all views in the views/ folder in this project

datagroup: youn_bigquery_looker_demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: youn_bigquery_looker_demo_default_datagroup

explore: call_delivery {}

explore: call_delivery_summary {
  join: seoul_households_summary {
    type: inner
    sql_on: ${call_delivery_summary.addr_gungu} = ${seoul_households_summary.gungu} ;;
    relationship: one_to_one
  }
}

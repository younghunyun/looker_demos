view: call_delivery_summary {
  sql_table_name: `looker_demo.call_delivery_summary`
    ;;

  dimension: addr_gungu {
    type: string
    sql: ${TABLE}.addr_gungu ;;
  }

  dimension: call_cnt {
    type: number
    sql: ${TABLE}.call_cnt ;;
  }

  dimension_group: call {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.call_date ;;
  }

  dimension: call_item {
    type: string
    sql: ${TABLE}.call_item ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_calls {
    type: sum
    sql: ${call_cnt} ;;
  }
}

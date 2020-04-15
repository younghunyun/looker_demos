view: skdata_delivery_calls {
  sql_table_name: demos.skdata_delivery_calls ;;

  dimension: addr_dong {
    type: string
    sql: ${TABLE}.addr_dong ;;
  }

  dimension: addr_gungu {
    type: string
    sql: ${TABLE}.addr_gungu ;;
  }

  dimension: addr_sido {
    type: string
    sql: ${TABLE}.addr_sido ;;
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

  dimension: call_day_of_week {
    type: string
    sql: ${TABLE}.call_day_of_week ;;
  }

  dimension: call_time_tier {
    type: string
    sql: ${TABLE}.call_time_tier ;;
  }

  dimension: delivery_item {
    type: string
    sql: ${TABLE}.delivery_item ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: delivery_calls {
  sql_table_name: demos.looker_demo_delivery_calls ;;

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

  dimension_group: call_dt {
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

  dimension: call_hr {
    type: string
    sql: ${TABLE}.call_time_tier ;;
  }

  dimension: delivery_item {
    type: string
    sql: ${TABLE}.delivery_item ;;
  }

  dimension: calls_ch {
    type: number
    sql: CASE WHEN ${delivery_item} = '중국음식' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_jb {
    type: number
    sql: CASE WHEN ${delivery_item} = '족발/보쌈' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_ck {
    type: number
    sql: CASE WHEN ${delivery_item} = '치킨' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_pz {
    type: number
    sql: CASE WHEN ${delivery_item} = '피자' THEN ${call_cnt} ELSE 0 END ;;
  }

  measure: row_count {
    type: count
    drill_fields: []
  }

  measure: total_calls {
    type: sum
    sql: ${call_cnt} ;;
  }

  measure: total_calls_ch {
    type: sum
    sql:  ${calls_ch} ;;
  }

  measure: total_calls_jb {
    type: sum
    sql:  ${calls_jb} ;;
  }

  measure: total_calls_ck {
    type: sum
    sql:  ${calls_ck} ;;
  }

  measure: total_calls_pz {
    type: sum
    sql:  ${calls_pz} ;;
  }
}

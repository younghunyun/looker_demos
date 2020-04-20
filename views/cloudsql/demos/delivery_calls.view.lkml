view: delivery_calls {
  sql_table_name: demos.looker_demo_delivery_calls ;;

  dimension: addr_sido {
    type: string
    sql: ${TABLE}.addr_sido ;;
  }

  dimension: addr_gungu {
    type: string
    sql: ${TABLE}.addr_gungu ;;
  }

  dimension: addr_dong {
    type: string
    sql: ${TABLE}.addr_dong;;
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

  dimension: call_cnt {
    type: number
    sql: ${TABLE}.call_cnt ;;
  }

  dimension: calls_cnt_chinese {
    type: number
    sql: CASE WHEN ${delivery_item} = '중국음식' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_cnt_porks {
    type: number
    sql: CASE WHEN ${delivery_item} = '족발/보쌈' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_cnt_chicken {
    type: number
    sql: CASE WHEN ${delivery_item} = '치킨' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_cnt_pizza {
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

  measure: total_calls_chinese {
    type: sum
    sql:  ${calls_cnt_chinese} ;;
  }

  measure: total_calls_porks {
    type: sum
    sql:  ${calls_cnt_porks} ;;
  }

  measure: total_calls_ckicken {
    type: sum
    sql:  ${calls_cnt_chicken} ;;
  }

  measure: total_calls_pizza {
    type: sum
    sql:  ${calls_cnt_pizza} ;;
  }
}

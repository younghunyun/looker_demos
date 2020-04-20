view: calls_with_weather {
  sql_table_name: `stf-development.looker_demo.call_delivery` ;;

  dimension: addr_sido {
    type: string
    sql: SUBSTR(${TABLE}.addr_sido, 0, 2) ;;
  }

  dimension: addr_sigungu {
    type: string
    sql: ${TABLE}.addr_sigungu ;;
  }

  dimension: addr_dong {
    type: string
    sql: ${TABLE}.addr_dong;;
  }

  dimension_group: dt {
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
    sql: ${TABLE}.date ;;
  }

  dimension: date {
    type: string
    sql: FORMAT('%t', ${TABLE}.date) ;;
  }

  dimension: day {
    type: string
    sql: ${TABLE}.day ;;
  }

  dimension: time_tier {
    type: string
    sql: ${TABLE}.time_tier ;;
  }

  dimension: industry_item {
    type: string
    sql: ${TABLE}.industry_item ;;
  }

  dimension: call_cnt {
    type: number
    sql: ${TABLE}.call_cnt ;;
  }

  measure: row_count {
    type: count
    drill_fields: [call_details*]
  }

  measure: total_calls {
    type: sum
    sql: ${TABLE}.call_cnt ;;
    drill_fields: [call_details*]
  }

  measure: total_calls_chinese {
    type: sum
    sql: CASE WHEN  ${TABLE}.industry_item = '음식점-중국음식' THEN ${TABLE}.call_cnt ELSE 0 END ;;
  }

  measure: total_calls_chicken {
    type:sum
    sql: CASE WHEN  ${TABLE}.industry_item = '치킨' THEN ${TABLE}.call_cnt ELSE 0 END ;;
  }

  measure: total_calls_pizza {
    type: sum
    sql: CASE WHEN  ${TABLE}.industry_item = '피자' THEN ${TABLE}.call_cnt ELSE 0 END ;;
  }

  measure: total_calls_porks {
    type: sum
    sql: CASE WHEN  ${TABLE}.industry_item = '음식점-족발/보쌈전문' THEN ${TABLE}.call_cnt ELSE 0 END ;;
  }

  set: call_details {
    fields: [addr_sido, addr_sigungu, addr_dong, date, time_tier, industry_item, call_cnt]
  }
}

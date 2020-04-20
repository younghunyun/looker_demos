view: delivery_calls {
  sql_table_name: `looker_demo.call_delivery`
    ;;

  dimension: addr_dong {
    type: string
    sql: ${TABLE}.addr_dong ;;
  }

  dimension: addr_sido {
    type: string
    sql: ${TABLE}.addr_sido ;;
  }

  dimension: addr_sigungu {
    type: string
    sql: ${TABLE}.addr_sigungu ;;
  }

  dimension: call_cnt {
    type: number
    sql: ${TABLE}.call_cnt ;;
  }

  dimension_group: date {
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

  dimension: day {
    type: string
    sql: ${TABLE}.day ;;
  }

  dimension: industry_item {
    type: string
    sql: ${TABLE}.industry_item ;;
  }

  dimension: time_tier {
    type: string
    sql: ${TABLE}.time_tier ;;
  }

  dimension: calls_ch {
    type: number
    sql: CASE WHEN ${industry_item} = '음식점-중국음식' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_jb {
    type: number
    sql: CASE WHEN ${industry_item} = '음식점-족발/보쌈전문' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_ck {
    type: number
    sql: CASE WHEN ${industry_item} = '치킨' THEN ${call_cnt} ELSE 0 END ;;
  }

  dimension: calls_pz {
    type: number
    sql: CASE WHEN ${industry_item} = '피자' THEN ${call_cnt} ELSE 0 END ;;
  }

  measure: count {
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

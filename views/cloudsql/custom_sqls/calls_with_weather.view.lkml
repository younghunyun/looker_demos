view: calls_with_weather {
  derived_table: {
    sql: SELECT
          c.dt_date
          , c.gungu
          , c.daily_calls_ch,
          c.daily_calls_jb,
          c.daily_calls_ck,
          c.daily_calls_pz ,
          w.daily_rainfall ,
          w.daily_temperature
        FROM (
          SELECT
            call_date dt_date,
            addr_gungu gungu,
            SUM(calls_ch) daily_calls_ch ,
            SUM(calls_jb) daily_calls_jb ,
            SUM(calls_ck) daily_calls_ck ,
            SUM(calls_pz) daily_calls_pz
          FROM (
            SELECT
              call_date ,
              addr_gungu ,
              CASE WHEN delivery_item = '중국음식'  THEN call_cnt ELSE 0 END AS calls_ch ,
              CASE WHEN delivery_item = '족발/보쌈' THEN call_cnt ELSE 0 END AS calls_jb ,
              CASE WHEN delivery_item = '치킨'    THEN call_cnt ELSE 0 END AS calls_ck ,
              CASE WHEN delivery_item = '피자'    THEN call_cnt ELSE 0 END AS calls_pz
            FROM
              looker_demo_delivery_calls ) AS dc
          GROUP BY
            1, 2 ) AS c
        LEFT OUTER JOIN (
          SELECT
            date dt_date
            , gungu
            , SUM(rainfall) daily_rainfall
            , AVG(temperature) daily_temperature
          FROM
            looker_demo_weather_info
          GROUP BY
            1, 2) AS w
        ON
          c.dt_date = w.dt_date
          AND c.gungu = w.gungu
      ;;
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
    sql: ${TABLE}.dt_date ;;
  }

  dimension: gungu {
    type: string
    sql: ${TABLE}.gungu ;;
  }

  dimension: daily_calls_ch {
    type: number
    sql: ${TABLE}.daily_calls_ch ;;
  }

  dimension: daily_calls_jb {
    type: number
    sql: ${TABLE}.daily_calls_jb ;;
  }

  dimension: daily_calls_ck {
    type: number
    sql: ${TABLE}.daily_calls_ck ;;
  }

  dimension: daily_calls_pz {
    type: number
    sql: ${TABLE}.daily_calls_pz ;;
  }

  dimension: daily_rainfall {
    type: number
    sql: ${TABLE}.daily_rainfall ;;
  }

  dimension: daily_temperature {
    type: number
    sql: ${TABLE}.daily_temperature ;;
  }

  measure: avg_calls_ch {
    type: average
    sql: ${daily_calls_ch} ;;
  }

  measure: avg_calls_jb {
    type: average
    sql: ${daily_calls_jb} ;;
  }

  measure: avg_calls_ck {
    type: average
    sql: ${daily_calls_ck} ;;
  }

  measure: avg_calls_pz {
    type: average
    sql: ${daily_calls_pz} ;;
  }

  measure: avg_rainfall {
    type: average
    sql: ${daily_rainfall} ;;
  }

  measure: avg_temperature {
    type: average
    sql: ${daily_temperature} ;;
  }

  measure: row_count {
    type: count
    drill_fields: []
  }
}

view: calls_with_weather_custom {
  derived_table: {
    sql:  SELECT
            c.dt
            , c.calls_chinese
            , c.calls_porks
            , c.calls_chicken
            , c.calls_pizza
            , w.rainfall
            , w.temperature
          FROM(
            SELECT
              dt
              , SUM(calls_chinese) calls_chinese
              , SUM(calls_porks) calls_porks
              , SUM(calls_chicken) calls_chicken
              , SUM(calls_pizza) calls_pizza
            FROM (
              SELECT
                call_date dt
                , CASE WHEN delivery_item = '중국음식' THEN call_cnt
                    ELSE 0
                    END AS calls_chinese
                , CASE WHEN delivery_item = '족발/보쌈' THEN call_cnt
                    ELSE 0
                    END AS calls_porks
                , CASE WHEN delivery_item = '치킨' THEN call_cnt
                    ELSE 0
                    END AS calls_chicken
                , CASE WHEN delivery_item = '피자' THEN call_cnt
                    ELSE 0
                    END AS calls_pizza
              FROM
                demos.delivery_calls) AS dc
            GROUP BY
              1) AS c
            INNER JOIN (
              SELECT
                date dt
                , SUM(rainfall)/424 rainfall
                , AVG(temperature) temperature
              FROM
                demos.seoul_weather
              GROUP BY
                1) AS w
            ON
              c.dt = w.dt
      ;;
  }

#   dimension: dt_date {
#     type: string
#     sql: ${TABLE}.dt ;;
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
      sql: ${TABLE}.dt ;;
    }

#   dimension: dt_month {
#     type: string
#     sql: DATE_FORMAT(${TABLE}.dt, '%Y-%m') ;;
#   }
#
#   dimension: dt_week {
#     type: number
#     sql: WEEK(${TABLE}.dt) ;;
#   }

  dimension: calls_chinese {
    type: number
    sql: ${TABLE}.calls_chinese ;;
  }

  dimension: calls_porks {
    type: number
    sql: ${TABLE}.calls_porks ;;
  }

  dimension: calls_chicken {
    type: number
    sql: ${TABLE}.calls_chicken ;;
  }

  dimension: calls_pizza {
    type: number
    sql: ${TABLE}.calls_pizza ;;
  }

  dimension: rainfall {
    type: number
    sql: ${TABLE}.rainfall ;;
  }

  dimension: temperature {
    type: number
    sql: ${TABLE}.temperature ;;
  }

  measure: row_count {
    type: count
    drill_fields: []
  }

  measure: total_calls {
    type: sum
    sql: ${calls_chinese} + ${calls_porks} + ${calls_chicken} + ${calls_pizza};;
  }

  measure: total_calls_chinese {
    type: sum
    sql: ${calls_chinese} ;;
  }

  measure: total_calls_porks {
    type: sum
    sql: ${calls_porks} ;;
  }

  measure: total_calls_chicken {
    type: sum
    sql: ${calls_chicken} ;;
  }

  measure: total_calls_pizza {
    type: sum
    sql: ${calls_pizza} ;;
  }

  measure: average_rainfall {
    type: average
    sql: ${rainfall} ;;
  }

  measure: average_temperature {
    type: average
    sql: ${temperature} ;;
  }
}

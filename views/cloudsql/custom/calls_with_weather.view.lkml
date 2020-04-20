view: calls_with_weather {
  derived_table: {
    sql:  SELECT
            c.dt
            , c.calls_china
            , c.calls_pork
            , c.calls_chicken
            , c.calls_pizza
            , w.rainfall
            , w.temperature
          FROM(
            SELECT
              dt
              , SUM(calls_china) calls_china
              , SUM(calls_pork) calls_pork
              , SUM(calls_chicken) calls_chicken
              , SUM(calls_pizza) calls_pizza
            FROM (
              SELECT
                call_date dt
                , CASE WHEN delivery_item = '중국음식' THEN call_cnt
                    ELSE 0
                    END AS calls_china
                , CASE WHEN delivery_item = '족발/보쌈' THEN call_cnt
                    ELSE 0
                    END AS calls_pork
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

  dimension: calls_china {
    type: number
    sql: ${TABLE}.calls_china ;;
  }

  dimension: calls_pork {
    type: number
    sql: ${TABLE}.calls_pork ;;
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
    sql: ${calls_china} + ${calls_pork} + ${calls_chicken} + ${calls_pizza};;
  }

  measure: total_calls_china {
    type: sum
    sql: ${calls_china} ;;
  }

  measure: total_calls_pork {
    type: sum
    sql: ${calls_pork} ;;
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

view: weather_info {
  sql_table_name: demos.looker_demo_weather_info ;;

  dimension: sido {
    type: string
    sql: ${TABLE}.sido ;;
  }

  dimension: gungu {
    type: string
    sql: ${TABLE}.gungu ;;
  }

  dimension: dong {
    type: string
    sql: ${TABLE}.dong ;;
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

  dimension: hr {
    type: string
    sql: ${TABLE}.hour ;;
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

  measure: sum_rainfall {
    type: sum
    sql: ${rainfall} ;;
  }

  measure: avg_temperature {
    type: average
    sql: ${temperature} ;;
  }
}

view: seoul_weather {
  sql_table_name: demos.seoul_weather ;;

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

  dimension: rainfall_range {
    case: {
      when: {
        sql: ${TABLE}.rainfall <= 0.0 ;;
        label: "0"
      }
      when: {
        sql: ${TABLE}.rainfall < 1.0 ;;
        label: "UNDER_1mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 1.0 AND ${TABLE}.rainfall < 2.0 ;;
        label: "UNDER_2mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 2.0 AND ${TABLE}.rainfall < 3.0 ;;
        label: "UNDER_3mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 3.0 AND ${TABLE}.rainfall < 4.0 ;;
        label: "UNDER_4mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 4.0 AND ${TABLE}.rainfall < 5.0 ;;
        label: "UNDER_5mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 5.0 ;;
        label: "5mm_OR_OVER"
      }
      else: "N/A"
    }
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

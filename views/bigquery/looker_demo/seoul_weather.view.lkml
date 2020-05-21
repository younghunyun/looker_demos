view: seoul_weather {
  sql_table_name: `stf-development.looker_demo.seoul_weather` ;;

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

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: hour {
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

  dimension: rainfall_range {
    case: {
      when: {
        sql: ${TABLE}.rainfall < 1.0 ;;
        label: "LESS THAN 1 mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 1.0 AND ${TABLE}.rainfall < 2.0 ;;
        label: "LESS THAN 2 mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 2.0 AND ${TABLE}.rainfall < 3.0 ;;
        label: "LESS THAN 3 mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 3.0 AND ${TABLE}.rainfall < 4.0 ;;
        label: "LESS THAN 4 mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 4.0 AND ${TABLE}.rainfall < 5.0 ;;
        label: "LESS THAN 5 mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 5.0 AND ${TABLE}.rainfall < 10.0 ;;
        label: "LESS THAN 10 mm"
      }
      when: {
        sql: ${TABLE}.rainfall >= 10.0 ;;
        label: "10 mm OR OVER"
      }
      else: "N/A"
    }
  }

  dimension: temperature_tier {
    type: tier
    tiers: [-20, -10, 0, 10, 20, 30, 40]
    style:  integer
    sql: ${TABLE}.temperature ;;
  }

  measure: row_count {
    type: count
    drill_fields: []
  }
}

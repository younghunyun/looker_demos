view: seoul_households_summary {
  sql_table_name: `looker_demo.seoul_households_summary`
    ;;

  dimension: gungu {
    type: string
    sql: ${TABLE}.gungu ;;
  }

  dimension: total_households {
    type: number
    sql: ${TABLE}.total_households ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

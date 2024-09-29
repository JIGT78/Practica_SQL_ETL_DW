-- Ejercicio 12: Crear tabla de ivr_summary

CREATE OR REPLACE TABLE `keepcoding.ivr_summary` AS
  SELECT
      calls_ivr_id AS ivr_id
    , calls_phone_number AS phone_number
    , calls_ivr_result AS ivr_result
    , CASE WHEN STARTS_WITH(calls.vdn_label, 'ATC') THEN 'FRONT'
           WHEN STARTS_WITH(calls.vdn_label, 'TECH') THEN 'TECH'
           WHEN vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
           ELSE 'RESTO'
       END AS vdn_aggregation
    , MIN(calls_start_date) AS start_date
    , MAX(calls_end_date) AS end_date
    , calls_total_duration AS total_duration
    , calls_customer_segment AS customer_segment
    , calls_ivr_language AS ivr_language
    , calls_steps_module AS steps_module
    , calls_module_aggregation AS module_aggregation
    , MAX(IF(step_document_type = 'UNKNOWN' OR step_document_type = 'DESCONOCIDO' , NULL , step_document_type)) AS step_document_type
    , MAX(IF(step_document_identification = 'UNKNOWN' OR step_document_identification= 'DESCONOCIDO', NULL , step_document_identification  )) AS step_document_identification
    , MAX(IF(step_customer_phone = 'UNKNOWN' OR step_customer_phone = 'DESCONOCIDO' , NULL , step_customer_phone)) AS step_customer_phone
    , MAX(IF(step_billing_account_id = 'UNKNOWN' OR step_billing_account_id = 'DESCONOCIDO' , NULL , step_billing_account_id)) AS step_billing_account_id
    , MAX(IF(module_name = "AVERIA_MASIVA" , 1 , 0)) AS masiva_lg
    , MAX(IF(step_name = "CUSTOMERINFOBYPHONE.TX" AND step_result = "OK" , 1 , 0)) AS info_by_phone_lg
    , MAX(IF(step_name = "CUSTOMERINFOBYDNI.TX" AND step_result = "OK" , 1 , 0)) AS info_by_dni_lg
  FROM `keepcoding.ivr_detail` AS detail
  LEFT
  JOIN `keepcoding.ivr_calls` AS calls
    ON CAST(calls.ivr_id AS STRING) = detail.calls_ivr_id
 GROUP BY  calls_ivr_id
          ,phone_number
          ,ivr_result
          ,vdn_aggregation
          ,total_duration
          ,customer_segment
          ,ivr_language
          ,steps_module
          ,module_aggregation

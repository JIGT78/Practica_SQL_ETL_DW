-- Ejercicio 6: Generar el campo customer_phone

SELECT
  calls_ivr_id
  , MAX(IF(step_customer_phone = 'UNKNOWN' OR step_customer_phone = 'DESCONOCIDO' , NULL , step_customer_phone)) AS step_customer_phone
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id;


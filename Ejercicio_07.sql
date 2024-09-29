-- Ejercicio 7: Generar el campo billing_acount_id

SELECT
  calls_ivr_id
  , MAX(IF(step_billing_account_id = 'UNKNOWN' OR step_billing_account_id = 'DESCONOCIDO' , NULL , step_billing_account_id)) AS step_billing_account_id
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id;

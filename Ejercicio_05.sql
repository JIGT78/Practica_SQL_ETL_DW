-- Ejercicio 5: Generar los campos document_type y document_identification

SELECT
    calls_ivr_id
  , MAX(IF(step_document_type = 'UNKNOWN' OR step_document_type = 'DESCONOCIDO' , NULL , step_document_type)) AS step_document_type
  , MAX(IF(step_document_identification = 'UNKNOWN' OR step_document_identification= 'DESCONOCIDO', NULL , step_document_identification  )) AS step_document_identification
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id;

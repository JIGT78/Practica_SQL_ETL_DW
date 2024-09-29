-- Ejercicio 13: Crear función de limpieza de enteros

CREATE OR REPLACE FUNCTION keepcoding.fnc_cleaning_int(num_int INT) RETURNS INT AS
(IFNULL(num_int, -999999));

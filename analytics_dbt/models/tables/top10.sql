-- https://docs.getdbt.com/docs/build/incremental-models
-- https://iomete.com/docs/guides/dbt/dbt-incremental-models-by-examples#append
{{ config(
    materialized='incremental',
    incremental_strategy = 'append'
    )
}}

WITH compras AS (
    SELECT
        id_cliente
        , SUM(preco_pago) AS total_pago
    FROM {{ ref('vw_sales') }}
    GROUP BY 1
    ORDER BY 2 DESC
)

, clientes AS (
    SELECT
        firstname || ' ' || lastname AS nome_completo -- https://docs.aws.amazon.com/redshift/latest/dg/r_CONCAT.html
        , userid
    FROM
        tickit.users
)

, top_10 AS (
    SELECT
        CL.nome_completo
        , CO.total_pago
        , DENSE_RANK() OVER(PARTITION BY 1 ORDER BY CO.total_pago DESC) AS ranque
    FROM
        compras CO
    JOIN
        clientes CL
            ON CO.id_cliente = CL.userid
)

SELECT
    *
    , GETDATE() AS atualizacao_em -- https://docs.aws.amazon.com/redshift/latest/dg/r_GETDATE.html
FROM top_10 WHERE ranque <= 10
{% set ano = "LEFT(DATE(GETDATE() - INTERVAL '15 YEAR'), 4)" %} -- https://stackoverflow.com/questions/75175545/setting-dbt-date-variable
{% set trimestre = ("JAN", "FEB", "MAR") %}

WITH source_date AS (
	SELECT
		dateid
		, day
		, month
		, year
	FROM
		tickit.date
	WHERE
		year = {{ ano }}
		AND month IN {{ trimestre }}
)

, trimestre AS (
	SELECT
		year || '-' || month AS mes
		, SUM(quantidade_vendida) AS qtd_vendas
	FROM
		{{ ref('vw_sales') }} S
	JOIN
		source_date D
		ON S.id_data = D.dateid
	GROUP BY 1
	ORDER BY 1
)

SELECT * FROM trimestre	
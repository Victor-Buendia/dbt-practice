SELECT
	*
FROM
	{{ ref('top10') }}
WHERE
	total_pago < 0
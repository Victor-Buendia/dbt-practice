WITH vendas AS
(
	SELECT
		salesid AS id_venda
		, listid AS id_lista
		, sellerid AS id_vendedor
		, buyerid AS id_cliente
		, eventid AS id_evento
		, dateid AS id_data
		, qtysold AS quantidade_vendida
		, pricepaid AS preco_pago
		, commission AS comissao_vendedor
		, saletime AS venda_timestamp
        , TO_CHAR(saletime, 'DD') AS dia_venda -- https://docs.aws.amazon.com/redshift/latest/dg/r_TO_CHAR.html
		, TO_CHAR(saletime, 'MM') AS mes_venda
		, TO_CHAR(saletime, 'YYYY') AS ano_venda
        , saletime - INTERVAL '3 HOUR' AS venda_brt -- https://stackoverflow.com/questions/54948566/subtract-5-hours-from-sysdate-in-redshift
	FROM
		tickit.sales
)

SELECT * FROM vendas
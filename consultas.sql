-- Consulta 1: Preço médio por metro quadrado dos imóveis que:
-- - Tiveram aumento de preço
-- - Em 2016
-- - E têm área (construída ou útil) maior que 200 m²

SELECT 
    CONCAT(
        'Preco medio calculado como media de (novo preco / maior(constructed, used)) ',
        'para imoveis com aumento em 2016 e area > 200 m²'
    ) AS descricao,
    ROUND(
        AVG(pc.new_price / NULLIF(GREATEST(bu.built_area, bu.used_area), 0))
    , 2) AS preco_medio_por_m2
FROM Price_changes pc
INNER JOIN Built_used_area bu 
    ON pc.listing_id = bu.listing_id
WHERE pc.new_price > pc.old_price
  AND YEAR(pc.change_date) = 2016
  AND GREATEST(bu.built_area, bu.used_area)>200;

-- Consulta 2: Para o ano de 2016, mostra:
-- - Quantos imóveis aumentaram de preço
-- - Qual foi a média percentual desse aumento
-- - Quantos imóveis reduziram o preço
-- - Qual foi a média percentual dessa redução

SELECT 
    CONCAT('Número de imóveis com aumento em 2016: ', SUM(pc.new_price > pc.old_price)) AS total_com_aumento,
    CONCAT('Percentual médio de aumento de preço/m²: ', 
           ROUND(AVG(IF(pc.new_price > pc.old_price, ((pc.new_price - pc.old_price) / pc.old_price) * 100, NULL)), 2), '%'
    ) AS media_percentual_aumento,
    CONCAT('Número de imóveis com redução em 2016: ', SUM(pc.new_price < pc.old_price)) AS total_com_reducao,
    CONCAT('Percentual médio de redução de preço/m²: ', 
           ROUND(AVG(IF(pc.new_price < pc.old_price, ((pc.old_price - pc.new_price) / pc.old_price) * 100, NULL)), 2), '%'
    ) AS media_percentual_reducao
FROM Price_changes pc
WHERE pc.change_date BETWEEN '2016-01-01' AND'2016-12-31';
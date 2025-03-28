-- Consulta 1: Calcular o preço médio do metro quadrado dos imóveis com aumento de preço em 2016 e área > 200m²
SELECT 
    AVG(pc.new_price / NULLIF(GREATEST(bu.built_area, bu.used_area), 0)) AS avg_price_per_sqm
FROM Price_changes pc
JOIN Built_used_area bu ON pc.listing_id = bu.listing_id
WHERE 
    pc.new_price > pc.old_price -- Apenas aumentos de preço
    AND YEAR(pc.change_date) = 2016 -- Apenas mudanças em 2016
    AND GREATEST(bu.built_area, bu.used_area) > 200; -- Apenas imóveis com área construída ou útil > 200m²

-- Consulta 2: Contar imóveis com aumento e decréscimo de preço em 2016 e calcular percentuais
SELECT 
    SUM(CASE WHEN pc.new_price > pc.old_price THEN 1 ELSE 0 END) AS num_imoveis_aumento,
    AVG(CASE WHEN pc.new_price > pc.old_price 
             THEN ((pc.new_price - pc.old_price) / pc.old_price) * 100 
             ELSE NULL END) AS percentual_medio_aumento,
    SUM(CASE WHEN pc.new_price < pc.old_price THEN 1 ELSE 0 END) AS num_imoveis_reducao,
    AVG(CASE WHEN pc.new_price < pc.old_price 
             THEN ((pc.old_price - pc.new_price) / pc.old_price) * 100 
             ELSE NULL END) AS percentual_medio_reducao
FROM Price_changes pc
JOIN Built_used_area bu ON pc.listing_id = bu.listing_id
WHERE 
    YEAR(pc.change_date) = 2016;

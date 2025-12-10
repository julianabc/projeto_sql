SELECT *
FROM produtos
WHERE DescNomeProduto LIKE '%churn%'

-- a melhor forma de escrever, pois é mais rapida no processamento:

WHERE DescCategoriaProduto='churn_model'


/* uma forma de fazer: 

WHERE DescNomeProduto IN ("Churn_10pp","Churn_2pp","Churn_5pp")

*/


SELECT * FROM vw_detalhes_vendas LIMIT 3;

SELECT * FROM vw_produtos_baixo_estoque;

SELECT * FROM vw_historico_reposicao LIMIT 3;

SELECT * FROM fn_total_vendas_periodo('2023-11-01', '2023-11-30');

SELECT * FROM fn_produtos_mais_vendidos(5);

SELECT nome, tipo, preco FROM produto WHERE tipo = 'Eletrônicos';

SELECT fn_atualizar_precos_categoria('Eletrônicos', 10);
-- Verificar as mudanças
SELECT nome, tipo, preco FROM produto WHERE tipo = 'Eletrônicos';


-- Este teste de idade vai causar um erro, como esperado.
--INSERT INTO cliente (nome, email, endereco, idade, "CPFcliente", telefone)
--VALUES ('Test User', 'test@email.com', 'Test Address', 12, 99999999999, 9999999999);

-- Este teste de idade vai passar.
INSERT INTO cliente (nome, email, endereco, idade, "CPFcliente", telefone)
VALUES ('Test User', 'test@email.com', 'Test Address', 15, 99999999999, 9999999999);

-- Testar a atualização do estoque
SELECT "IDproduto", nome, quantidade FROM produto WHERE "IDproduto" = 1;
INSERT INTO venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES (CURRENT_DATE, 1500.0, 98765432109, 12345678901)
RETURNING "IDvenda";
INSERT INTO inclui ("dataDaInclusao", "IDproduto", "IDvenda")
VALUES (CURRENT_DATE, 1, (SELECT MAX("IDvenda") FROM venda));

-- Verificar estoque atualizado
SELECT "IDproduto", nome, quantidade FROM produto WHERE "IDproduto" = 1;


UPDATE produto
SET preco = preco * 1.15
WHERE "IDproduto" = 1;


SELECT * FROM log_alteracao_preco
WHERE produto_id = 1
ORDER BY data_alteracao DESC
LIMIT 1;


-- Test Script for QualiShop Database Extensions

-- 1. Testing Views
-- Test vw_detalhes_vendas
SELECT * FROM vw_detalhes_vendas LIMIT 3;

-- Test vw_produtos_baixo_estoque
SELECT * FROM vw_produtos_baixo_estoque;

-- Test vw_historico_reposicao
SELECT * FROM vw_historico_reposicao LIMIT 3;

-- 2. Testing Functions
-- Test fn_total_vendas_periodo
SELECT * FROM fn_total_vendas_periodo('2023-11-01', '2023-11-30');

-- Test fn_produtos_mais_vendidos
SELECT * FROM fn_produtos_mais_vendidos(5);

-- Test fn_atualizar_precos_categoria
-- First, let's see current prices
SELECT nome, tipo, preco FROM produto WHERE tipo = 'Eletrônicos';
-- Apply 10% increase to Eletrônicos
SELECT fn_atualizar_precos_categoria('Eletrônicos', 10);
-- Verify the changes
SELECT nome, tipo, preco FROM produto WHERE tipo = 'Eletrônicos';

-- 3. Testing Triggers
-- Test tr_verificar_idade_minima
-- This should fail (age < 13)
INSERT INTO cliente (nome, email, endereco, idade, "CPFcliente", telefone)
VALUES ('Test User', 'test@email.com', 'Test Address', 12, 99999999999, 9999999999);

-- This should succeed (age >= 13)
INSERT INTO cliente (nome, email, endereco, idade, "CPFcliente", telefone)
VALUES ('Test User', 'test@email.com', 'Test Address', 15, 99999999999, 9999999999);

-- Test tr_atualizar_estoque
-- First, check current stock of a product
SELECT "IDproduto", nome, quantidade FROM produto WHERE "IDproduto" = 1;

-- Insert a new sale and inclusion
INSERT INTO venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES (CURRENT_DATE, 1500.0, 98765432109, 12345678901)
RETURNING "IDvenda";

-- Use the returned IDvenda to insert into inclui
INSERT INTO inclui ("dataDaInclusao", "IDproduto", "IDvenda")
VALUES (CURRENT_DATE, 1, (SELECT MAX("IDvenda") FROM venda));

-- Verify stock was updated
SELECT "IDproduto", nome, quantidade FROM produto WHERE "IDproduto" = 1;

-- Test tr_registrar_alteracao_preco
-- Update price of a product
UPDATE produto 
SET preco = preco * 1.15 
WHERE "IDproduto" = 1;

-- Check the log
SELECT * FROM log_alteracao_preco 
WHERE produto_id = 1 
ORDER BY data_alteracao DESC 
LIMIT 1;

-- 4. Cleanup test data (if needed)
-- Delete test sale
DELETE FROM inclui 
WHERE "IDvenda" = (SELECT MAX("IDvenda") FROM venda);

DELETE FROM venda 
WHERE "IDvenda" = (SELECT MAX("IDvenda") FROM venda);

-- Delete test client
DELETE FROM cliente 
WHERE "CPFcliente" = 99999999999;

-- Reset prices (optional)
UPDATE produto 
SET preco = preco / 1.15 
WHERE "IDproduto" = 1;

UPDATE produto 
SET preco = preco / 1.1 
WHERE tipo = 'Eletrônicos';


SELECT * FROM public.cliente;
--10)
--Consulta com Junção de 3 Tabelas:
--Objetivo: Mostrar informações sobre vendas, incluindo detalhes do cliente, vendedor e produtos vendidos.

SELECT v.*, c.nome AS nome_cliente, vd.nome AS nome_vendedor, p.nome AS nome_produto
FROM public.venda v
JOIN public.cliente c ON v."CPFcliente" = c."CPFcliente"
JOIN public.vendedor vd ON v."CPFvendedor" = vd."CPFvendedor"
JOIN public.inclui i ON v."IDvenda" = i."IDvenda"
JOIN public.produto p ON i."IDproduto" = p."IDproduto";


--Consulta com Agrupamento e Função de Agregação:
--Objetivo: Obter a contagem de vendas realizadas por cada vendedor.

SELECT "CPFvendedor", COUNT("IDvenda") AS total_vendas
FROM public.venda
GROUP BY "CPFvendedor";
--Consulta com Restrição sobre o Agrupamento:
--Objetivo: Listar apenas os vendedores que realizaram mais que 3 vendas.

SELECT "CPFvendedor", COUNT("IDvenda") AS total_vendas
FROM public.venda
GROUP BY "CPFvendedor"
HAVING COUNT("IDvenda") > 3;
--Comando para Inserção que Causa Erro de Chave Estrangeira:
--Objetivo: Inserir uma venda com um cliente que não existe na tabela cliente para demonstrar a violação da chave estrangeira.


INSERT INTO public.venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES ('2023-11-20', 800.50, 34567890123, 1234567890);
-- O comando acima tenta inserir uma venda com o CPFcliente inexistente na tabela cliente, causando um erro de chave estrangeira.
--Comando para Inserção que Causa Sucesso de Chave Estrangeira:
--Objetivo: Inserir uma venda com um cliente existente na tabela cliente para validar a chave estrangeira.


--13)
INSERT INTO public.venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES ('2023-11-21', 1000.25, 98765432109, 12345678901);
-- O comando acima insere uma venda com um cliente existente na tabela cliente, validando a chave estrangeira.
--Comando SQL para Remoção de Dado em Tabela:
--Objetivo: Remover um registro da tabela cliente.


--14) Comando para remover um cliente com o CPF especificado da tabela cliente.
DELETE FROM public.cliente
WHERE "CPFcliente" = 12345678901;

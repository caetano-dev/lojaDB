SELECT * FROM public.cliente;

SELECT v.*, c.nome AS nome_cliente, vd.nome AS nome_vendedor, p.nome AS nome_produto FROM public.venda v JOIN public.cliente c ON v."CPFcliente" = c."CPFcliente" JOIN public.vendedor vd ON v."CPFvendedor" = vd."CPFvendedor" JOIN public.inclui i ON v."IDvenda" = i."IDvenda" JOIN public.produto p ON i."IDproduto" = p."IDproduto";


SELECT "CPFvendedor", COUNT("IDvenda") AS total_vendas
FROM public.venda
GROUP BY "CPFvendedor";


SELECT "CPFvendedor", COUNT("IDvenda") AS total_vendas
FROM public.venda
GROUP BY "CPFvendedor"
HAVING COUNT("IDvenda") > 3;


INSERT INTO public.venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES ('2023-11-20', 800.50, 34567890123, 1234567890);


INSERT INTO public.venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES ('2023-11-21', 1000.25, 98765432109, 12345678901);


DELETE FROM public.inclui
WHERE "IDvenda" IN (SELECT "IDvenda" FROM public.venda WHERE "CPFcliente" = 12345678901);


SELECT * FROM public.venda WHERE "CPFvendedor" = 98765432109;


SELECT p.nome AS "Product", f."CNPJfornecedor" AS "Supplier ID"
FROM public.produto p
JOIN public.fornecedor f ON p."IDproduto" = f."IDproduto";


SELECT * FROM public.venda WHERE "dataVenda" = '2023-11-11';


SELECT c.nome AS "Customer Name", v."valorTotal" AS "Total Value"
FROM public.venda v
JOIN public.cliente c ON v."CPFcliente" = c."CPFcliente"
WHERE v."valorTotal" > 1000.0;


SELECT p.nome AS "Product", p.quantidade AS "Quantity", p.preco AS "Price"
FROM public.produto p;

CREATE TABLE IF NOT EXISTS public.produto
(
    "IDproduto" SERIAL PRIMARY KEY,
    nome character varying NOT NULL,
    marca character varying NOT NULL,
    tipo character varying NOT NULL,
    preco numeric NOT NULL CHECK (preco > 0),
    quantidade integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public.cliente
(
    nome character varying NOT NULL,
    email character varying NOT NULL,
    endereco character varying NOT NULL,
    idade numeric NOT NULL CHECK (idade >= 13),
    "CPFcliente" numeric PRIMARY KEY,
    telefone numeric NOT NULL,
    CONSTRAINT telefone UNIQUE (telefone)
);


CREATE TABLE IF NOT EXISTS public.vendedor
(
    "CPFvendedor" numeric PRIMARY KEY,
    nome character varying NOT NULL,
    email character varying NOT NULL,
    salario numeric NOT NULL
);



CREATE TABLE IF NOT EXISTS public.venda
(
    "IDvenda"  SERIAL PRIMARY KEY,
    "dataVenda" date NOT NULL,
    "valorTotal" numeric NOT NULL,
    "CPFvendedor" numeric NOT NULL,
    "CPFcliente" numeric NOT NULL,
    CONSTRAINT "CPFcliente" FOREIGN KEY ("CPFcliente")
        REFERENCES public.cliente ("CPFcliente") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "CPFvendedor" FOREIGN KEY ("CPFvendedor")
        REFERENCES public.vendedor ("CPFvendedor") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);



CREATE TABLE IF NOT EXISTS public.fornecedor
(
    "CNPJfornecedor" numeric PRIMARY KEY,
    "ValorTotal" numeric NOT NULL,
    "IDproduto" integer NOT NULL,
    quantidade numeric NOT NULL,
    CONSTRAINT "IDproduto" FOREIGN KEY ("IDproduto")
        REFERENCES public.produto ("IDproduto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);



CREATE TABLE IF NOT EXISTS public.inclui
(
    "dataDaInclusao" date NOT NULL,
    "IDproduto" integer NOT NULL,
    "IDvenda" integer NOT NULL,
    CONSTRAINT "IDproduto" FOREIGN KEY ("IDproduto")
        REFERENCES public.produto ("IDproduto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "IDvenda" FOREIGN KEY ("IDvenda")
        REFERENCES public.venda ("IDvenda") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE IF NOT EXISTS public.repoe
(
    "dataDaReposicao" date NOT NULL,
    "CNPJfornecedor" numeric NOT NULL,
    "IDproduto" integer NOT NULL,
    CONSTRAINT "IDproduto" FOREIGN KEY ("IDproduto")
        REFERENCES public.produto ("IDproduto") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "CNPJfornecedor" FOREIGN KEY ("CNPJfornecedor")
        REFERENCES public.fornecedor ("CNPJfornecedor") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE public.venda VALIDATE CONSTRAINT "CPFcliente";
ALTER TABLE public.venda VALIDATE CONSTRAINT "CPFvendedor";


INSERT INTO public.produto (nome, marca, tipo, preco, quantidade)
VALUES
    ('Smartphone Galaxy S21', 'Samsung', 'Eletrônicos', 1200.0, 50),
    ('Notebook Inspiron 15', 'Dell', 'Computadores', 900.0, 30),
    ('Headphone Wireless', 'Sony', 'Acessórios', 150.0, 80),
    ('Smart TV LED 55"', 'LG', 'Eletrônicos', 2000.0, 25),
    ('Coffee Maker', 'Hamilton Beach', 'Eletrodomésticos', 80.0, 50),
    ('Wireless Mouse', 'Logitech', 'Periféricos', 30.0, 100),
    ('Apple iPhone 16 Pro Max 256GB Titânio preto', 'Apple', 'Eletrônicos', 11249.0, 100);

INSERT INTO public.cliente (nome, email, endereco, idade, "CPFcliente", telefone)
VALUES
    ('Lucas Nunes', 'lucas.goncalves@email.com', 'Rua das Rosas, 26', 18, 12345678901, 1122334455),
    ('Nucas Lunes', 'nucas.lunes@email.com', 'Av. das Américas, 4666', 19, 23456789012, 2233445566),
    ('José Mesquita', 'jose.mesquita@email.com', 'Rua Sá Ferreira, 789', 90, 34567890123, 3344556677),
    ('Manoel Gomes', 'manoel.gomes@email.com', 'Estrada dos Bandeirantes, 56', 57, 45678901234, 4455667788),
    ('Alan Turing', 'alan.turing@email.com', 'Av. Geremário Dantas, 789', 100, 56789012345, 5566778899),
    ('Júlio Cesar', 'julio.cesar@email.com', 'Estrada do Rio Grande, 12', 70, 67890123456, 6677889900);

INSERT INTO public.vendedor ("CPFvendedor", nome, email, salario)
VALUES
    (98765432109, 'Pedro Pedro Pedro', 'pedro.pedro@email.com', 3500.0),
    (87654321098, 'Ramon Dino', 'ramon.dino@email.com', 4000.0),
    (76543210987, 'Maria Silva', 'maria.silva@email.com', 2800.0),
    (65432109876, 'Rodrigo Santos', 'rodrigo.santos@email.com', 3200.0),
    (54321098765, 'Juliana Costa', 'juliana.costa@email.com', 3800.0),
    (43210987654, 'Joao da Silva', 'joao.silva@email.com', 3000.0);

INSERT INTO public.venda ("dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES
    ('2023-11-10', 1500.0, 98765432109, 12345678901),
    ('2023-11-11', 1000.0, 87654321098, 23456789012),
    ('2023-11-12', 800.0, 76543210987, 34567890123),
    ('2023-11-13', 2200.0, 65432109876, 45678901234),
    ('2023-11-14', 3500.0, 54321098765, 56789012345),
    ('2023-11-15', 1200.0, 43210987654, 67890123456);

INSERT INTO public.fornecedor ("CNPJfornecedor", "ValorTotal", "IDproduto", quantidade)
VALUES
    (11111111111111, 2500.0, 1, 30),
    (22222222222222, 1800.0, 2, 20),
    (33333333333333, 1200.0, 3, 40),
    (44444444444444, 3000.0, 4, 15),
    (55555555555555, 400.0, 5, 10),
    (66666666666666, 500.0, 6, 25);

INSERT INTO public.inclui ("dataDaInclusao", "IDproduto", "IDvenda")
VALUES
    ('2023-11-10', 1, 1),
    ('2023-11-11', 2, 2),
    ('2023-11-12', 3, 3),
    ('2023-11-13', 4, 4),
    ('2023-11-14', 5, 5),
    ('2023-11-15', 6, 6);

INSERT INTO public.repoe ("dataDaReposicao", "CNPJfornecedor", "IDproduto")
VALUES
    ('2023-11-10', 11111111111111, 1),
    ('2023-11-11', 22222222222222, 2),
    ('2023-11-12', 33333333333333, 3),
    ('2023-11-13', 44444444444444, 4),
    ('2023-11-14', 55555555555555, 5),
    ('2023-11-15', 66666666666666, 6);


CREATE INDEX IF NOT EXISTS idx_produto_nome_gin ON public.produto USING gin (to_tsvector('portuguese', nome));

-- VIEWS
CREATE VIEW vw_detalhes_vendas AS
SELECT 
    v."IDvenda",
    v."dataVenda",
    v."valorTotal",
    c.nome as cliente_nome,
    c.email as cliente_email,
    vd.nome as vendedor_nome,
    vd.email as vendedor_email
FROM venda v
JOIN cliente c ON v."CPFcliente" = c."CPFcliente"
JOIN vendedor vd ON v."CPFvendedor" = vd."CPFvendedor";

CREATE VIEW vw_produtos_baixo_estoque AS
SELECT 
    p."IDproduto",
    p.nome,
    p.marca,
    p.tipo,
    p.quantidade,
    p.preco
FROM produto p
WHERE p.quantidade < 30
ORDER BY p.quantidade ASC;

CREATE VIEW vw_historico_reposicao AS
SELECT 
    r."dataDaReposicao",
    p.nome as produto_nome,
    f."CNPJfornecedor",
    f.quantidade as qtd_fornecida,
    f."ValorTotal"
FROM repoe r
JOIN produto p ON r."IDproduto" = p."IDproduto"
JOIN fornecedor f ON r."CNPJfornecedor" = f."CNPJfornecedor";

-- FUNCTIONS
CREATE OR REPLACE FUNCTION fn_total_vendas_periodo(data_inicio DATE, data_fim DATE)
RETURNS TABLE (
    total_vendas NUMERIC,
    quantidade_vendas BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        SUM("valorTotal") as total_vendas,
        COUNT(*) as quantidade_vendas
    FROM venda
    WHERE "dataVenda" BETWEEN data_inicio AND data_fim;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_produtos_mais_vendidos(limite INTEGER)
RETURNS TABLE (
    produto_id INTEGER,
    produto_nome VARCHAR,
    quantidade_vendida BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p."IDproduto",
        p.nome,
        COUNT(i."IDvenda") as quantidade_vendida
    FROM produto p
    JOIN inclui i ON p."IDproduto" = i."IDproduto"
    GROUP BY p."IDproduto", p.nome
    ORDER BY quantidade_vendida DESC
    LIMIT limite;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_atualizar_precos_categoria(
    tipo_produto VARCHAR,
    percentual_aumento NUMERIC
) RETURNS INTEGER AS $$
DECLARE
    produtos_atualizados INTEGER;
BEGIN
    UPDATE produto
    SET preco = preco * (1 + percentual_aumento/100)
    WHERE tipo = tipo_produto;
    
    GET DIAGNOSTICS produtos_atualizados = ROW_COUNT;
    RETURN produtos_atualizados;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS
CREATE OR REPLACE FUNCTION tf_verificar_idade_minima()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idade < 13 THEN
        RAISE EXCEPTION 'Cliente deve ter no mínimo 13 anos de idade';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_verificar_idade_minima
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
EXECUTE FUNCTION tf_verificar_idade_minima();

CREATE OR REPLACE FUNCTION tf_atualizar_estoque()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE produto
    SET quantidade = quantidade - 1
    WHERE "IDproduto" = NEW."IDproduto";
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_atualizar_estoque
AFTER INSERT ON inclui
FOR EACH ROW
EXECUTE FUNCTION tf_atualizar_estoque();

CREATE TABLE IF NOT EXISTS log_alteracao_preco (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER,
    preco_antigo NUMERIC,
    preco_novo NUMERIC,
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION tf_registrar_alteracao_preco()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.preco <> OLD.preco THEN
        INSERT INTO log_alteracao_preco (produto_id, preco_antigo, preco_novo)
        VALUES (NEW."IDproduto", OLD.preco, NEW.preco);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_registrar_alteracao_preco
BEFORE UPDATE ON produto
FOR EACH ROW
EXECUTE FUNCTION tf_registrar_alteracao_preco();

-- Exemplo de EXPLAIN
EXPLAIN ANALYZE
SELECT v."IDvenda", v."dataVenda", v."valorTotal", 
       c.nome as cliente_nome, vd.nome as vendedor_nome,
       p.nome as produto_nome
FROM venda v
JOIN cliente c ON v."CPFcliente" = c."CPFcliente"
JOIN vendedor vd ON v."CPFvendedor" = vd."CPFvendedor"
JOIN inclui i ON v."IDvenda" = i."IDvenda"
JOIN produto p ON i."IDproduto" = p."IDproduto"
WHERE v."dataVenda" >= '2023-01-01'
ORDER BY v."dataVenda" DESC;

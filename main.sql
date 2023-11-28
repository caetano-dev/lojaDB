DROP DATABASE IF EXISTS loja;

CREATE DATABASE loja
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

DROP TABLE IF EXISTS public.produto;

CREATE TABLE IF NOT EXISTS public.produto
(
    "IDproduto" SERIAL PRIMARY KEY,
    nome character varying NOT NULL,
    marca character varying NOT NULL,
    tipo character varying NOT NULL,
    preco numeric NOT NULL CHECK (preco > 0),
    quantidade integer NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.produto
    OWNER to postgres;


DROP TABLE IF EXISTS public.cliente;

CREATE TABLE IF NOT EXISTS public.cliente
(
    nome character varying NOT NULL,
    email character varying NOT NULL,
    endereco character varying NOT NULL,
    idade numeric NOT NULL CHECK (idade >= 13),
    "CPFcliente" numeric PRIMARY KEY,
    telefone numeric NOT NULL,
    CONSTRAINT telefone UNIQUE (telefone)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cliente
    OWNER to postgres;


DROP TABLE IF EXISTS public.vendedor;

CREATE TABLE IF NOT EXISTS public.vendedor
(
    "CPFvendedor" numeric PRIMARY KEY,
    nome character varying NOT NULL,
    email character varying NOT NULL,
    salario numeric NOT NULL
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.vendedor
    OWNER to postgres;


DROP TABLE IF EXISTS public.venda;

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
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.venda
    OWNER to postgres;


DROP TABLE IF EXISTS public.fornecedor;

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
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fornecedor
    OWNER to postgres;


DROP TABLE IF EXISTS public.inclui;

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
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.inclui
    OWNER to postgres;


DROP TABLE IF EXISTS public.repoe;

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
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.repoe
    OWNER to postgres;

-- Table: public.funcionario

--DROP TABLE IF EXISTS public.funcionario;

CREATE TABLE IF NOT EXISTS public.funcionario
(
    "CPFfuncionario" character varying NOT NULL,
    nome character varying NOT NULL,
    cargo character varying NOT NULL,
    telefone numeric NOT NULL,
    email character varying NOT NULL,
    salario numeric NOT NULL,
    CONSTRAINT funcionario_pkey PRIMARY KEY ("CPFfuncionario"),
    CONSTRAINT telefone UNIQUE (telefone)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.funcionario
    OWNER to postgres;

---

-- Table: public.cliente

-- DROP TABLE IF EXISTS public.cliente;

CREATE TABLE IF NOT EXISTS public.cliente
(
    nome character varying NOT NULL,
    email character varying NOT NULL,
    endereco character varying NOT NULL,
    "CPFcliente" numeric NOT NULL,
    CONSTRAINT "CPFcliente" PRIMARY KEY ("CPFcliente")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cliente
    OWNER to postgres;


-- Table: public.fornecedor

-- DROP TABLE IF EXISTS public.fornecedor;

CREATE TABLE IF NOT EXISTS public.fornecedor
(
    "CNPJfornecedor" numeric NOT NULL,
    CONSTRAINT "CNPJfornecedor" PRIMARY KEY ("CNPJfornecedor")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fornecedor
    OWNER to postgres;


-- Table: public.produto

-- DROP TABLE IF EXISTS public.produto;

CREATE TABLE IF NOT EXISTS public.produto
(
    "IDproduto" integer NOT NULL,
    nome character varying NOT NULL,
    marca character varying NOT NULL,
    tipo character varying NOT NULL,
    preco numeric NOT NULL,
    "quantidadeEmEstoque" integer NOT NULL,
    CONSTRAINT produto_pkey PRIMARY KEY ("IDproduto")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.produto
    OWNER to postgres;


-- Table: public.venda

-- DROP TABLE IF EXISTS public.venda;

CREATE TABLE IF NOT EXISTS public.venda
(
    "IDvenda" integer NOT NULL,
    "dataVenda" date NOT NULL,
    "valorTotal" numeric NOT NULL,
    "CPFfuncionario" numeric NOT NULL,
    "CPFcliente" numeric varying NOT NULL,
    CONSTRAINT venda_pkey PRIMARY KEY ("IDvenda"),
    CONSTRAINT "CPFcliente" FOREIGN KEY ("CPFcliente")
        REFERENCES public.cliente ("CPFcliente") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "CPFfuncionario" FOREIGN KEY ("CPFfuncionario")
        REFERENCES public.funcionario ("CPFfuncionario") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.venda
    OWNER to postgres;
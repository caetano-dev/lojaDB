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

CREATE INDEX preco_gist_id ON public.produto USING gist (preco);

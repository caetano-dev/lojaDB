INSERT INTO public.produto ("IDproduto", nome, marca, tipo, preco, quantidade)
VALUES
    (1, 'Smartphone Galaxy S21', 'Samsung', 'Eletrônicos', 1200.0, 50),
    (2, 'Notebook Inspiron 15', 'Dell', 'Computadores', 900.0, 30),
    (3, 'Headphone Wireless', 'Sony', 'Acessórios', 150.0, 80),
    (4, 'Smart TV LED 55"', 'LG', 'Eletrônicos', 2000.0, 25),
    (5, 'Coffee Maker', 'Hamilton Beach', 'Eletrodomésticos', 80.0, 50),
    (6, 'Wireless Mouse', 'Logitech', 'Periféricos', 30.0, 100);

INSERT INTO public.cliente (nome, email, endereco, "CPFcliente", telefone)
VALUES
    ('Lucas Goncalves', 'lucas.goncalves@email.com', 'Rua das Rosas, 26', 12345678901, 1122334455),
    ('Carlos Eduardo', 'carlos.eduardo@email.com', 'Av. das Américas, 4666', 23456789012, 2233445566),
    ('Jose Mesquita', 'jose.mesquita@email.com', 'Rua Sá Ferreira, 789', 34567890123, 3344556677),
    ('Manoel Gomes', 'manoel.gomes@email.com', 'Estrada dos Bandeirantes, 56', 45678901234, 4455667788),
    ('Alan Turing', 'alan.turing@email.com', 'Av. Geremário Dantas, 789', 56789012345, 5566778899),
    ('Julio Cesar', 'julio.cesar@email.com', 'Estrada do Rio Grande, 12', 67890123456, 6677889900);

INSERT INTO public.vendedor ("CPFvendedor", nome, email, salario)
VALUES
    (98765432109, 'Pedro Saunders', 'pedro.saunders@email.com', 3500.0),
    (87654321098, 'Ramon Dino', 'ramon.dino@email.com', 4000.0),
    (76543210987, 'Maria Silva', 'maria.silva@email.com', 2800.0),
    (65432109876, 'Rodrigo Santos', 'rodrigo.santos@email.com', 3200.0),
    (54321098765, 'Juliana Costa', 'juliana.costa@email.com', 3800.0),
    (43210987654, 'Felipe Lima', 'felipe.lima@email.com', 3000.0);

INSERT INTO public.venda ("IDvenda", "dataVenda", "valorTotal", "CPFvendedor", "CPFcliente")
VALUES
    (1, '2023-11-10', 1500.0, 98765432109, 12345678901),
    (2, '2023-11-11', 1000.0, 87654321098, 23456789012),
    (3, '2023-11-12', 800.0, 76543210987, 34567890123),
    (4, '2023-11-13', 2200.0, 65432109876, 45678901234),
    (5, '2023-11-14', 3500.0, 54321098765, 56789012345),
    (6, '2023-11-15', 1200.0, 43210987654, 67890123456);

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

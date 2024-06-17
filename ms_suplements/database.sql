/* Criação do banco */
create database ms_bd
/* Criação das tabelas */
create table Produto (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL CHECK (estoque >= 0)
);

create table Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20)
);

create table Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT REFERENCES Cliente(id_cliente),
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL CHECK (valor_total >= 0)
);

create table ItemPedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal >= 0),
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

create table Funcionario (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2) NOT NULL CHECK (salario >= 0)
);
/* Criação dos registros (insert) */
insert into Produto (id_produto, nome, marca, preco, estoque)
values (1, 'Whey Protein', 'MS Suplements', 149.90, 50),
       (2, 'BCAA 2:1:1', 'MS Suplements', 89.99, 30),
       (3, 'Creatina Monohidratada', 'MS Suplements', 39.50, 100);

insert into Cliente (id_cliente, nome, email, telefone)
values (1, 'Pedro Henrique', 'peh.henri@email.com', '(11) 98765-4321'),
       (2, 'Maria Helena', 'maria.he@email.com', '(21) 91234-5678'),
       (3, 'Miguel Ferreira', 'miguel.fer@email.com', '(31) 99876-5432');

insert into Pedido (id_pedido, id_cliente, data_pedido, valor_total)
values (1, 1, '2024-06-15', 239.80),
       (2, 2, '2024-06-16', 179.99),
       (3, 3, '2024-06-17', 79.50);

insert into ItemPedido (id_pedido, id_produto, quantidade, subtotal)
values (1, 1, 2, 299.80),
       (1, 2, 1, 89.99),
       (2, 3, 3, 118.50);

insert into Funcionario (id_funcionario, nome, cargo, salario)
values (1, 'Fernanda Oliveira', 'Gerente de Vendas', 5000.00),
       (2, 'Rafael Santos', 'Atendente', 2500.00),
       (3, 'Juliana Lima', 'Estoquista', 2000.00);
/* Criação dos selects */
select * from Produto;

select * from Cliente;

select * from Pedido;
/* Criação dos joins */
select p.id_pedido, c.nome AS cliente, p.data_pedido, p.valor_total
from Pedido p
join Cliente c ON p.id_cliente = c.id_cliente;

select ip.id_pedido, pr.nome AS produto, ip.quantidade, ip.subtotal
from ItemPedido ip
join Produto pr ON ip.id_produto = pr.id_produto;

select p.id_pedido, c.nome AS cliente, ip.quantidade, pr.nome AS produto, pr.preco AS preco_unitario, ip.subtotal
from Pedido p
join Cliente c ON p.id_cliente = c.id_cliente
join ItemPedido ip ON p.id_pedido = ip.id_pedido
join Produto pr ON ip.id_produto = pr.id_produto;
/* Criação dos updates */
update Produto
set preco = 159.90
where id_produto = 1;

update Cliente
set telefone = '(11) 98765-1111'
where id_cliente = 1;

update Funcionario
set salario = salario * 1.1 
where id_funcionario = 2;
/* Criação das subconsultas*/
select nome, email
from Cliente
where id_cliente IN (SELECT DISTINCT id_cliente FROM Pedido);

select nome, estoque
from Produto
where estoque < (SELECT AVG(estoque) FROM Produto);
/* Criação das alter table*/
alter table Produto
add data_validade DATE;

alter table Cliente
drop COLUMN telefone;

alter table Funcionario
modify COLUMN cargo VARCHAR(100);
/* Criação dos deletes*/
delete from Pedido
where id_pedido = 3;

delete from Funcionario
where id_funcionario = 1;

/* Trabalho feito por: João Lucas Marigo e Moisés Shadeck
2 D.S */
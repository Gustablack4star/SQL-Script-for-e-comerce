Create database ecomerce;
use ecomerce;

create  table produto(
Id_produto int auto_increment primary key,
produto_nome varchar (100) not null,
produto_descricao varchar(500) not null,
produto_valor decimal(10,2) not null,
tamanho varchar(10),
peso_produto decimal (10,3),
produto_categoria enum ('Moveis', 'Eletronicos', 'Kids','automoveis','vestuario') not null,
produto_destaque boolean default false,
produto_ativo boolean default true,
data_postagem datetime default current_timestamp,
data_atualizacao datetime default current_timestamp 
);

create table cliente(
Id_cliente int auto_increment primary key,
       CPF char(11) unique not null,
	  cliente_Nome_completo varchar(255)not null,
      data_nascimento date,
      cliente_genero enum ('Maculino','Feminino', 'Outro'),
	  cliente_email varchar(100) not null,
      cliente_telefone char(12) not null,
	  cliente_CEP varchar(8) not null,
      cliente_endereco varchar(255) not null,
	  senha_cliente varchar(255),      
      cliente_status enum ('Bloqueado','Ativo','Inativo') default 'Ativo',
      ultimo_acesso datetime default current_timestamp
);

create table pedido(
Id_pedido int auto_increment primary key,
foreign key (Id_cliente) references cliente (Id_cliente),
data_pedido datetime default current_timestamp,
frete decimal (10,2) default "Gratís",
desconto_valor decimal (10,2),
observacoes varchar(500),
data_aprovacao datetime default current_timestamp,
data_envio datetime default current_timestamp,
data_entrega datetime default current_timestamp,
data_cancelamento datetime default current_timestamp,
valor_total decimal (10,2) not null,
status_pedido enum ('Aguardando pagamento','Pago','Processando','Enviado','Cancelado','Devolvido'),
quantidade int not null 
);

create table estoque(
ID_estoque int auto_increment primary key,
foreign key (Id_produto) references produto (Id_produto),
estoque_quantidade int,
endereco_estoque varchar(255),
data_entrada datetime default current_timestamp,
data_saida datetime default current_timestamp,
custo_unitario decimal(10,2),
estoque_minimo int default '1',
estoque_maximo int not null
);

create table vendedores(
Id_vendedor int auto_increment primary key,
tipo_vendedor enum ('Pessoa Fisíca','Pessoa Juridíca')not null,
email varchar(100),
telefone varchar(11),
documento char(14) unique not null,
Nome_fantasia varchar (40),
local_loja varchar(255),
Data_cadastro datetime default current_timestamp
);

create table fornecedor(
Id_fornecedor int auto_increment primary key,
CNPJ char(14) not null unique,
Nome_completo varchar(200),
Contato varchar(11),
email varchar(80),
endereco_fornecedor varchar(500),
preco_compra decimal (10,2),
quantidade int default'1',
prazo_entrega int not null,
foreign key (Id_produto) references produto (Id_produto),
foreign key (Id_fornecedor) references fornecedor (Id_fornecedor)
);

CREATE TABLE vendedor(
Id_vendedor int auto_increment primary key,
Id_vendedor int not null unique,
data_venda datetime default current_timestamp,
produto_quatidade int not null,
foreign key (Id_produto) references produto (Id_produto),
foreign key (Id_vendedor) references vendedor (Id_vendedor)
);

create table enderecos(
Id_endereco int auto_increment primary key,
CEP varchar (8) not null,
Rua varchar (100) not null,
Bairro varchar (50) not null,
Município varchar(50) not null,
numero_casa varchar (10) not null,
Complemmento varchar (150),
Estado enum  ('SP', 'RJ','AC','AL','AP','AM','BA','CE', 'DF','ES','GO', 'MA', 'MT','MS','MG', 'PA', 'PB','PR', 'PE','PI','RN','RS','RO','RR','SC','SE', 'TO')not null,
Endereco_principal boolean default false,
foreign key (Id_cliente) references cliente (id_cliente)
);

create table pagamento(
Id_pagamento int auto_increment primary key,
forma_pagamento enum ('Cartão débito', 'Cartão crédito','Pix', 'boleto'),
metodo_ativo boolean default true
);

create table avaliacao(
id_avaliacao int auto_increment primary key,
Id_cliente int not null,
data_avalicao date default current_timestamp,
comentario text,
nota decimal(2,1) not null check (nota>=1 and nota<=5),
foreign key (Id_cliente) references cliente (id_cliente),
foreign key (Id_produto) references produto (Id_produto)
);
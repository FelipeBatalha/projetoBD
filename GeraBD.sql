create schema `projeto_bd` ;
use `projeto_bd`;

CREATE TABLE `aluno` (
    `matr_aluno` INT(9) NOT NULL,
    `nome` VARCHAR(60) NOT NULL,
    `curso` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`matr_aluno`)
);

create table `departamento` (
  `sigla_dp` varchar(10) not null,
  `nome` varchar(45) not null,
  primary key (`sigla_dp`));

create table `professor` (
  `matr_professor` int(9) not null,
  `nome` varchar(60) not null,
  `sigla_dp` varchar(10) not null,
  primary key (`matr_professor`),
  index `fk_professor_departamento1_idx` (`sigla_dp` asc) visible,
  constraint `fk_professor_departamento1`
    foreign key (`sigla_dp`)
    references `projeto_bd`.`departamento` (`sigla_dp`)
    on delete no action
    on update no action);

create table `disciplina` (
  `cod_disc` int not null,
  `turma_disc` varchar(45) not null,
  `nome` varchar(45) not null,
  `sigla_dp` varchar(10) not null,
  primary key (`cod_disc`, `turma_disc`),
  index `fk_disciplina_departamento1_idx` (`sigla_dp` asc) visible,
  constraint `fk_disciplina_departamento1`
    foreign key (`sigla_dp`)
    references `projeto_bd`.`departamento` (`sigla_dp`)
    on delete no action
    on update no action);

create table `tipos_de_plataformas` (
  `cod_tipoplat` int not null,
  `categ_tipoplat` varchar(45) not null,
  primary key (`cod_tipoplat`));

create table `plataformas` (
  `nome_plat` varchar(45) not null,
  `capacidade` float null,
  `cod_tipoplat` int not null,
  index `fk_plataformas_tipos_de_plataformas1_idx` (`cod_tipoplat` asc) visible,
  primary key (`nome_plat`),
  constraint `fk_plataformas_tipos_de_plataformas1`
    foreign key (`cod_tipoplat`)
    references `projeto_bd`.`tipos_de_plataformas` (`cod_tipoplat`)
    on delete no action
    on update no action);

create table `tipos_de_atividades` (
  `cod_tipoativ` int not null,
  `categ_tipoativ` varchar(45) not null,
  primary key (`cod_tipoativ`));

create table `atividades` (
  `id_atividades` int not null auto_increment,
  `dt_limite` date not null,
  `desc_atividades` varchar(100) not null,
  `nota_max` float not null,
  `cod_tipoativ` int not null,
  `matr_professor` int(9) not null,
  `cod_disc` int not null,
  `turma_disc` varchar(45) not null,
  `nome_plat` varchar(45) not null,
  primary key (`id_atividades`),
  index `fk_atividades_tipos_de_atividades1_idx` (`cod_tipoativ` asc) visible,
  index `fk_atividades_professor1_idx` (`matr_professor` asc) visible,
  index `fk_atividades_disciplina1_idx` (`cod_disc` asc, `turma_disc` asc) visible,
  index `fk_atividades_plataformas1_idx` (`nome_plat` asc) visible,
  constraint `fk_atividades_tipos_de_atividades1`
    foreign key (`cod_tipoativ`)
    references `projeto_bd`.`tipos_de_atividades` (`cod_tipoativ`)
    on delete no action
    on update no action,
  constraint `fk_atividades_professor1`
    foreign key (`matr_professor`)
    references `projeto_bd`.`professor` (`matr_professor`)
    on delete no action
    on update no action,
  constraint `fk_atividades_disciplina1`
    foreign key (`cod_disc` , `turma_disc`)
    references `projeto_bd`.`disciplina` (`cod_disc` , `turma_disc`)
    on delete no action
    on update no action,
  constraint `fk_atividades_plataformas1`
    foreign key (`nome_plat`)
    references `projeto_bd`.`plataformas` (`nome_plat`)
    on delete no action
    on update no action);
    
create table `materiais` (
  `nome_mat` varchar(45) not null,
  `preço_medio` float not null,
  primary key (`nome_mat`));

create table `percepcoes_ead` (
  `id_percep` int not null auto_increment,
  `data_percep` date not null,
  `disp_tempo` varchar(100) not null,
  `preferencias` varchar(100) not null,
  `qualidade_amb` varchar(45) not null,
  `qualidade_net` varchar(45) not null,
  `matr_aluno` int(9) not null,
  primary key (`id_percep`),
  index `fk_percepcoes_ead_aluno1_idx` (`matr_aluno` asc) visible,
  constraint `fk_percepcoes_ead_aluno1`
    foreign key (`matr_aluno`)
    references `projeto_bd`.`aluno` (`matr_aluno`)
    on delete no action
    on update no action);

create table `aluno_atividades` (
  `matr_aluno` int(9) not null,
  `id_atividades` int not null,
  `dt_entrega` date null,
  `nota_aluno` float null,
  primary key (`matr_aluno`, `id_atividades`),
  index `fk_aluno_has_atividades_atividades1_idx` (`id_atividades` asc) visible,
  index `fk_aluno_has_atividades_aluno1_idx` (`matr_aluno` asc) visible,
  constraint `fk_aluno_has_atividades_aluno1`
    foreign key (`matr_aluno`)
    references `projeto_bd`.`aluno` (`matr_aluno`)
    on delete no action
    on update no action,
  constraint `fk_aluno_has_atividades_atividades1`
    foreign key (`id_atividades`)
    references `projeto_bd`.`atividades` (`id_atividades`)
    on delete no action
    on update no action);

create table `disciplina_aluno` (
  `cod_disc` int not null,
  `turma_disc` varchar(45) not null,
  `matr_aluno` int(9) not null,
  primary key (`cod_disc`, `turma_disc`, `matr_aluno`),
  index `fk_disciplina_has_aluno_aluno1_idx` (`matr_aluno` asc) visible,
  index `fk_disciplina_has_aluno_disciplina1_idx` (`cod_disc` asc, `turma_disc` asc) visible,
  constraint `fk_disciplina_has_aluno_disciplina1`
    foreign key (`cod_disc` , `turma_disc`)
    references `projeto_bd`.`disciplina` (`cod_disc` , `turma_disc`)
    on delete no action
    on update no action,
  constraint `fk_disciplina_has_aluno_aluno1`
    foreign key (`matr_aluno`)
    references `projeto_bd`.`aluno` (`matr_aluno`)
    on delete no action
    on update no action);

create table `disciplina_professor` (
  `cod_disc` int not null,
  `turma_disc` varchar(45) not null,
  `matr_professor` int(9) not null,
  primary key (`cod_disc`, `turma_disc`, `matr_professor`),
  index `fk_disciplina_has_professor_professor1_idx` (`matr_professor` asc) visible,
  index `fk_disciplina_has_professor_disciplina1_idx` (`cod_disc` asc, `turma_disc` asc) visible,
  constraint `fk_disciplina_has_professor_disciplina1`
    foreign key (`cod_disc` , `turma_disc`)
    references `projeto_bd`.`disciplina` (`cod_disc` , `turma_disc`)
    on delete no action
    on update no action,
  constraint `fk_disciplina_has_professor_professor1`
    foreign key (`matr_professor`)
    references `projeto_bd`.`professor` (`matr_professor`)
    on delete no action
    on update no action);

create table `disciplina_plataformas` (
  `disciplina_cod_disc` int not null,
  `disciplina_turma_disc` varchar(45) not null,
  `plataformas_nome_plat` varchar(45) not null,
  primary key (`disciplina_cod_disc`, `disciplina_turma_disc`, `plataformas_nome_plat`),
  index `fk_disciplina_plataformas_plataformas1_idx` (`plataformas_nome_plat` asc) visible,
  index `fk_disciplina_plataformas_disciplina1_idx` (`disciplina_cod_disc` asc, `disciplina_turma_disc` asc) visible,
  constraint `fk_disciplina_plataformas_disciplina1`
    foreign key (`disciplina_cod_disc` , `disciplina_turma_disc`)
    references `projeto_bd`.`disciplina` (`cod_disc` , `turma_disc`)
    on delete no action
    on update no action,
  constraint `fk_disciplina_plataformas_plataformas1`
    foreign key (`plataformas_nome_plat`)
    references `projeto_bd`.`plataformas` (`nome_plat`)
    on delete no action
    on update no action);

create table `aluno_materiais` (
  `aluno_matr_aluno` int(9) not null,
  `materiais_nome_mat` varchar(45) not null,
  primary key (`materiais_nome_mat`, `aluno_matr_aluno`),
  index `fk_aluno_materiais_aluno1_idx` (`aluno_matr_aluno` asc) visible,
  index `fk_aluno_materiais_materiais1_idx` (`materiais_nome_mat` asc) visible,
  constraint `fk_aluno_materiais_materiais1`
    foreign key (`materiais_nome_mat`)
    references `projeto_bd`.`materiais` (`nome_mat`)
    on delete no action
    on update no action,
  constraint `fk_aluno_materiais_aluno1`
    foreign key (`aluno_matr_aluno`)
    references `projeto_bd`.`aluno` (`matr_aluno`)
    on delete no action
    on update no action);

create table `professor_materiais` (
  `professor_matr_professor` int(9) not null,
  `materiais_nome_mat` varchar(45) not null,
  primary key (`professor_matr_professor`, `materiais_nome_mat`),
  index `fk_professor_materiais_materiais1_idx` (`materiais_nome_mat` asc) visible,
  index `fk_professor_materiais_professor1_idx` (`professor_matr_professor` asc) visible,
  constraint `fk_professor_materiais_professor1`
    foreign key (`professor_matr_professor`)
    references `projeto_bd`.`professor` (`matr_professor`)
    on delete no action
    on update no action, 
  constraint `fk_professor_materiais_materiais1`
    foreign key (`materiais_nome_mat`)
    references `projeto_bd`.`materiais` (`nome_mat`)
    on delete no action
    on update no action);
    
insert into `departamento` values ('CIC','Departamento de Ciencia da Computacao'),('FIS','Departamento de Fisica'),('GEO','Departamento de Geografia'),('LET','Departamento de Letras'),('MAT','Departamento de Matematica');
insert into `disciplina` values (1234,'A','Calculo','MAT'),(2345,'E','Gramatica','LET'),(4321,'C','Logica Computacional','CIC'),(6789,'A','Relatividade','FIS'),(7654,'B','Geopolitica','GEO');
insert into `professor` values (12344321,'Fabio Carvalho','GEO'),(54322345,'Felipe Batalha','CIC'),(101234567,'Maristela Holanda','CIC'),(769458279,'Thiago Monteiro','LET'),(907685431,'Vitor von Doom','FIS');
insert into `tipos_de_plataformas` values (1,'Ambiente virtual'),(2,'Streaming de video'),(3,'Video conferencia'),(4,'Email'),(5,'Forum');
insert into `materiais` values ('Notebook',2500), ('WiFi',250), ('Smartphone',1000), ('Tablet',2500), ('Microfone',50);
insert into `professor_materiais` values (12344321,'Notebook'),(12344321,'Smartphone'),(54322345,'Notebook'),(769458279,'Notebook'),(769458279,'Tablet'),(907685431,'Microfone');
insert into `aluno` values (19344321,'Fabiana Morais','Geografia'),(18322345,'Felipe Campos','Computacao'),(151234567,'Maria Duarte','Engenharia Mecatronica'),(169458279,'Tiago Kross','Letras'),(207685431,'Victor dos Santos','Fisica');
insert into `aluno_materiais` values (19344321,'Notebook'),(18322345,'Smartphone'),(151234567,'Notebook'),(169458279,'Notebook'),(207685431,'Tablet'),(207685431,'Microfone');
insert into `tipos_de_atividades` values (1,'Postagem forum'),(2,'Resenha'),(3,'Video'),(4,'Apresentacao'),(5,'Questionario'),(6,'Relatorio'), (7,'Teste'),(8,'Lista de exercicios');
insert into `plataformas` values ('Aprender',500.6,1),('Aprender 3',1000,1),('Teams',1000,3),('Youtube',10000,2),('Outlook',1000.23,4); 
insert into `disciplina_plataformas` values (1234,'A','Aprender 3'),(1234,'A','Youtube'),(4321,'C','Aprender'),(4321,'C','Teams'),(7654,'B','Aprender');
insert into `disciplina_aluno` values (7654,'B',19344321),(4321,'C',18322345),(1234,'A',151234567),(2345,'E',169458279),(6789,'A',207685431);
insert into `disciplina_professor` values (1234,'A',907685431),(2345,'E',769458279),(4321,'C',54322345),(6789,'A',907685431),(7654,'B',12344321);
insert into `atividades` values (default,'2020-10-23','Resolver exercicios do Cap 5',1.0 ,8,907685431,1234,'A','Aprender 3'),
(default,'2020-09-22','Resolver exercicios do Cap 3',1.5 ,8,907685431,6789,'A','Aprender 3'),
(default,'2020-09-17','Postar uma pergunta no forum e responder duas dos demais colegas',0.5 ,1,12344321,7654,'B','Aprender'),
(default,'2020-09-10','Apresentar na proxima aula o tema sorteado',1.0 ,4,769458279,2345,'E','Teams'),
(default,'2020-11-15','Segundo teste da disciplina',4.0 ,7,54322345,4321,'C','Aprender 3');
insert into `aluno_atividades` values (151234567,1,'2020-10-23',0.8),(207685431,2,'2020-09-22',1.3),(19344321,3,'2020-09-17',0.0),(169458279,4,'2020-09-10',0.5),(18322345,5,'2020-11-15',2.75);
insert into `percepcoes_ead` values(default,'2020-09-23','Tempo razoavel para as entregas assincronas','Tenho gostado das atividades propostas','Alta','Alta',18322345),
(default,'2020-10-24','Atividades assincronas tomam muito tempo','Acho que deveriamos ter menos entregas semanais','Media','Alta',151234567),
(default,'2020-09-21','Muitas entregas semanais interferem na realizacao dos trabalhos mais complicados','Prefiro menos entregas com foco no trabalho final','Media','Baixa',169458279),
(default,'2020-10-02','Tempo de sobra para realizar as atividades','Gostaria de atividades bonus valendo ponto extra','Alta','Media',207685431),
(default,'2020-11-05','Pouco tempo para fazer as atividades','Prefiro mais testes e listas','Media','Media',19344321);


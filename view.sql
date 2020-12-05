create view disc_plataform as
select nome, plataformas_nome_plat from disciplina, disciplina_plataformas WHERE disciplina_plataformas.disciplina_cod_disc = disciplina.cod_disc;

select * from disciplina;
select * from plataforma;
-- selecionando a view
select * from disc_plataform;


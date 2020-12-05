import MySQLdb
from time import sleep
from os import system, name

def clear():  
    if name == 'nt': 
        _ = system('cls') 

servidor, bd = "localhost", "projeto_bd"
usuario = input("Bem vindo ao banco de dados do projeto EAD. Digite o seu usuário: ")
senha = input("Senha: ")
conexao = MySQLdb.connect(servidor, "root", "root", bd)
cursor = conexao.cursor(MySQLdb.cursors.DictCursor)
tabelas_bd = []

#Mostra e enumera as tabelas do BD
def listar_tabelas():
  print("CRUD básico feito por Felipe Batalha para a disciplina de BD\n\n")
  cursor.execute("SHOW tables")
  tables = cursor.fetchall()
  print(f"As tabelas pertencentes ao BD são:")
  for i in range(len(tables)):
    nome = (str(list(tables[i].values())))  #transforma o valor de cada dicionario em string
    nome = nome[2:-2] #remove colchetes e aspas
    tabelas_bd.append(nome)
    print(f"{i}) {tabelas_bd[i]}")

def tabela():
  id_tabela = 99
  while id_tabela < 0 or  id_tabela > 17:
    id_tabela = int(input("Com qual tabela deseja interagir? (digite o numero correspondente a ela): "))
  clear()
  return tabelas_bd[id_tabela]

def comando_SQL(SQL):
  try:
    cursor.execute(SQL)
    conexao.commit()
    clear()
    print("Comando executado com sucesso")
    sleep(2)
    clear()
    listar_tabelas()
    control(tabela())
  except:
    clear()
    print("Comando nao executado")
    sleep(2)
    clear()
    listar_tabelas()
    control(tabela())
    conexao.rollback()

def varchar(x0,x1):
  x = input()
  if x1[:3] == 'var':
    return f"'{x}'"
  else:
    return f"{x}"

def columns(tabela):
  i= 0
  cursor.execute(f"SHOW columns FROM {tabela}")
  cols = cursor.fetchall()
  insert_fields = []
  colunas = []
  for i in range(len(cols)):
    nome = (list(cols[i].values()))
    insert_fields.append(nome)
    colunas.append(insert_fields[i])
  return colunas

def insert(tabela):
  i= 0
  print(f"Inserir na tabela {tabela}: ")
  cursor.execute(f"SHOW columns FROM {tabela}")
  cols = cursor.fetchall()
  dados = []
  insert_fields = []
  for i in range(len(cols)):
    nome = (list(cols[i].values()))
    insert_fields.append(nome)
    print(f"{insert_fields[i][0]}({insert_fields[i][1]}): ")
    dados.append(varchar(insert_fields[i][0],insert_fields[i][1]))
  comando_SQL(f"INSERT INTO {tabela} VALUES ({','.join(dados)});")

def select(tabela):
  j = 0
  colunas = columns(tabela)
  nome_colunas = []
  for j in range(len(colunas)):
    nome_colunas.append(colunas[j][0])
  i = 0
  print(f"Selecao da tabela {tabela}: ")
  cursor.execute(f"SELECT * FROM {tabela};")
  cols = cursor.fetchall()
  insert_fields = []
  print(f"|  {' | '.join(nome_colunas)}  |")
  for i in range(len(cols)):
    nome = (list(cols[i].values()))
    insert_fields.append(nome)
    print(nome)
  print("\n")
 
def update(tabela):
  i = 0
  colunas = columns(tabela)
  for i in range(len(colunas)):
    print(f"{i}) {colunas[i][0]}")
  nome1 = int(input("Qual atributo deseja atualizar? (informe o número de uma das colunas listadas): "))
  nome2 = int(input("Digite qual atributo vai localizar o campo de interesse (informe o número de uma das colunas listadas): "))
  print("Valor do atributo localizador: ")
  valor2 = varchar(colunas[nome2][0],colunas[nome2][1])
  print(f"Novo valor de {colunas[nome1][0]}: ",end="")
  valor1 = varchar(colunas[nome1][0],colunas[nome1][1])
  comando_SQL(f"UPDATE {tabela} SET {colunas[nome1][0]} = {valor1} WHERE {colunas[nome2][0]} = {valor2}")
 
def control(tabela):
  listar_tabelas()
  op = input("Digite a letra correspondente a operacao que deseja realizar:\nC) Inserir\nR) Selecionar\nU) Atualizar\nD) Deletar\n\nQ) Sair\n")
  if (op == 'C'):
    clear()
    insert(tabela)
  elif (op == 'R'):
    clear()
    select(tabela)
  elif (op == 'U'):
    clear()
    update(tabela)
  elif (op == 'D'):
    clear()
    delete(tabela)
  elif (op == 'Q'):
    clear()
    conexao.close()
  else:
    print("Digite apenas C, R, U ou D, conforme especificado acima")
    control(tabela)
    
def delete(tabela):
  i = 0
  colunas = columns(tabela)
  for i in range(len(colunas)):
    print(f"{i}) {colunas[i][0]}")
  nome1 = int(input("Informar a qual coluna pertence o valor do(s) atributo(s) que deseja deletar (informe o número de uma das colunas listadas): "))
  print("Digite o valor do(s) atributo(s) cuja(s) intancia(s) sera(o) excluida(s): ",end="")
  valor1 = varchar(colunas[nome1][0],colunas[nome1][1])
  print(f"DELETE FROM {tabela}  WHERE {colunas[nome1][0]} = {valor1}")
  comando_SQL(f"DELETE FROM {tabela}  WHERE {colunas[nome1][0]} = {valor1}")

def main():
  listar_tabelas()
  control(tabela())

main()
conexao.close()
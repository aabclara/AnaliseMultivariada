# SEÇÃO Primeira aula de Análise Multivariada (Ctrl + Shift + R)
a <- 3 + 8 # atribui valor a a
d <- 20 / 4 # atribui valor a d

a # imprime o valor em a
print(d) # imprime o valor em d

# SEÇÃO: Funções Matemáticas (Ctrl + Shift + R)
abs(-7.5) # valor absoluto

log(20) # Log na base e
log10(20) # Log na base 10
log(20, 2) # Log de 20 na base 2

# SEÇÃO: Trabalhando com variáveis (Ctrl + Shift + R)
    # Limpa o console (Ctrl + L)
preco <- 10
quantidade <- 3

total <- preco * quantidade
total # imprime o valor

    # Considere as notas:
n1 <- 8.5
n2 <- 9.0
n3 <- 7.5
    # Calcule a média
media <- (n1 + n2 + n3) / 3
print(media)
    # Resolução
notas <- c(n1, n2, n3) # cria um vetor com as notas
mean(notas) # calcula a média utilizando a função mean

#
n1 <- 8.5
n2 <- 9.0
n3 <- 7.5
notas <- c(n1, n2, n3) # cria um vetor com as notas

alunos <- c("Ana", "Bruno", "Carlos")
print(alunos)

disciplinas <- c("Matematica", "Portugues", "Fisica")

# Criando um dataframe
historico <- data.frame(disciplinas, notas)
print(historico)
view(historico) 

# Exercício 1
saldo <- 1500
salario <- 1000
gastos <- 200

entradas <- saldo + salario

saldo_final <- entradas - gastos
print(saldo_final)

# Exercício 2

produtos <- c("Notebook", "Smartphone", "Tablet", "Fone de Ouvido", "Carregador")
quantidades <- c(12, 16, 28, 8, 18)

estoque <- data.frame(produtos, quantidades)
print(estoque)

#view(estoque)

sum(estoque[ , 2])
reposicao <- estoque[ , 2] < 15
print(reposicao)

# Atividade 1 - DataFrame
alunos <- c("Mariana", "Henrique", "João", "Carlos", "Fernanda")
idade <- c(22, 23, 15, 28, 24)
genero <- c("F", "M", "M", "M", "F")
aprovado <- c(TRUE, FALSE, FALSE, TRUE, TRUE)

boletim <- data.frame(alunos, idade, genero, aprovado)
print(boletim)
print("-------------------------------------")
# boletim[ ,1:2]
# boletim[1:2, ]

print(boletim[3,2]) # Acessa a terceira linha, segunda coluna
boletim[3,2] <- 25

print("-------------------------------------")
boletim$nota <- c(8.8, 4.7, 5.0, 9.0, 8.0) #Cria uma nova variavel chamada nota
print(boletim)

print("-------------------------------------")
boletim$genero <- NULL
print(boletim)

# Atividade 2: Trabalhando com for

notas <- c(8.8, 4.7, 5.0, 9.0, 8.0)
n <- length(notas) # Calcula o tamanho do vetor

# Criar um for para somar 0.5 para cada nota da lista
nota_final = numeric(n)

for (i in 1:n) {
    nota_final[i] <- notas[i] + 0.5
}

print(nota_final)

print("OUTRAS RESOLUÇÕES")
# Outras resoluções
for (i in seq_along(notas)) {
    notas[i] <- notas[i] + 0.5
}
notas

alunos <- c("Mariana", "Henrique", "João", "Carlos", "Fernanda")
idade <- c(22, 23, 15, 28, 24)
aprovado <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
boletim <- data.frame(alunos, idade)

boletim$nota <- c(8.8, 4.7, 5.0, 9.0, 8.0)
print(boletim)

print("---------------------------")
if(!require(ggplot2)) install.packages("ggplot2")

if (!require(ggplot2)){
    install.packages("ggplot2")
}

library(ggplot2)

# 1. Seus dados
alunos <- c("Mariana", "Henrique", "João", "Carlos", "Fernanda")
idade <- c(22, 23, 15, 20, 24)
boletim <- data.frame(alunos, idade)
boletim$nota <- c(8.8, 4.7, 5.0, 9.0, 8.0)
print(boletim)

# Gráfico de barras Aluno x Idade
ggplot(boletim, aes(x = boletim$alunos, y = boletim$idade)) + geom_col()

# Gráfico de barras horizontal Aluno x Notas
ggplot(boletim, aes(x = boletim$alunos, y = boletim$nota)) + geom_col() + coord_flip()

# r-charts.com/colors

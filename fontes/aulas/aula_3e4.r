
# Análise dos Estudantes --------------------------------------------------

estudante <- c("A", "B", "C", "D", "E")
horas_estudo <- c(12, 5, 10, 4, 8)
faltas <- c(2, 8, 1, 10, 3)
nota_final <- c(8.5, 5.5, 9.0, 4.5, 7.5)

desempenho_escolar <- data.frame(estudante, horas_estudo, faltas, nota_final)
print(desempenho_escolar)

# Calculo da média por Coluna com colMeans
media <- colMeans(desempenho_escolar[2:4])
print(media)

# Calculando o resumo dos dados
summary(desempenho_escolar[2:4])

# Calculo da correlação dos dados
  # Interpretação dos dados!!
  # Próximo de 0: Correlação fraca 
  # Próxima de 1: Correlação positiva (cresce - cresce)
  # Próxima de -1: Correlação negativa (cresce - decresce)
cor(desempenho_escolar$horas_estudo, desempenho_escolar$nota_final)

# Calculo da matriz de correlação
  # Diagonal principal = 1 (X com X)
  # Matriz simétrica
cor(desempenho_escolar[2:4])

# Grafico da correlação
pairs(desempenho_escolar[, 2:4])

if (!require(psych)) install.packages("psych")

pairs.panels(desempenho_escolar[, 2:4])

# Exemplo 1: Aula de Fundamentos de Estatística

dados <- delitos_sp

# Calcular a média por variável
media <- colMeans(dados[ ,2:5])
print(media)

# Somar o total de cada variável
soma <- colSums(dados[ ,2:5])
print(soma)

# Calcular a variancia de uma coluna
var(dados$Homicídio.doloso)

# Calcular a variancia por coluna
variancia <- c()

for (col in colnames(dados)[2:5]) {
  variancia[col] <- var(dados[[col]])
}
print(variancia)

# Outra solução
# for (i in 1:4){
#    variancia[i] <- var(dados[ ,i+1])
#}

nomes <- colnames(dados[ , 2:5])
nomes
variancia_df <- data.frame(nomes, variancia)
variancia_df

# Calcular a matriz de covariancia
cov(dados[,2:5])

# Exercícios Aula 17/08
dados <- exercicio.dados_cor

#1. Calcule a média para cada variável
media_coluna <- colMeans(dados)
print(media_coluna)



#2. Identifique a empresa que possui o maior e o menor número de funcionários
empresa_mais_func <- dados$Empresa[which.max(dados$N_Funcionarios)]

empresa_menos_func <- dados$Empresa[which.min(dados$N_Funcionarios)]

cat("Enpresa com maior nº de funcionários:", empresa_mais_func, "\n")
cat("Empresa com menor nº de funcionários:", empresa_menos_func, "\n")



#3. Identifique a empresa que possui a maior quantidade de clientes
empresa_max_cli <- dados$Empresa[which.max(dados$Clientes)]

cat("Maior quantidade de clientes:", empresa_max_cli, "\n")



#4. Calcule a matriz de covariância
matriz_cov <- cov(dados[, 2:5])
print(matriz_cov)

#5. Calcule as correlações e analise
matriz_cor <- cor(dados[, 2:5])
print(matriz_cor)


# Atividade 18/08 ---------------------------------------------------------

dados <- pardais
#x1 = comprimento total
#x2 = extensão alar
#x3 = comprimento do bico e cabeça
#x4 = comprimento do umero
#x5 = comprimento da quilha do esterno
#x6 = comprimento

##Teste de normalidade (Shapiro-Wilk)
# Maior que 5% para distribuição normal
shapiro.test(dados$X1) # Distribuição não-normal <5%
shapiro.test(dados$X2) # Distribuição normal >5%

# Criando variável sobreviventes e não sobreviventes ----------------------
sobreviventes <- rep(c("sobreviventes"), 22)
mortes <- rep(c("mortos"), 27)
X6 <- c(sobreviventes, mortes)

dados$X6 <- X6
print(dados)

##Teste de médias (teste t)
# H0: as médias são iguais
t.test(dados$X1 ~ dados$X6) # p-value > 5%, as médias são iguais

t.test(dados$X4 ~ dados$X6) # p-value > 5%, as médias são iguais

## Teste de homocedastidade (teste M de Box) ---------------------------
# H0: a matriz de covariancia é homogenea
if (!require(biotools)) install.packages("biotools")
library(biotools)

boxM(dados[ ,2:6], dados$X6)

#Atividade 2: Dados peixes ----
dados <- peixe

##Realizando o teste ANOVA ----
  #ANOVA: Compara a média de três grupos/variaveis
  #H0: As medias são iguais
anova_peixe = aov(dados$desempenho ~ dados$tecnica, data = dados)
summary(anova_peixe)
#As medias são diferentes

##Teste de Tukey ----
  #Verificar se há algum grupo diferente ou todos são diferentes
if (!require(multcompView)) install.packages("multcompView")
library(multcompView)

TukeyHSD(anova_peixe)

#Atividade 3
  #Para os dados coração, faça:
  # 1) Verifique a normalidade das variáveis Pressão e Glicemia
  # 2) Compare as médias para Pressão e Glicemia

dados <- coracao
  
  # 1)
    # H0: as variáveis possuem distribuição normal
shapiro.test(dados$Pressao) # Distribuição normal > 5%
shapiro.test(dados$Glicemia) # Distribuição normal > 5%

  # 2) H0: as médias são iguais
anova_pressao <- aov(Pressao ~ Grupo, data = dados)
summary(anova_pressao) # São diferentes < 5%

anova_glicemia <- aov(Glicemia ~ Grupo, data = dados)
summary(anova_glicemia) # São iguais > 5%

TukeyHSD(anova_pressao)
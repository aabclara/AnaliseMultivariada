dados <- data.frame(
  curso = factor(c(rep("Engenharia",10),
                   rep("Sistemas",10),
                   rep("Administracao",10))),
  horas_estudo = c(15,12,14,10,13,16,14,11,15,13,
                   10,9,12,11,10,13,12,9,11,10,
                   8,7,9,6,8,7,9,8,6,7),
  nota_estatistica = c(80,75,78,70,76,85,82,74,79,77,
                       72,68,74,70,69,75,73,67,71,70,
                       65,60,66,58,64,62,67,63,59,61),
  nota_matematica = c(85,80,83,75,82,88,86,79,84,81,
                      70,68,72,69,71,74,73,67,70,68,
                      60,58,62,55,59,57,63,61,56,58),
  nota_programacao = c(70,68,72,65,69,74,73,67,71,70,
                       85,82,88,84,86,90,87,83,89,85,
                       55,52,58,50,54,53,57,56,51,52)
)

View(dados)

# Calcular a média das variáveis quantitivas
  # horas de estudo, nota de estatística, nota de matemática, nota de programação
media_estudo = mean(dados$horas_estudo)
print(media_estudo)

media_estatistica = mean(dados$nota_estatistica)
print(media_estatistica)

media_matematica = mean(dados$nota_matematica)
print(media_matematica)

media_prog = mean(dados$nota_programacao)
print(media_prog)


# Calcule a média por curso
aggregate(. ~ curso, data = dados, FUN = mean)

# Matriz de Covariância
matriz_cov <- cov(dados[, c("nota_estatistica", "nota_matematica", "nota_programacao")])
print(matriz_cov)

# Matriz de Correlação
matriz_cor <- cor(dados[, c("nota_estatistica", "nota_matematica", "nota_programacao")])
print(matriz_cor)

# A variável Nota de estatística segue distribuição normal(Shapiro-Wilk)
shapiro.test(dados$nota_estatistica)
shapiro.test(dados$nota_matematica)
shapiro.test(dados$nota_programacao)

# Histogramas separados
hist(dados$nota_estatistica)
hist(dados$nota_matematica)
hist(dados$nota_programacao)

# Histograma Único
par(mfrow = c(1, 3))
hist(dados$nota_estatistica)
hist(dados$nota_matematica)
hist(dados$nota_programacao)

# Teste de médias entre as notas de matemática do curso (T-test)
eng <- subset(dados, curso == "Engenharia")
sis <- subset(dados, curso == "Sistemas")
View(eng)
View(sis)

t.test(eng$nota_matematica, sis$nota_matematica)


# Teste de M-Box
# 1. Carrega o pacote (se não tiver instalado, rode: install.packages("biotools"))
library(biotools)

# 2. Executa o teste M de Box
# Sintaxe: boxM(data = variaveis_numericas, grouping = variavel_categorica)
resultado_box <- boxM(dados[, c("nota_estatistica", "nota_matematica", "nota_programacao")], 
                      grouping = dados$curso)

# 3. Exibe o resultado
print(resultado_box)

# 1. Ajuste e sumário da ANOVA para nota_estatistica
modelo_estat <- aov(nota_estatistica ~ curso, data = dados)
summary(modelo_estat)

# 2. Teste de Tukey post-hoc (para ver os pares que diferem)
TukeyHSD(modelo_estat)

# 3. Média de cada curso para identificar o de maior média
aggregate(nota_estatistica ~ curso, data = dados, FUN = mean)

# Questão 6
# 1. Carrega o pacote biotools
library(biotools)

# 2. Executa o teste M de Box
# data = subconjunto das variáveis numéricas contínuas (as 3 notas)
# grouping = a coluna categórica dos cursos
resultado_boxm <- boxM(data = dados[, c("nota_estatistica", "nota_matematica", "nota_programacao")], 
                       grouping = dados$curso)

# 3. Exibe o resultado do teste
print(resultado_boxm)
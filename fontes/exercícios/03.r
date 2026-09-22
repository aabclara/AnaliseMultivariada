dados <- data.frame(
  Metodo = c("A","A","A","A","A","B","B","B","B","B","C","C","C","C","C"),
  Nota = c(7.5, 8.0, NA, 6.5, 7.0, 8.5, 9.0, 8.7, NA, 9.2, 6.0, 6.5, 7.0, 6.8,
           NA),
  Horas = c(10, 12, 11, NA, 9, 14, 15, 13, 14, NA, 8, 9, 10, 9, 8),
  Frequencia = c(80, 85, 78, 82, NA, 90, 92, 88, 91, 93, 75, 78, NA, 77,
                 76)
)

View(dados)

# Questão 1 --------------------------------------------------------------------

# a) Identifique os valores faltantes no conjunto de dados.
  # Total de valores faltantes em todo o dataframe
sum(is.na(dados))

  # Quantidade de valores faltantes por coluna
colSums(is.na(dados))

  # Visualizar as posições exatas onde ocorrem os NAs (matriz lógica TRUE/FALSE)
is.na(dados)


# b) Substitua os valores faltantes pela média da variável correspondente.
  # 1. Imputação pela média para a coluna Nota
media_nota <- mean(dados$Nota, na.rm = TRUE)
dados$Nota <- ifelse(is.na(dados$Nota), media_nota, dados$Nota)

  # 2. Imputação pela média para a coluna Horas
media_horas <- mean(dados$Horas, na.rm = TRUE)
dados$Horas <- ifelse(is.na(dados$Horas), media_horas, dados$Horas)

  # 3. Imputação pela média para a coluna Frequencia
media_freq <- mean(dados$Frequencia, na.rm = TRUE)
dados$Frequencia <- ifelse(is.na(dados$Frequencia), media_freq, dados$Frequencia)

  # 4. Conferir o dataframe tratado e sem NAs
print(dados)
sum(is.na(dados))  # Deve retornar 0



# Questão 2 --------------------------------------------------------------------

# a) Calcule a média das variáveis Nota, Horas e Frequência
  # Média individual de cada variável
mean(dados$Nota)
mean(dados$Horas)
mean(dados$Frequencia)

  # ou: colMeans(dados[, c("Nota", "Horas", "Frequencia")])

# b) Calcule a variância e a covariância entre Nota e Horas
  # 1. Variância individual de Nota e de Horas
var(dados$Nota)
var(dados$Horas)

  # 2. Covariância entre Nota e Horas
cov(dados$Nota, dados$Horas)
  # ou cov(dados[, c("Nota", "Horas")])


# Questão 3 --------------------------------------------------------------------

# a) Calcule o coeficiente de correlação entre: - Nota e Horas; - Nota e Frequência
  # Correlação entre Nota e Horas
cor(dados$Nota, dados$Horas)

  # Correlação entre Nota e Frequência
cor(dados$Nota, dados$Frequencia)
  # ou cor(dados[, c("Nota", "Horas", "Frequencia")])

# b) Interprete os resultados (força e direção da relação)
  # Direção:
    # Sinal positivo: Uma aumenta a outra aumenta (Relação Direta)
    # Sinal negativo: Quando uma aumenta a outra diminuí (Relação Inversa)
  # Força: 
    # Próximo de 1: Relação linear forte
    # Próximo de 0,5 ou -0,5: Relação moderada
    # Próximo de 0: Ausência de relação linear

# Questão 4 --------------------------------------------------------------------

# a) Construa um boxplot da Nota por Método.
    # Boxplot da Nota separada por cada Método de ensino
bx <- boxplot(Nota ~ Metodo, data = dados, 
              main = "Boxplot de Nota por Método", 
              xlab = "Método", 
              ylab = "Nota", 
              col = "lightblue")

# b) Identifique possíveis outliers.
    # Extrai os valores numéricos de outliers detectados no gráfico
bx$out
    # São observações que ultrapassam as hastes (linhas que se estendem da caixa) e aparecem plotadas 
    # como círculos/pontos isolados externos.


# Questão 5 --------------------------------------------------------------------

# a) Aplique o teste de normalidade (Shapiro-Wilk) para a variável Nota.
shapiro.test(dados$Nota)
# p-value > 0,05: Distribuição normal
# p-value <= 0,05: Não segue distribuição normal

# b) Repita o teste para cada grupo (Método).
# Maneira mais rápida e elegante em uma linha
tapply(dados$Nota, dados$Metodo, shapiro.test)

shapiro.test(dados$Nota[dados$Metodo == "A"])
shapiro.test(dados$Nota[dados$Metodo == "B"])
shapiro.test(dados$Nota[dados$Metodo == "C"])
# Inspecione a linha do p-value para cada um dos três métodos ($A$, $B$ e $C$). 
# Para cada grupo com $p > 0{,}05$, conclui-se que os dados daquele método seguem distribuição normal. 


# Questão 6 --------------------------------------------------------------------

# a) Verifique se existe diferença entre as médias das notas dos três métodos.
# 1. Ajuste do modelo ANOVA
modelo_metodo <- aov(Nota ~ Metodo, data = dados)

# 2. Tabela da ANOVA
summary(modelo_metodo)

    # H_0: As médias de notas dos três métodos são estatisticamente iguais
    # Se p-value <= 0,05: Rejeita-se H_0 (existe diferença significativa entre as médias)
    # Se p-value > 0,05: Aceita H_0 (não existe diferença significativa entre as médias)

# b) Agora, aplique o teste de Tukey para comparações múltiplas e identifique quais pares de métodos
# diferenciem entre si.
# Teste de Tukey post-hoc
TukeyHSD(modelo_metodo)

# Médias de cada método para auxiliar a conclusão
aggregate(Nota ~ Metodo, data = dados, FUN = mean)

    # Na tabela do TukeyHSD, analise a coluna p adj para os pares:
        # Os pares que apresentarem p adj < 0,05 são os métodos que diferem significativamente entre si.
        # Pares com p adj >= 0,05 apresentam desempenhos estatisticamente equivalentes.

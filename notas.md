# Vetores
    * Criação: 
        ```
        v1 <- c(1,2,3,4,5)
        ```

# Dataframes
    * Criação:
        ````
        dados <- data.frame(curso, horas_estudo, notas_estatistica, notas_matematica, notas_programacao)
        ```
    * Acesso:
            * df$nota
            * df[linhas, colunas]
            * df["nota"] _(mantém o formato de dataframe)_
            * df[, 2] _(posição da coluna)_
        
    ### Aggregate
            ```
                aggregate(formula, data = meu_dataframe, FUN = funcao, na.rm = TRUE)
            ```
            * Formula (Y ~ X), onde Y é a variável calculada (ex.: média) e X é a variável de agrupamento (ex.: curso)
            * . indica todas as outras colunas
            * FUN é a função a ser aplicada (mean, sd, var, sum, etc.)
            * na.rm = TRUE remove valores NA

    * Exemplo:
            ```
            dados <- data.frame(
                    horas_estudo = c(15,12,14,10,13,16,14,11,15,13,
                                    10,9,12,11,10,13,12,9,11,10,
                                    8,7,9,6,8,7,9,8,6,7),
                    nota_programacao = c(70,68,72,65,69,74,73,67,71,70,
                                        85,82,88,84,86,90,87,83,89,85,
                                        55,52,58,50,54,53,57,56,51,52)
            )
    * Subsets:
        ```
            eng <- subset(dados, curso == "Engenharia")
            sis <- subset(dados, curso == "Sistemas")
        ```

# Matriz de Covariância
    A matriz de covariância organiza a dispersão interna de cada variável 
    e a relação conjunta entre os pares de variáveis em duas regiões bem definidas.
        * Diagonal Principal: Representa a variância (a covariância de uma variável com ela mesma)
        * Fora da Diagonal: Mostra a relação entre pares distintos de variáveis. 
            * Interpretação:
                * Valor positivo: quando uma variável aumenta, a outra tende a aumentar.  
                * Valor negativo: quando uma variável aumenta, a outra tende a diminuir.  
                Próximo de zero: ausência de relação linear.
        ```
        matriz_cov <- cov(dados[, c("horas_estudo", "nota_estatistica", "nota_matematica")])
        cov(dados[, c("horas_estudo", "nota_estatistica")], use = "complete.obs") # para evitar valores perdidos
        ```

# Matriz de Correlação
    Mede o grau e o sentido da associação linear ou ordinal entre variáveis de forma padronizada, variando sempre entre -1 e 1.
        * Pearson (method = "pearson", padrão): indicado para variáveis contínuas e relações lineares.
        * Spearman (method = "spearman"): indicado para variáveis ordinais (postos/ordens) ou quando a relação não for estritamente linear.  

    * Interpretação:
        * Diagonal principal sempre igual a 1.
        * Simetria:  A parte de cima e a de baixo do 1 são idênticas
        * Fora da Diagonal Principal:
            * r próximo de +1: Correlação positiva forte (aumentam iguais)
            * r próximo de -1: Correlação negativa forte (uma aumenta enquanto a outra diminui)
            * r próximo de 0: Correlação fraca ou nula (sem relação linear)

        ```
        matriz_cor <- cor(dados[, c("nota_estatistica", "nota_matematica", "nota_programacao")])
        print(matriz_cor)
        ```

# Teste de Normalidade (Shapiro-Wilk)
    * O que é: Verifica se uma variável contínua segue distribuição normal.

    * Interpretação:
        * H0: A variável segue distribuição normal
            * Se p > 0.05 -> É normal (não rejeita H0)  
            * Se p <= 0.05 -> Não é normal (rejeita H0)
    ```
    shapiro.test(vetor)
    shapiro.test(dados$nota_estatistica)
    ```
# T-test (Comparação de Médias)
    * H0: As médias entre as variáveis são iguais
        * p-value <= 0.05: Rejeita H0 (existe diferença significativa)
        * p-value > 0.05: Não rejeita H0 (não existe diferença significativa)
    
        ```
        t.test(var1, var2)
        ```

# Visualização Gráfica
    * Histograma:
        ```
        hist(dados$nota_estatistica)
        hist(dados$nota_matematica)
        hist(dados$nota_programacao)
        ```
    * Gráfico de Dispersão (Scatter Plot):
        * O que é: Gráfico que mostra a relação entre duas variáveis contínuas.
        ```
        plot(dados$nota_estatistica, dados$nota_matematica)
        plot(dados$horas_estudo, dados$nota_programacao)
        ```
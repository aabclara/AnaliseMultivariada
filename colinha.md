# 1. Ambiente & Atalhos Rápidos
    * Ctrl + Enter: Executa a linha ou seleção de código no console.  
    * Ctrl + Shift + R: Cria seções organizadas de código.  
    * Ctrl + L: Limpa o console.  
    * Ctrl + O: Abre um arquivo.  <-: Operador padrão de atribuição no R (ex.: a <- 3 + 5).  
    * #: Comentário (não executado).

    ### Vetores
        * Criação: 
        ```
        v1 <- c(1,2,3,4,5)
        ```

    ### Dataframes
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
            ```
            * Estrutura do Dataframe:
            ```
            str(dados)
            ```

# 2. Estatística Descritiva & Associação -----------------------------------------------
# Média, Mediana e Dispersão
    * O que é: Medidas de tendência central (onde os dados se concentram) e dispersão (o quanto variam).  
    * Na prova: "Calcule a média, mediana e desvio-padrão da variável/conjunto".

        ```
        mean(vetor)              # Média aritmética
        median(vetor)            # Mediana (ponto central)
        sd(vetor)                # Desvio-padrão (dispersão em torno da média)
        var(vetor)               # Variância (quadrado do desvio-padrão)
        cv <- sd(vetor) / mean(vetor) # Coeficiente de variação (CV = desvio-padrão / média)
        colMeans(dados_num)      # Média vetorial multivariada (média de cada coluna)
        aggregate(. ~ curso, data = dados, FUN = mean)  # Média por grupo _(ex.: média por curso)_
        ```

# Covariância e Correlação
    * O que é: Associação entre variáveis. 
        * Covariância indica a direção (+, -, 0); Correlação padroniza de $-1$ a $+1$.
        * Pearson: Variáveis contínuas e relação linear.
        * Spearman: Variáveis ordinais ou relações monótonas não-lineares.
        * Na prova: "Calcule a matriz de covariância" ou "Avalie o grau de correlação linear/ordinal".
            ```
            cov(dados_num)                      # Matriz de covariância
            cor(dados_num, method = "pearson")  # Pearson (linear contínuo)
            cor(dados_num, method = "spearman") # Spearman (ordem/postos)
            ```

# 3. Tratamento e Limpeza de Dados -----------------------------------------------
# Dados Perdidos (Missing Data)
    * Regra prática: Perdas < 10\% podem ser toleradas se forem aleatórias.
    * Ações: Excluir observações/variáveis ou imputar por média/mediana/regressão.
    * Na prova: "Verifique a existência de NA e aplique exclusão ou imputação".

        ```
        is.na(dados)                       # Retorna TRUE para cada dado ausente
        sum(is.na(dados))                  # Total de valores faltantes
        mean(is.na(dados))                 # Proporção percentual de NAs (checar se < 10%)

            # 1. Exclusão (remover NAs)
            dados_limpos <- na.omit(dados)

            # 2. Imputação pela Média
            media_val <- mean(dados, na.rm = TRUE)
            dados_imp_med <- ifelse(is.na(dados), media_val, dados)

            # 3. Imputação pela Mediana (melhor se houver assimetria/outliers)
            med_val <- median(dados, na.rm = TRUE)
            dados_imp_mediana <- ifelse(is.na(dados), med_val, dados)
            ```

# Detecção de Outliers (Observações Atípicas)
    * O que é: Valores notavelmente discrepantes que distorcem medidas sensíveis como a média.
    * Decisão: Manter se representar um segmento viável da população; eliminar se for um caso isolado e sem representatividade.
    * Na prova: "Identifique os outliers e justifique sua manutenção ou remoção."

        ```
        bx <- boxplot(dados, main = "Box-Plot de Outliers")
        bx$out                              # Lista os valores atípicos encontrados além das hastes
        dados_sem_out <- dados[!(dados %in% bx$out)] # Filtra removendo os outliers
        ```

# 4. Gráficos Fundamentais -----------------------------------------------
    * Histograma (hist): Frequência de ocorrência em blocos de uma única variável.
    * Ramo-e-Folhas (stem): Histograma que enumera os valores numéricos reais.
    * Dispersão (plot): Avaliação visual bivariada de pontos e correlação (+, -, nula).
    * Box-Plot (boxplot): Mediana, 1º/3º quartis, dispersão (50% centrais) e outliers externos.
    * Faces de Chernoff: Mapeia cada observação como uma face e cada coluna em características faciais.

        ```
        hist(dados, main = "Histograma", xlab = "Valores")
        stem(dados)                         # Gráfico de ramo-e-folhas no console
        plot(x, y, main = "Dispersão X vs Y") # Gráfico bivariado
        boxplot(y ~ grupo, data = df)       # Box-plot comparando grupos
        ```

# 5. Regra de Ouro dos Testes de Hipótese -----------------------------------------------
    H0: A definir
    * Se o p-value < 0,05 -> Rejeita H0 (Existe efeito/diferença)
    * Se p-value >= 0,05 -> Aceita/Não rejeita H0 (Não existe efeito/diferença)

# 6. Testes de Hipóteses e Modelagem -----------------------------------------------
    1. Normalidade de Shapiro-Wilk
        * Objetivo: Checar se uma variável contínua segue distribuição normal.
        * Hipóteses: $H_0$: distribuição é normal.
        * Interpretação: Se $p > 0,05 \implies$ É normal. Se $p \le 0,05 \implies$ Não é normal.  

            ```
            shapiro.test(vetor)
            ```

    2. Teste t de Student
        * Objetivo: Comparar as médias de dois grupos independentes.
        * Hipóteses: H0: u1 = u2 (médias iguais). 
        * Interpretação: Se $p \le 0,05 \implies$ Existe diferença significativa entre as médias. 

            ```
            t.test(grupoA, grupoB)              # Dois vetores
            t.test(nota ~ grupo, data = df)     # Por fórmula no dataframe
            ```
    3. ANOVA (Análise de Variância) & Teste de Tukey
        * Objetivo: Comparar médias de 3 ou mais grupos via razão $F$. Tukey detalha os pares diferentes.
        * Hipóteses: H0: u1 = u2 = u3 = ... = uk (médias iguais).
        * Interpretação: 
            * ANOVA: Se p <= 0,05 -> Existe diferença significativa entre as médias. 
            * Tukey: Se p-adj. Pares com p < 0,05 são os dados que se diferem entre si.
        
            ```
            # ANOVA
            modelo_aov <- aov(nota ~ metodo, data = df)
            summary(modelo_aov)

            # Tukey post-hoc (rodar se a ANOVA der significativa)
            TukeyHSD(modelo_aov)
            ```

    4. Regressão Linear Simples e Múltipla
        * Objetivo: Explicar ou predizer uma variável dependente Y por meio de uma ou mais variáveis explicativas Xn.
        * Interpretação: Olhar a coluna Pr(>|t|) (p < 0,05 -> Variável relevante) e adjusted R-squared (% de variância explicada).

            ```
            # Y contínuo em função de X1 + X2
            modelo_lm <- lm(nota ~ horas + faltas, data = df)
            summary(modelo_lm)
            ```
# 7. Identificação Rápida das Técnicas Multivariadas na Prova --------------------------------------------
    * Análise Fatorial: "Reduzir questionário de 25 perguntas...", "identificar fatores latentes"
        * Redução de variáveis correlacionadas a poucas dimensões subjacentes.

    * Regressão Múltipla: "Prever nota final a partir de horas, faltas e deslocamento..."
        * Modelação matemática de Y dependente via múltiplos preditores X. 
         
    * Análise Discriminante: "Classificar alunos entre evadidos e concluintes..."
        * Separação/classificação linear de indivíduos em grupos já pré-definidos.

    * MANOVA: "Comparar 3 metodologias avaliando prova teórica, projeto e motivação juntas..."
        * Compara grupos sobre múltiplas variáveis dependentes simultaneamente.
        
    * Cluster (Agrupamento): "Identificar perfis naturais de clientes/alunos sem rótulos prévios..."
        * Agrupamento não supervisionado baseado puramente na semelhança dos dados.


        
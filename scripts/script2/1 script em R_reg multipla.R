#REGRESSAO MULTIPLA

# Instalando pacotes necessários ------------------------------------------
if(!require(psych)) install.packages("psych") 
library(psych) 

if(!require(car)) install.packages("car") 
library(car)




# Carregando dados do arquivo exemplo1_estudo.xlsx ------------------------
#Os dados correspondem a uma amostra de dados obtidos em um estudo sobre o 
#comportamento de biomateriais.

dados <- exemplo1_estudo
colnames(dados) <- c("y", "x1", "x2", "x3", "x4")
View(dados)


# 1 - Verificando as Suposições: Linearidade e Normalidade ----------------

##1.1 - Linearidade: Matriz de correlacao ----
matcor <- cor(dados)
View(matcor)
pairs.panels(dados)

##1.2 - Teste de Normalidade para as variaveis independentes (Teste de Shapiro-Wilk) ----
#H0: Os dados sao normais
shapiro.test(dados$x1)   
shapiro.test(dados$x2) 
shapiro.test(dados$x3) 
shapiro.test(dados$x4) 

#__________________________________________________________________________
# 2 - Estimacao da equacao de regressao -----------------------------------
##2.1 - Estimando um modelo de regressao simples (y = a + b x4) ----
#Ecolhe-se aquela que possui a maior correlacao

modelo <- lm(dados, formula = dados$y ~ dados$x4)
modelo$coefficients

##2.2 - Avaliacao do modelo ----
#Teste F - H0: O modelo deve ser somente com a constante
summary(modelo) 
plot(modelo, which = c(1:3), pch = 20)

#Teste para Independencia dos residuos (Durbin-Watson)
#H0: Os residuos sao intependentes
durbinWatsonTest(modelo) 

#Teste de Normalidade para os residuos (Teste de Shapiro-Wilk)
#H0: Os residuos possuem distribuicao normal
shapiro.test(modelo$residuals)   


#__________________________________________________________________________
# 3 - Estimando o modelo por STEPWISE -------------------------------------
##3.1 - Algoritmo de selecao de variavel - Stepwise ----
#Algoritmo aplicado sobre todas as variaveis
modeloStep <- lm(dados, formula = dados$y ~ dados$x1 + dados$x2 + dados$x3 + dados$x4) 
modeloStep$coefficients

#Algoritmo Stepwise
s <- step(modeloStep)
s$coefficients #Este modelo possui y = a + x1 + x2 + x4

summary(modeloStep) #informar o Residual standard error

s2 <- step(modeloStep, scale = 2.446^2)
s2$coefficients #Este modelo possui y = a + x1 + x2


##2.2 - Avaliacao da precisao de previsao ----
###2.2.1 - Modelo s ----
#Teste F, teste T e R^2
summary(s)
summary(s2)
#Analise dos residuos
plot(s, which = c(1:3), pch = 20)
plot(s2, which = c(1:3), pch = 20)
#Teste para Independencia dos residuos (Durbin-Watson)
#H0: Os residuos sao intependentes
durbinWatsonTest(s) 

#Teste de Normalidade para os residuos (Teste de Shapiro-Wilk)
#H0: Os residuos possuem distribuicao normal
shapiro.test(s$residuals)  

#Teste de ausencia de Multicolinearidade (VIF > 10 existe)
vif(s)
vif(s2)
###2.2.2 - Modelo s2 ----
#Teste F, teste T e R^2
summary(s2)

#Analise dos residuos
plot(s2, which = c(1:3), pch = 20)

#Teste para Independencia dos residuos (Durbin-Watson)
#H0: Os residuos sao intependentes
durbinWatsonTest(s2) 

#Teste de Normalidade para os residuos (Teste de Shapiro-Wilk)
#H0: Os residuos possuem distribuicao normal
shapiro.test(s2$residuals)  

#Teste de ausencia de Multicolinearidade (VIF > 10 existe)
vif(s2)


# Comparação entre os modelos - Critério de Akaike ------------------------
#Quanto menor, melhor
AIC(modelo, s, s2)
s2$coefficients

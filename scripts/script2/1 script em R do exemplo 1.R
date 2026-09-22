#Metodo dos Minimos Quadrados Ordin?rios - MQO:  
#Carregando os dados
dados <- cartao_credito


# 1 - Identificando a variavel dependente ---------------------------------
correlacao <- cor(dados[2:5], )
print(correlacao, digits = 3)
View(correlacao)


# 2 - Estimando a equacao de regressao ------------------------------------
y <- dados$Numero.de.cartoes.de.credito
x <- dados$Tamanho.da.familia

#Calculo das medias
ymedia <- mean(y)
xmedia <- mean(x)

#Estimando os parametros alfa e beta
Yi <- y - ymedia
Xi <- x - xmedia

Soma1 <- sum(Yi*Xi)
Soma2 <- sum(Xi**2)

beta <- Soma1/Soma2
alfa <- ymedia - beta*xmedia

print(c(alfa, beta), digits = 4)

# 3 - Avaliando o modelo ------------------------------------------------------
#Calculando o y previsto 
yp <- c(alfa + beta%*%x)
cbind(y, yp)

#Erro quadrado da previsao 
erroP <- (yp - ymedia)^2

#Soma dos Erros quadrados da previsao
SQReg <- sum(erroP)
SQReg

#Erro quadrado da observa??o 
erroR <- (y - ymedia)^2

#Soma dos Erros quadrados total - STQ
STQ <- sum(erroR)
STQ

#Coeficiente de determinacao: R^2
r <- SQReg/STQ
r


# 4 - Usando o R para Estimar os parametros -------------------------------
#Estimacao da equacao de regressao simples
modelo <- lm(dados, formula = dados$Numero.de.cartoes.de.credito ~ dados$Tamanho.da.familia)
modelo$coefficients
print(modelo$coefficients, digits = 4)

print(c(alfa, beta), digits = 4)

## 4.1 - Avaliacao da precisao de previsao ----
#1-Analise do t-value, R^2 e F-statistic
#H0: alfa ou beta iguais a zero
summary(modelo)

#2-Analise dos residuos
#Analise Grafica
plot(modelo, which = c(1:3), pch = 20)

#Teste de Normalidade para os residuos (Teste de Shapiro-Wilk)
#p-value < 0.05 significa residuos NAO sao normais
shapiro.test(modelo$residuals)  

#Independencia dos residuos (teste Durbin-watson)
#p-value < 0.05 significa residuos sao autocorrelacionados
if(!require(car)) install.packages("car") 
library(car)
durbinWatsonTest(modelo)  

# 5 - Modelo sem o intercepto ---------------------------------------------
#Estimando coeficientes sem o intercepto
modelo2 <- lm(dados, formula = dados$Numero.de.cartoes.de.credito ~ - 1 + dados$Tamanho.da.familia)
modelo2$coefficients

#Avaliando o modelo:
summary(modelo2)

#Analisando os residuos
plot(modelo2, which = c(1:3), pch = 20)
shapiro.test(modelo2$residuals)  
durbinWatsonTest(modelo2)  




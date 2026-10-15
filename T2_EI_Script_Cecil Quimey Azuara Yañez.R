library(tidyverse)

# Importacion de los datos y limpieza de datos
penguins <- read.csv("C:/Users/quime/Desktop/SKUL/TERCER SEMESTRE/ESTADISTICA INFERENCIAL/Tarea2/penguins.csv")
datos <- penguins %>% drop_na(body_mass_g)


# mass_250
datos <- datos %>%
  mutate(mass_250 = 250 * round(body_mass_g / 250))

# Tabla PMF y CDF
tabla_1 <- datos %>%
  count(mass_250, name = "Frecuencia_n") %>%
  mutate(PMF_P_X_x = Frecuencia_n / sum(Frecuencia_n),
         CDF_F_x = cumsum(PMF_P_X_x)
  ) %>%
  rename(Soporte_x = mass_250)

print("Tabla distribucion (tabla 1)")
print(tabla_1)

soporte <- tabla_1$Soporte_x
pmf <- tabla_1$PMF_P_X_x
cdf <- tabla_1$CDF_F_x


# Comprobacion
suma_pmf <- sum(pmf)
cdf_f <- cdf[length(cdf)] # ultima posicion

cat("Suma de PMF:", suma_pmf, "\n")
cat("ultimo valor de CDF:", cdf_f, "\n")



# P(3500 <= X <= 4500)
p_3500_4500 <- sum(pmf[soporte >= 3500 & soporte <= 4500])
cat("P(3500 <= X <= 4500) =", p_3500_4500, "\n")


# E[x] y Var(x) de la PMF
E_X <- sum(soporte * pmf)
Var_X <- sum(((soporte - E_X)^2) * pmf)
cat("Valor Esperado E[X]:", E_X, "g\n")
cat("Varianza Var(X):", Var_X, "g^2\n")


# Gráfica PMF
plot(soporte, pmf, type = "h", lwd = 5, col = "purple",
     main = "PMF de mass_250",
     xlab = "Masa corporal discreta (g)", 
     ylab = "Probabilidad P(X = x)")
points(soporte, pmf, pch = 20, col = "red", cex = 1.5)








# parte 2
masa <- datos$body_mass_g

# P(3800 <= X <= 4200)
casos_favorables <- sum(masa >= 3800 & masa <= 4200)
casos_totales <- length(masa)
prob <- casos_favorables / casos_totales

cat("P(3800 <= X <= 4200) =", prob, "\n")


# Número total de elementos
n_pop <- length(masa)
media_pop <- sum(masa) / n_pop
var_pop <- sum((masa - media_pop)^2) / n_pop

cat("Media poblacional (mu):", media_pop, "g\n") # g es gramos
cat("Varianza poblacional (sigma^2):", var_pop, "g^2\n") # g^2 es gramos al cuadrado


# Normalizacion
min_m <- min(masa)
max_m <- max(masa)

masa_01 <- (masa - min_m) / (max_m - min_m)

limite_inferior_01 <- (3800 - min_m) / (max_m - min_m)
limite_superior_01 <- (4200 - min_m) / (max_m - min_m)

probabilidad_01 <- mean(masa_01 >= limite_inferior_01 & masa_01 <= limite_superior_01)
cat("P(lim_inf_01 <= X_01 <= lim_sup_01) =", probabilidad_01, "\n")

# Histograma
hist(
  masa_01,
  breaks = 12,
  probability = TRUE,
  main = "Histograma Normalizado de Masa Corporal [0, 1]",
  xlab = "Masa corporal (Normalizada)",
  ylab = "Densidad de probabilidad",
  col = "purple"
)





# Parte 3

# CDF (N = 342)
F_pob <- ecdf(masa)

# Muestra aleatoria
set.seed(100) # Mantener una semilla para que siempre de lo mismo
muestra_60 <- sample(masa, size = 60, replace = FALSE)
Fn <- ecdf(muestra_60)

# Graficar Parte 3
plot(F_pob, col = "purple", lwd = 4,
     main = "CDF (Poblacional) vs. ECDF (Muestrales)",
     xlab = "Masa corporal (g)", ylab = "Probabilidad Acumulada Fx(x) (CDF)")
plot(Fn, col = "red", lwd = 3, add = TRUE)

# Leyenda Parte 3
legend("bottomright",
       legend = c("Población (N = 342)", "Muestra sin reemplazo (n = 60)"),
       col = c("purple", "red"), lty = 1, lwd = 3, bty = "n")

# cuando x = 4000
cat("F_pob(4000) =", F_pob(4000),"\n")
cat("Fn(4000) =", Fn(4000),"\n")







# Parte 4

# Generar de 100 masas
set.seed(100) # Mantener una semilla

u <- runif(100)
muestra_generada <- quantile(masa, probs = u, type = 1, names = FALSE)

# Comprobación de pertenencia
pertenencia <- all(muestra_generada %in% masa)
cat("Todos los valores pertenecen a la población original? ", pertenencia,"\n")

# Comparar medias
cat("Media poblacional (g):", sum(masa) / length(masa), "g\n") # g son gramos
cat("Media muestra generada (g):", sum(muestra_generada) / length(muestra_generada), "g\n") # g son gramos

# Graficar Parte 4 en un nuevo lienzo para evitar empalmes
Fn_gen <- ecdf(muestra_generada)

plot(F_pob, col = "purple", lwd = 4,
     main = "CDF (Poblacional) vs. ECDF (Muestrales)",
     xlab = "Masa corporal (g)", ylab = "Probabilidad Acumulada Fx(x) (CDF)")
plot(Fn, col = "red", lwd = 3, add = TRUE)
plot(Fn_gen, col = "blue", lwd = 4, add = TRUE)

# Leyenda Parte 4
legend("bottomright",
       legend = c("Población (N = 342)", "Muestra sin reemplazo (n = 60)", "Muestra generada con ECDF (n = 100)"),
       col = c("purple", "red", "blue"), lty = 1, lwd = 4, bty = "n")


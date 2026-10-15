# Distribuciones Empíricas y Generación de Muestras en R

Este repositorio contiene la implementación y el análisis probabilístico correspondiente a la **Tarea 2 de Estadística Inferencial**. El proyecto trabaja con el dataset de pingüinos de Palmer (*Palmer Penguins*) para explorar la representación empírica de variables discretas y continuas, la normalización de datos, la función de distribución acumulada (CDF/ECDF) y la generación de muestras mediante la función cuantil empírica en el software **R**.

---

## Descripción del Proyecto

El objetivo general es analizar la distribución de la masa corporal (`body_mass_g`) de una población de $N = 342$ pingüinos, conectando conceptos teóricos con herramientas computacionales.

### Fases de Análisis:
1. **Modelación Discreta (PMF/CDF):** Discretización de la masa corporal en intervalos de 250 g (`mass_250`) para obtener la Función de Masa de Probabilidad y la Distribución Acumulada.
2. **Representación Continua y Normalización:** Transformación $Min-Max$ al rango $[0, 1]$ e interpretación de histogramas de densidad.
3. **CDF Poblacional vs. ECDF Muestral:** Comparación empírica entre la población ($N = 342$) y una muestra aleatoria sin reemplazo ($n = 60$).
4. **Muestreo por Inversión Empírica:** Generación de una muestra ($n = 100$) utilizando la función cuantil empírica y variables aleatorias uniformes.

---

## Módulos del Proyecto

### Parte 1: Variable Discreta (`mass_250`)
Se creó una versión discretizada de la masa corporal redondeando al múltiplo de 250 g más cercano:

$$\text{mass\_250} = 250 \times \text{round}\left(\frac{\text{body\_mass\_g}}{250}\right)$$

* **Probabilidad Intervalo $P(3500 \le X \le 4500)$:** $0.5468$ ($54.68\%$)
* **Valor Esperado $E[X]$:** $4208.33\text{ g}$
* **Varianza $Var(X)$:** $641356\text{ g}^2$

---

### Parte 2: Variable Continua e Histograma Normalizado
Se aplicó la escala $Min-Max$ para transformar los datos continuos al intervalo $[0, 1]$:

$$X_{[0,1]} = \frac{X - X_{\min}}{X_{\max} - X_{\min}}$$

* **Propiedad clave:** La transformación preserva la probabilidad de eventos equivalentes. 
* **Densidad:** En el histograma normalizado, la altura representa la densidad de probabilidad, por lo que el área total bajo las barras suma exactamente $1$.

---

### Parte 3: CDF Poblacional vs. ECDF Muestral
Comparación entre la Función de Distribución Acumulada poblacional $F(x)$ ($N = 342$) y la Función de Distribución Acumulada Empírica $F_n(x)$ para una muestra aleatoria sin reemplazo ($n = 60$, con `set.seed(100)`).

* **Evaluación en $x = 4000\text{ g}$:**
  * $F_{\text{pob}}(4000) = 0.4971$ ($49.71\%$ de la población pesa $\le 4000\text{ g}$)
  * $F_{n}(4000) = 0.4500$ ($45.00\%$ de la muestra pesa $\le 4000\text{ g}$)

---

### Parte 4: Generación Muestral vía Cuantil Empírico
Generación de $n = 100$ observaciones a partir de probabilidades uniformes $U \sim \text{Unif}(0, 1)$ evaluadas en la función de cuantil empírico:

$$X_{\text{gen}} = Q_{\text{empírico}}(U)$$

* **Comprobación:** Todos los valores generados pertenecen a la población original, ya que equivale a un muestreo con reemplazo (bootstrap empírico).
* **Media poblacional:** $4201.754\text{ g}$
* **Media muestra generada:** $4193.000\text{ g}$

---

## Preguntas Reflexivas y Respuestas

* **¿Por qué el valor esperado obtenido desde la PMF coincide con la media muestral de `mass_250`?**  
  Coinciden porque conceptualmente realizan la misma operación: ponderar cada valor discreto por su frecuencia relativa en el conjunto de datos.

* **¿Por qué la normalización Min-Max conserva la probabilidad y por qué el área representa probabilidad?**  
  La transformación conserva la densidad relativa y el orden de las observaciones. Dado que la densidad se define como $\text{Densidad} = \frac{\text{Proporción}}{\text{Ancho de Base}}$, al calcular el área ($\text{Base} \times \text{Densidad}$) se obtiene la proporción/probabilidad del intervalo.

* **¿Por qué $F_{\text{pob}}(4000)$ y $F_n(4000)$ no coinciden exactamente?**  
  Debido a la variabilidad muestral introducida por el proceso aleatorio de selección. Con muestras más grandes, $F_n(x)$ converge uniformemente a $F(x)$ por el Teorema de Glivenko-Cantelli.

* **¿Qué significa generar una muestra desde la ECDF y por qué no produce información nueva?**  
  Equivale a realizar un muestreo con reemplazo del dataset original. No genera información nueva sobre la población general porque se restringe a reordenar o seleccionar valores previamente observados.

---

## Archivos en el Repositorio

* `T2_EI_Script_Cecil Quimey Azuara Yañez.R`: Código en R utilizando `tidyverse` y funciones base de gráficos.
* `T2_EI_Doc_Cecil Quimey Azuara Yañez.pdf`: Documento académico con los resultados, tablas de distribución, histogramas y gráficos CDF/ECDF superpuestos.

---

## Requisitos e Instalación

Para ejecutar la simulación y análisis en R, asegúrate de contar con la biblioteca `tidyverse`:

```r
# Instalar dependencias si es necesario
install.packages("tidyverse")

# Ejecutar el script
source("T2_EI_Script_Cecil Quimey Azuara Yañez.R")
```
---

## Autor y Créditos

**Cecil Quimey Azuara Yáñez**

- **Carrera:** Licenciatura en Ingeniería de Datos e Inteligencia Artificial (LIDIA).
- **Institución:** Universidad de Guanajuato – División de Ingenierías (Campus Irapuato - Salamanca).
- **Asignatura:** Estadística Inferencial.

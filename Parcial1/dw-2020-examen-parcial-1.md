dw-2020-parcial-1
================
Tepi
9/3/2020

# Examen parcial

Indicaciones generales:

  - Usted tiene el período de la clase para resolver el examen parcial.

  - La entrega del parcial, al igual que las tareas, es por medio de su
    cuenta de github, pegando el link en el portal de MiU.

  - Pueden hacer uso del material del curso e internet (stackoverflow,
    etc.). Sin embargo, si encontramos algún indicio de copia, se
    anulará el exámen para los estudiantes involucrados. Por lo tanto,
    aconsejamos no compartir las agregaciones que generen.

## Sección I: Preguntas teóricas.

  - Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
    deberá responder 5. Las 5 a responder estarán determinadas por un
    muestreo aleatorio basado en su número de carné.

  - Ingrese su número de carné en `set.seed()` y corra el chunk de R
    para determinar cuáles preguntas debe responder.

<!-- end list -->

``` r
set.seed("20180497") 
v<- 1:10
preguntas <-sort(sample(v, size = 5, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 2, 4, 5, 6, 10"

### Listado de preguntas teóricas

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:
    
      - `str()`
      - `df[,c("a","b")]`
      - `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name`
      - `df[df$variable == "valor",]`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna?
    
      - **RESPUESTA**
      - BETWEEN/IN

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

4.  ¿Cuál es la diferencia entre utilizar `==` y `=` en R?
    
      - **RESPUESTA**
      - El `=` funciona como asignación, es como usar el `<-`, el `==`
        funciona como *comparador* y devuelve un TRUE o FALSE,
        dependiendo el resultado. Abajo el código explicando su
        diferencia

<!-- end list -->

``` r
x = 5
print(x)
```

    ## [1] 5

``` r
x1 <- 5
print(x1)
```

    ## [1] 5

``` r
x == 4
```

    ## [1] FALSE

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?
      - **RESPUESTA**
      - Se puede leer con la funcion `read_delim` y en el argumento
        `delim` ponemos *:*
      - ejemplo : **txt\_1 \<- read\_delim(“example.txt” , delim =
        “:”)**
6.  ¿Qué es un vector y en qué se diferencia en una lista en R?
      - **RESPUESTA**
      - Un vector es la estructura de datos más simple en R. Son un
        conjunto de datos del mismo tipo, se pueden combinar vectores,
        contar los valores, cambiar algun valor específico.

<!-- end list -->

``` r
c(1,2,3,4,5,6)
```

    ## [1] 1 2 3 4 5 6

    * Una lista puede contener más de un tipo de dato a la vez y puede ser multidimensional (algo que los vectores no pueden) y se crean usando la funcion *list()*

``` r
ejemplo <- list('Boris' , 'Rendon' , TRUE , 1,2,3 , c(34,542,42))
print(ejemplo)
```

    ## [[1]]
    ## [1] "Boris"
    ## 
    ## [[2]]
    ## [1] "Rendon"
    ## 
    ## [[3]]
    ## [1] TRUE
    ## 
    ## [[4]]
    ## [1] 1
    ## 
    ## [[5]]
    ## [1] 2
    ## 
    ## [[6]]
    ## [1] 3
    ## 
    ## [[7]]
    ## [1]  34 542  42

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

8.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?
    
      - El nuevo elemento
      - `NA`

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

10. Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?
    
      - SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
        \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
utilizando como banco las diez acá presentadas? (responder con código de
R.)

``` r
library(gtools)

N <- 10
n <- 5

values <- c(1:N)
combinaciones <- combinations(N, n, values)
nrow(combinaciones)
```

    ## [1] 252

``` r
#252 combinaciones posibles
```

## Sección II Preguntas prácticas.

  - Conteste las siguientes preguntas utilizando sus conocimientos de R.
    Adjunte el código que utilizó para llegar a sus conclusiones en un
    chunk del markdown.

A. De los clientes que están en más de un país,¿cuál cree que es el más
rentable y por qué?

``` r
library(readr)
library(tidyverse)
```

    ## -- Attaching packages ----------------------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v dplyr   1.0.0
    ## v tibble  3.0.3     v stringr 1.4.0
    ## v tidyr   1.1.1     v forcats 0.5.0
    ## v purrr   0.3.4

    ## -- Conflicts -------------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
parcial_anonimo <- read_rds("parcial_anonimo.rds")
View(parcial_anonimo)


parcial_anonimo %>% 
  summarise(clientes_unicos = n_distinct(Cliente))
```

    ##   clientes_unicos
    ## 1            2147

``` r
#2147 clientes unicos

parcial_anonimo %>% 
  summarise(paises_unicos = n_distinct(Pais))
```

    ##   paises_unicos
    ## 1             2

``` r
# dos paises



parcial_anonimo %>% 
  select(Cliente,Pais,Venta) %>% 
  group_by(Cliente) %>% 
  summarise(total_vendido = sum(parcial_anonimo$Venta) ,pais_distinto = n_distinct(Pais)  ) %>% 
    filter(pais_distinto >1 )
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## # A tibble: 7 x 3
    ##   Cliente  total_vendido pais_distinto
    ##   <chr>            <dbl>         <int>
    ## 1 044118d4      6286229.             2
    ## 2 a17a7558      6286229.             2
    ## 3 bf1e94e9      6286229.             2
    ## 4 c53868a0      6286229.             2
    ## 5 f2aab44e      6286229.             2
    ## 6 f676043b      6286229.             2
    ## 7 ff122c3f      6286229.             2

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

``` r
library(readr)
library(tidyverse)

View(parcial_anonimo)
```

### I. Preguntas teóricas

## A

``` r
###resuelva acá
```

## B

``` r
###resuelva acá
```

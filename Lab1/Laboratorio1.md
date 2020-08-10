Laboratorio1
================
Boris Rendon
7/8/2020

#### Librerias a importar

``` r
library(readr)
library(readxl)
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
library(tidytext)
library(tidyverse)
```

### Problema 1

#### Escenario

Ha sido contratado para trabajar en una consultoría a una embotelladora
nacional. La embotelladora se encarga de distribuir su producto a
distintos clientes, utilizando diferentes equipos de transporte y
pilotos.

Se le ha enviado un set de archivos de las entregas del año 2018.

\*Unificar todos los archivos en una tabla única.

``` r
allfiles <- list.files(pattern = 'xlsx')
print(allfiles)
```

    ##  [1] "01-2018.xlsx" "02-2018.xlsx" "03-2018.xlsx" "04-2018.xlsx" "05-2018.xlsx"
    ##  [6] "06-2018.xlsx" "07-2018.xlsx" "08-2018.xlsx" "09-2018.xlsx" "10-2018.xlsx"
    ## [11] "11-2018.xlsx"

``` r
rawdata <-lapply(allfiles,read_excel)
```

    ## New names:
    ## * `` -> ...10

  - Agregar la fecha a cada lista

<!-- end list -->

``` r
addColumn <- function (file, dates){
  n<-substr(deparse(dates), 2, 8)
  newColumn <- rep(n, nrow(file))
  newFile <- file %>% add_column(FECHA=newColumn)
  return (newFile)
}
finalfiles <- mapply(addColumn,rawdata,allfiles)
```

  - Limpieza de dato y creacion del csv

<!-- end list -->

``` r
final <- finalfiles %>% map_df(~finalfiles,.x)
final$TIPO<-NULL
final$...10<-NULL


write_excel_csv2(final,'InformacionUnificada.csv',delim = ',')
```

### Problema 2

  - Utilizando la funcion Lapply, encuentre la moda de cada vector de
    una lista de por lo menos 3 vectores

Creando una lista con 3 vectores, 2 numericos y uno de caracteres, todos
de tamano 15

``` r
lista <- list(sample(1:5,size = 15,replace = TRUE ), sample(letters,size=15, replace = TRUE), sample(1:5,size = 15,replace = TRUE))

lista
```

    ## [[1]]
    ##  [1] 1 5 2 4 4 5 1 5 3 2 4 1 1 3 5
    ## 
    ## [[2]]
    ##  [1] "o" "m" "z" "f" "k" "z" "i" "w" "i" "v" "j" "i" "z" "d" "x"
    ## 
    ## [[3]]
    ##  [1] 5 1 4 5 4 4 3 1 4 3 3 4 3 2 4

Creando funcion para encontrar la moda

``` r
getmode <- function(v){
  value = unique(v)
  value[which.max(tabulate(match(v,value)))]
  
  
  
}

# Llamar funcion para determinar la moda usando lapply

lapply(lista,getmode)
```

    ## [[1]]
    ## [1] 1
    ## 
    ## [[2]]
    ## [1] "z"
    ## 
    ## [[3]]
    ## [1] 4

### Problema 3

Descargar y leer el archivo de parque vehicular enero 2020.

``` r
SAT<-read_delim("INE_PARQUE_VEHICULAR_080220.txt", delim = '|')
```

    ## Warning: Missing column names filled in: 'X11' [11]

    ## Parsed with column specification:
    ## cols(
    ##   ANIO_ALZA = col_double(),
    ##   MES = col_character(),
    ##   NOMBRE_DEPARTAMENTO = col_character(),
    ##   NOMBRE_MUNICIPIO = col_character(),
    ##   MODELO_VEHICULO = col_character(),
    ##   LINEA_VEHICULO = col_character(),
    ##   TIPO_VEHICULO = col_character(),
    ##   USO_VEHICULO = col_character(),
    ##   MARCA_VEHICULO = col_character(),
    ##   CANTIDAD = col_double(),
    ##   X11 = col_character()
    ## )

    ## Warning: 2566664 parsing failures.
    ## row col   expected     actual                              file
    ##   1  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080220.txt'
    ##   2  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080220.txt'
    ##   3  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080220.txt'
    ##   4  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080220.txt'
    ##   5  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080220.txt'
    ## ... ... .......... .......... .................................
    ## See problems(...) for more details.

``` r
head(SAT)
```

    ## # A tibble: 6 x 11
    ##   ANIO_ALZA MES   NOMBRE_DEPARTAM~ NOMBRE_MUNICIPIO MODELO_VEHICULO
    ##       <dbl> <chr> <chr>            <chr>            <chr>          
    ## 1      2007 05    EL PROGRESO      "EL JICARO"      2007           
    ## 2      2007 05    ESCUINTLA        "SAN JOS\xc9"    2006           
    ## 3      2007 05    JUTIAPA          "MOYUTA"         2007           
    ## 4      2007 05    GUATEMALA        "FRAIJANES"      1997           
    ## 5      2007 05    QUETZALTENANGO   "QUETZALTENANGO" 2007           
    ## 6      2007 05    HUEHUETENANGO    "CUILCO"         1999           
    ## # ... with 6 more variables: LINEA_VEHICULO <chr>, TIPO_VEHICULO <chr>,
    ## #   USO_VEHICULO <chr>, MARCA_VEHICULO <chr>, CANTIDAD <dbl>, X11 <chr>

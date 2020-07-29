# strings

string  <- "esto es un string"

class(string)
length(string)
nchar(string)

# Double

number  <- 234
class(number)
typeof(number)
length(number)

number2  <- 1/8



# integer

integer < - 2L

class(integer)

# logical
logical < - FALSE

logical*1

as.logical(0)
as.logical(1)

# vectores 

numvector <- c(1,2,3,4)
length(numvector)

numvector2 <-  c(1,2,3,4,5,"a")
numvector2

vec1  <-  1:100
vec2  <-  sample(x = 1:10, size = 5, replace = FALSE)
vector("integer" , length = 10)

class(numvector)
class(numvector2)
c(numvector2, 5,6,7,8)



logvector  <-  c(F,F,T)
(logvector)


as.numeric(numvector2)


as.numeric(numvector)

# FACTOR

facator_1 <- c("lun" , "mar" , "mier", "jue", "vie", "sab" , "dom" , "lun")
facator_1 <- factor(facator_1)

#factores ordenados

factor2 <- c("lun" , "mar" , "mier", "jue", "vie", "sab" , "dom" , "lun")
factor2 <- ordered(factor2, levels = c("el orden que quiero"))


# listas

vector1 <- c(1,2,3,4,5)
vector2 <- c(F,F,T)
vector3 <- letters[1:6]

list_1 <- list(vector1,vector2,vector3)

names(list_1) <- c("A" ,"B","C")
list_1$C

# Matriz

mat <- matrix(1:10,nrow = 2,ncol = 5)
mat[2,] # indexing 

c(1,2,3,4,5)[c(1,3:5)] #slicing

a <- c(1,2,4,5,4,5,4,5)
cond <- a>=4
a[cond]
a[a>=4]


# dataframes

df <- data.frame(
  col1 = c("vector", "de" , "strings"),
  col2 = 1:6,
  col3 = letters[1:6],
  stringsAsFactors = FALSE
  
)



View(df)
str(df)

df$col1
df$col2[1:2]

names(df)
names(df) <- c("A" ,"B","C") # renombrar

head(df,3)

nrow(df)
ncol(df)

# cambiar el nombre de una fila

names(df)[2] <- c("columna2")
names(df)


# functions of base R (unfunc)

numvector3 <- as.numeric(numvector2)
is.na(vector3)

numvector3[!is.na(numvector3)]

mean(vector3, na.rm = TRUE)
mean(numvector3[!is.na(numvector3)])

df2 <- data.frame(
  col1 = c("vector", "de" , "strings"),
  col2 = 1:6,
  col3 = letters[1:6],
  stringsAsFactors = FALSE
  
)
df2[!is.na(df2$col2),]


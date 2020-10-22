#' ---
#' title: "Crash course in R: Session 1 - intro to R"
#' author: "Michelle Clements"
#' date: "`r Sys.Date()`"
#' output:
#'    html_document:
#'      keep_md: true
#' ---
#' 
#+ setup, include=FALSE
knitr::opts_chunk$set(echo = F, warning = T, message = T)
#'
#' # Part 1: R overview
#' 
#' ### 1.1 RStudio 
#' 
#' * The four windows in RStudio  
#' * Help & ?  
#' * Cheatsheets  
#' * Tools -> Global Options -> Save data to R workspace on exit -> Never  
#' 
#' ### 1.2 Running R 
#' 
#' * R can be used as a calculator in the console.  
#' * R code normally goes in in a savable script (open new: file -> new file -> R script or ctrl-shift-N).   
#' * Submitting code from R script using Run button or ctrl-Enter.   
#' * No highlighting submits current line.  
#' * Highlight to submit more than one line of code.  
#' * Ctrl-alt-b: submit from beginning to current position.   
#' * Ctrl-alt-e: submit from current position to end.  
#' * Looking at previous code using up button in console. 
#' * History tab shows you previous submitted code. 
#' * Restart R session and clear everything: ctrl-shift-F10.  
#' * Comments use `#` in front of text (highlight code and ctrl-shift-C to comment out a block).
#' 
#' 
#'  
#' # Part 2: Vectors
#' 
#' ### 2.1 Vector introduction  
#' 
#' * Vectors are bounded with `c()` (I say 'concatenate') and commas between values  
#' * It's good practice to put spaces after commas  
#' * Assign a vector using `<-` ('gets')  
#' * Assigned vectors appear in the Environment pane  
#' 
#' *Enter a single vector* 
#' 
#' `c(1, 2, 3, 4)`
c(1, 2, 3, 4)
 
#' *Assign previous vector to x*  
#' `x <- c(1, 2, 3, 4)`
x <- c(1, 2, 3, 4)

#' *Can also use `seq()`*   
#' `x <- seq(4)` 
x <- seq(4)

#' *Look at contents of x* 
#' 
#' `x`
x

#' ### 2.2 Basic operations on vectors   
#' * Basic operations apply to each component of a vector. 
#' * Components of vectors can be added etc. Makes most sense if vectors are the same length.    
#' * Warning: R will add anyway lengths are not equal (not recommended!)   
#'   
#' *Add one to each component*           
#' `x + 1`  
x + 1

#' *Divide each component by 2*  
#' `x / 2` 
x / 2


#' *Add the same position components together*       
#' `x + x` 
x + x

#' *Add one to odd numbers and 2 to even numbers (I don't recommend this!)*  
#' `x + c(1, 2)` 
x + c(1, 2)

#' *R will try even if vector lengths aren't multiples of each other (I definitely don't recommend this!)*  
#' `x + c(1, 2, 3)` 
x + c(1, 2, 3)

#' ### 2.3 Vector types
#' * logical: T/F. `c(TRUE, FALSE, F, F, T)`
#' * integer: `c(1, 2, 3, 4)`  
#' * double: `c(1.5, 2, 3)`  
#' * character: `c("dog", "cat", "horse")` 
#'    + factors are character vectors with order information. We'll come back to these  
#' * a vector can only contain one of the above  
#' * use class() to find out what your vector is  
#' * use length() to find out what length your vector is  
#' 
#' `class(x)`  
class(x)

#' `length(x)`  
length(x)


#' ### 2.4 Subsetting vectors

#' * use square brackets `[]` to get part of a vector
#' * I call `[]` 'where'  
#' 
#' *Using just numbers returns the value at the associated position*
#' 
#' `x[2]` 
x[2]

#' *Use `[]` and `:` to get sequential parts*
#' 
#' `x[2:3]` 
x[2:3]

#' *Use `[]` and `c()` to get non-sequential parts*
#' 
#' `x[c(2, 4)]` 
x[c(2, 4)]

#' *Use `==`, `|` (OR), `&` (AND), `%in%`, `>`, `<`,  to test if vector contains specific values*
#' 
#' `x == 4` 
x == 4

#' *Add in `[]` (where) to return the values*  
#' 
#' `x[x == 4]` 
x[x == 4]

#' *Use `|` for OR*  
#' `x[x == 4 | x == 3]` 
x[x == 4 | x == 3]

#' *Use `&` and inequalities*  
#' `x[x > 2 & x <= 4]` 
x[x > 2 & x <= 4]

#' *Use %in% for multiple values*  
#' `x[x %in% c(1, 3)]`
x[x %in% c(1, 3)]

#' *Use `!` to denote 'not'*  
#' `x[x != 4]`
x[x != 4]

#' `x[!x == 4]`
x[!x == 4]

#' ### 2.5 Summarising vectors

#' `mean(x)`
mean(x)

#' `sum(x)`
sum(x)

#' `min(x)`
min(x)

#' `quantile(x, 0.5)`
quantile(x, 0.5)

#' `sd(x)`
sd(x)

#' `summary(x)` 
summary(x)

#' `table(x)` 
table(x)

#' ### 2.6 Missing values  

#' * Missing values in R are denoted by `NA`  
#' * `NA` isn't an integer, double, character or T/F, it's just `NA`
#' * Can use `is.na()` or `!is.na()` to look for `NA` values   
#'   

#' *Create y as x with an NA added on*  
#' `y <- c(x, NA)`  
#' `y`  
y <- c(x, NA)
y

#' `y[is.na(y)]`
y[is.na(y)]


#' `y[!is.na(y)]`
y[!is.na(y)]

#' *Operations on numerics return a missing if there's one or more NA in the vector*  
#' 
#' 
#' `mean(y)`
mean(y)

#' *Use `na.rm = T` to ignore missing values*  
#' `mean(y, na.rm = T)`
mean(y, na.rm = T)

#' *`summary()` works with missing values*  
#' `summary(y)`
summary(y)

#' *`table()` needs to be told to include missing values*    
#' `table(y)`
table(y, useNA = "ifany")


#' # Part 3: A quick glimpse of functions  
#' ### 3.1 Functions introduction  
#' 
#' * Everything you do in R is a function  
#' * Everything that exists is an object  
#' * We've already applied functions to objects - e.g `mean(x)`: `mean()` is the function, and `x` is the object  
#' * Functions come from one of three sources:   
#'       + As part of base R (e.g. `mean()`)  
#'       + Written by someone else and loaded as a `library()`   
#'       + User generated   
#' * Functions have two main parts:    
#'       + formals: the arguments you're passing to the function    
#'       + body: what the function does    
#'       
#'         
#' *A simple function to add one to each element of a vector*  
#' `my_first_function <- function(vec){`    
#'   `vec + 1`    
#' `}`  
my_first_function <- function(vec){  
   vec + 1  
 }

#' *Apply function to x*  
#' `my_first_function(vec = x)`
my_first_function(vec = x)

#' *R will use the first argument if you don't specify this (I recommend using = after the first argument)*  
#' `my_first_function(x)`
my_first_function(x)


#' ### 3.2 For loops  
#' 
#' * For loops loop over each element of a vector  
#' * The apply functions and purr package are more efficient but for loops will work 
#' * Can be useful with if and else
#' 
#' 
#' 
#' `for(i in x){`  
#' `  if(i %% 2 == 0){`  
#' `    print("even")`  
#' `  }else{`  
#' `    print("odd")`  
#' `  }`  
#' `}` 

for(i in x){
  if(i %% 2 == 0){
    print("even")
  }else{
    print("odd")
  }
}


#' # Part 4: Datasets  
#' 
#' ### 4.1. Datasets introduction  
#' * Datasets are just collections of vectors   
#' * Datasets can be viewed in the Environment - click on the name to open them   
#' 
#' 
#' *Use an inbuilt dataset, iris*  
#' `iris <- iris`
iris <- iris
#' 
#' *look at column names with names()*  
#' `names(iris)`
names(iris)

#' *look at dimension with dim() - rows then columns*  
#' `dim(iris)`
dim(iris)

#' *summary of the whole dataset*  
#' `summary(iris)`
summary(iris)

#' ### 4.1. Subsetting datasets  
#' 
#' * `[]` can also be used to subset datasets  
#' * Need row then column, separated by comma  
#' * Leave blank for all  
#' * Can use column names as a vector   
#' 
#' *Second row, first column of iris*  
#' `iris[2, 1]`
iris[2, 1]

#' *Entire first row of iris*  
#' `iris[1, ]`
iris[1, ]

#' *All species values *  
#' `iris[, "Species"]`
iris[, "Species"]

#' *The first 5 species and Sepal.Width values *  
#' `iris[1:5, c("Species", "Sepal.Width")]`
iris[1:5, c("Species", "Sepal.Width")]

#' ### 4.2. Working with a single vector
#' 
#' * Use `$` as a shortcut to pull all values of a single column  
#' * Can put this into functions of vectors  
#' 
#' *table values of Species*   
#' `table(iris$Species) `
table(iris$Species)   

#' *summarise values of Sepal Width*  
#' `summary(iris$Sepal.Width)`
summary(iris$Sepal.Width)


#' *create a new column using `$` and `<-`*
#' `iris$large_sepal_width <- ifelse(iris$Sepal.Width > 3, 1, 0)`
iris$large_sepal_width <- ifelse(iris$Sepal.Width > 3, 1, 0)



#' # Part 5: Statistical models  
#' 
#' ### 5.1 Linear models
#' 
#' * Statistical models tend to follow a very similar pattern   
#'      + run the model to create a list (can look at this through Environment)  
#'      + use `summary(model)` to see a nice summary  
#'      + use any other functions you need to  
#' 
#' *Use `lm()` to create the model*  
#' `m1 <- lm(Sepal.Width ~ Species, data = iris)`  
m1 <- lm(Sepal.Width ~ Species, data = iris)  

#' *Use `summary()` to look at summary*  
#' `summary(m1)` 
summary(m1)  

#' *Can use `anova()` to test main effects*  
#' `anova(m1)`  
anova(m1)  

#' ### 5.1 Generalised linear models
#' 
#' *Use `glm()` for generalised linear model*  
#' `m2 <- glm(large_sepal_width ~ Species, data = iris, family = "binomial")`  
m2 <- glm(large_sepal_width ~ Species, data = iris, family = "binomial") 

#' *Use `summary()` to look at summary*  
#' `summary(m2)` 
summary(m2)  

#' *Can use `anova()` to test main effects*  
#' `anova(m2)`  
anova(m2)  

#' # Part 6: Further resources  
#' * The [R for Data Science](https://r4ds.had.co.nz/) book is great and available freely online  
#' * Useful parts linked to today's section are:   
#'      + Installing R, R Studio and packages: Section 1.4.1  
#'      + Workflow basics (<- and functions): Section 4  
#'      + Using scripts (ctrl-enter): Section 6  
#'      + Vectors: Section 20  
#'      + Functions: Section 19  
#'      + Loops and mapping: Section 21    

#'
#' # Part 7: Upcoming  
#' * Session 2: Manipulating datasets using dplyr  
#' * Session 3: Making graphs with ggplot2  
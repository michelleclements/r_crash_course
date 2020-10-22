---
title: "Crash course in R: Session 1 - intro to R"
author: "Michelle Clements"
date: "2020-10-22"
output:
   html_document:
     keep_md: true
---





# Part 1: R overview

### 1.1 RStudio 

* The four windows in RStudio  
* Help & ?  
* Cheatsheets  
* Tools -> Global Options -> Save data to R workspace on exit -> Never  

### 1.2 Running R 

* R can be used as a calculator in the console.  
* R code normally goes in in a savable script (open new: file -> new file -> R script or ctrl-shift-N).   
* Submitting code from R script using Run button or ctrl-Enter.   
* No highlighting submits current line.  
* Highlight to submit more than one line of code.  
* Ctrl-alt-b: submit from beginning to current position.   
* Ctrl-alt-e: submit from current position to end.  
* Looking at previous code using up button in console. 
* History tab shows you previous submitted code. 
* Restart R session and clear everything: ctrl-shift-F10.  
* Comments use `#` in front of text (highlight code and ctrl-shift-C to comment out a block).


 
# Part 2: Vectors

### 2.1 Vector introduction  

* Vectors are bounded with `c()` (I say 'concatenate') and commas between values  
* It's good practice to put spaces after commas  
* Assign a vector using `<-` ('gets')  
* Assigned vectors appear in the Environment pane  

*Enter a single vector* 

`c(1, 2, 3, 4)`


```
## [1] 1 2 3 4
```

*Assign previous vector to x*  
`x <- c(1, 2, 3, 4)`



*Can also use `seq()`*   
`x <- seq(4)` 



*Look at contents of x* 

`x`


```
## [1] 1 2 3 4
```

### 2.2 Basic operations on vectors   
* Basic operations apply to each component of a vector. 
* Components of vectors can be added etc. Makes most sense if vectors are the same length.    
* Warning: R will add anyway lengths are not equal (not recommended!)   
  
*Add one to each component*           
`x + 1`  


```
## [1] 2 3 4 5
```

*Divide each component by 2*  
`x / 2` 


```
## [1] 0.5 1.0 1.5 2.0
```

*Add the same position components together*       
`x + x` 


```
## [1] 2 4 6 8
```

*Add one to odd numbers and 2 to even numbers (I don't recommend this!)*  
`x + c(1, 2)` 


```
## [1] 2 4 4 6
```

*R will try even if vector lengths aren't multiples of each other (I definitely don't recommend this!)*  
`x + c(1, 2, 3)` 


```
## Warning in x + c(1, 2, 3): longer object length is not a multiple of shorter
## object length
```

```
## [1] 2 4 6 5
```

### 2.3 Vector types
* logical: T/F. `c(TRUE, FALSE, F, F, T)`
* integer: `c(1, 2, 3, 4)`  
* double: `c(1.5, 2, 3)`  
* character: `c("dog", "cat", "horse")` 
   + factors are character vectors with order information. We'll come back to these  
* a vector can only contain one of the above  
* use class() to find out what your vector is  
* use length() to find out what length your vector is  

`class(x)`  


```
## [1] "integer"
```

`length(x)`  


```
## [1] 4
```

### 2.4 Subsetting vectors
* use square brackets `[]` to get part of a vector
* I call `[]` 'where'  

*Using just numbers returns the value at the associated position*

`x[2]` 


```
## [1] 2
```

*Use `[]` and `:` to get sequential parts*

`x[2:3]` 


```
## [1] 2 3
```

*Use `[]` and `c()` to get non-sequential parts*

`x[c(2, 4)]` 


```
## [1] 2 4
```

*Use `==`, `|` (OR), `&` (AND), `%in%`, `>`, `<`,  to test if vector contains specific values*

`x == 4` 


```
## [1] FALSE FALSE FALSE  TRUE
```

*Add in `[]` (where) to return the values*  

`x[x == 4]` 


```
## [1] 4
```

*Use `|` for OR*  
`x[x == 4 | x == 3]` 


```
## [1] 3 4
```

*Use `&` and inequalities*  
`x[x > 2 & x <= 4]` 


```
## [1] 3 4
```

*Use %in% for multiple values*  
`x[x %in% c(1, 3)]`


```
## [1] 1 3
```

*Use `!` to denote 'not'*  
`x[x != 4]`


```
## [1] 1 2 3
```

`x[!x == 4]`


```
## [1] 1 2 3
```

### 2.5 Summarising vectors
`mean(x)`


```
## [1] 2.5
```

`sum(x)`


```
## [1] 10
```

`min(x)`


```
## [1] 1
```

`quantile(x, 0.5)`


```
## 50% 
## 2.5
```

`sd(x)`


```
## [1] 1.290994
```

`summary(x)` 


```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    1.75    2.50    2.50    3.25    4.00
```

`table(x)` 


```
## x
## 1 2 3 4 
## 1 1 1 1
```

### 2.6 Missing values  
* Missing values in R are denoted by `NA`  
* `NA` isn't an integer, double, character or T/F, it's just `NA`
* Can use `is.na()` or `!is.na()` to look for `NA` values   
  
*Create y as x with an NA added on*  
`y <- c(x, NA)`  
`y`  


```
## [1]  1  2  3  4 NA
```

`y[is.na(y)]`


```
## [1] NA
```

`y[!is.na(y)]`


```
## [1] 1 2 3 4
```

*Operations on numerics return a missing if there's one or more NA in the vector*  


`mean(y)`


```
## [1] NA
```

*Use `na.rm = T` to ignore missing values*  
`mean(y, na.rm = T)`


```
## [1] 2.5
```

*`summary()` works with missing values*  
`summary(y)`


```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1.00    1.75    2.50    2.50    3.25    4.00       1
```

*`table()` needs to be told to include missing values*    
`table(y)`


```
## y
##    1    2    3    4 <NA> 
##    1    1    1    1    1
```

# Part 3: A quick glimpse of functions  
### 3.1 Functions introduction  

* Everything you do in R is a function  
* Everything that exists is an object  
* We've already applied functions to objects - e.g `mean(x)`: `mean()` is the function, and `x` is the object  
* Functions come from one of three sources:   
      + As part of base R (e.g. `mean()`)  
      + Written by someone else and loaded as a `library()`   
      + User generated   
* Functions have two main parts:    
      + formals: the arguments you're passing to the function    
      + body: what the function does    
      
        
*A simple function to add one to each element of a vector*  
`my_first_function <- function(vec){`    
  `vec + 1`    
`}`  



*Apply function to x*  
`my_first_function(vec = x)`


```
## [1] 2 3 4 5
```

*R will use the first argument if you don't specify this (I recommend using = after the first argument)*  
`my_first_function(x)`


```
## [1] 2 3 4 5
```

### 3.2 For loops  

* For loops loop over each element of a vector  
* The apply functions and purr package are more efficient but for loops will work 
* Can be useful with if and else



`for(i in x){`  
`  if(i %% 2 == 0){`  
`    print("even")`  
`  }else{`  
`    print("odd")`  
`  }`  
`}` 


```
## [1] "odd"
## [1] "even"
## [1] "odd"
## [1] "even"
```

# Part 4: Datasets  

### 4.1. Datasets introduction  
* Datasets are just collections of vectors   
* Datasets can be viewed in the Environment - click on the name to open them   


*Use an inbuilt dataset, iris*  
`iris <- iris`




*look at column names with names()*  
`names(iris)`


```
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
```

*look at dimension with dim() - rows then columns*  
`dim(iris)`


```
## [1] 150   5
```

*summary of the whole dataset*  
`summary(iris)`


```
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    :50  
##  versicolor:50  
##  virginica :50  
##                 
##                 
## 
```

### 4.1. Subsetting datasets  

* `[]` can also be used to subset datasets  
* Need row then column, separated by comma  
* Leave blank for all  
* Can use column names as a vector   

*Second row, first column of iris*  
`iris[2, 1]`


```
## [1] 4.9
```

*Entire first row of iris*  
`iris[1, ]`


```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
```

*All species values*  
`iris[, "Species"]`


```
##   [1] setosa     setosa     setosa     setosa     setosa     setosa    
##   [7] setosa     setosa     setosa     setosa     setosa     setosa    
##  [13] setosa     setosa     setosa     setosa     setosa     setosa    
##  [19] setosa     setosa     setosa     setosa     setosa     setosa    
##  [25] setosa     setosa     setosa     setosa     setosa     setosa    
##  [31] setosa     setosa     setosa     setosa     setosa     setosa    
##  [37] setosa     setosa     setosa     setosa     setosa     setosa    
##  [43] setosa     setosa     setosa     setosa     setosa     setosa    
##  [49] setosa     setosa     versicolor versicolor versicolor versicolor
##  [55] versicolor versicolor versicolor versicolor versicolor versicolor
##  [61] versicolor versicolor versicolor versicolor versicolor versicolor
##  [67] versicolor versicolor versicolor versicolor versicolor versicolor
##  [73] versicolor versicolor versicolor versicolor versicolor versicolor
##  [79] versicolor versicolor versicolor versicolor versicolor versicolor
##  [85] versicolor versicolor versicolor versicolor versicolor versicolor
##  [91] versicolor versicolor versicolor versicolor versicolor versicolor
##  [97] versicolor versicolor versicolor versicolor virginica  virginica 
## [103] virginica  virginica  virginica  virginica  virginica  virginica 
## [109] virginica  virginica  virginica  virginica  virginica  virginica 
## [115] virginica  virginica  virginica  virginica  virginica  virginica 
## [121] virginica  virginica  virginica  virginica  virginica  virginica 
## [127] virginica  virginica  virginica  virginica  virginica  virginica 
## [133] virginica  virginica  virginica  virginica  virginica  virginica 
## [139] virginica  virginica  virginica  virginica  virginica  virginica 
## [145] virginica  virginica  virginica  virginica  virginica  virginica 
## Levels: setosa versicolor virginica
```

*The first 5 species and Sepal.Width values*  
`iris[1:5, c("Species", "Sepal.Width")]`


```
##   Species Sepal.Width
## 1  setosa         3.5
## 2  setosa         3.0
## 3  setosa         3.2
## 4  setosa         3.1
## 5  setosa         3.6
```

### 4.2. Working with a single vector

* Use `$` as a shortcut to pull all values of a single column  
* Can put this into functions of vectors  

*table values of Species*   
`table(iris$Species) `


```
## 
##     setosa versicolor  virginica 
##         50         50         50
```

*summarise values of Sepal Width*  
`summary(iris$Sepal.Width)`


```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   2.000   2.800   3.000   3.057   3.300   4.400
```

*create a new column using `$` and `<-`*
`iris$large_sepal_width <- ifelse(iris$Sepal.Width > 3, 1, 0)`



# Part 5: Statistical models  

### 5.1 Linear models

* Statistical models tend to follow a very similar pattern   
     + run the model to create a list (can look at this through Environment)  
     + use `summary(model)` to see a nice summary  
     + use any other functions you need to  

*Use `lm()` to create the model*  
`m1 <- lm(Sepal.Width ~ Species, data = iris)`  



*Use `summary()` to look at summary*  
`summary(m1)` 


```
## 
## Call:
## lm(formula = Sepal.Width ~ Species, data = iris)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -1.128 -0.228  0.026  0.226  0.972 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        3.42800    0.04804  71.359  < 2e-16 ***
## Speciesversicolor -0.65800    0.06794  -9.685  < 2e-16 ***
## Speciesvirginica  -0.45400    0.06794  -6.683 4.54e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3397 on 147 degrees of freedom
## Multiple R-squared:  0.4008,	Adjusted R-squared:  0.3926 
## F-statistic: 49.16 on 2 and 147 DF,  p-value: < 2.2e-16
```

*Can use `anova()` to test main effects*  
`anova(m1)`  


```
## Analysis of Variance Table
## 
## Response: Sepal.Width
##            Df Sum Sq Mean Sq F value    Pr(>F)    
## Species     2 11.345  5.6725   49.16 < 2.2e-16 ***
## Residuals 147 16.962  0.1154                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### 5.1 Generalised linear models

*Use `glm()` for generalised linear model*  
`m2 <- glm(large_sepal_width ~ Species, data = iris, family = "binomial")`  



*Use `summary()` to look at summary*  
`summary(m2)` 


```
## 
## Call:
## glm(formula = large_sepal_width ~ Species, family = "binomial", 
##     data = iris)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.9145  -0.9116  -0.5905   0.5905   1.9145  
## 
## Coefficients:
##                   Estimate Std. Error z value Pr(>|z|)    
## (Intercept)         1.6582     0.3858   4.299 1.72e-05 ***
## Speciesversicolor  -3.3165     0.5455  -6.079 1.21e-09 ***
## Speciesvirginica   -2.3215     0.4878  -4.759 1.94e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 206.23  on 149  degrees of freedom
## Residual deviance: 152.04  on 147  degrees of freedom
## AIC: 158.04
## 
## Number of Fisher Scoring iterations: 4
```

*Can use `anova()` to test main effects*  
`anova(m2)`  


```
## Analysis of Deviance Table
## 
## Model: binomial, link: logit
## 
## Response: large_sepal_width
## 
## Terms added sequentially (first to last)
## 
## 
##         Df Deviance Resid. Df Resid. Dev
## NULL                      149     206.23
## Species  2   54.197       147     152.04
```

# Part 6: Further resources  
* The [R for Data Science](https://r4ds.had.co.nz/) book is great and available freely online  
* Useful parts linked to today's section are:   
     + Installing R, R Studio and packages: Section 1.4.1  
     + Workflow basics (<- and functions): Section 4  
     + Using scripts (ctrl-enter): Section 6  
     + Vectors: Section 20  
     + Functions: Section 19  
     + Loops and mapping: Section 21    

# Part 7: Upcoming  
* Session 2: Manipulating datasets using dplyr  
* Session 3: Making graphs with ggplot2  

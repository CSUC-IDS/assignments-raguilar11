---
title: "R programming (r4ds Section III)"
author: "Ricardo Alexandro Aguilar"
date: "01/29/2018"
output: 
  html_document: 
    keep_md: yes
---




# Ch 18: Pipes

_Demonstrate the use of the regular pipe (`%>%`) and the "explosion" operator (`%$%`) in some example_


```r
table(iris %>% select(Species) %>% filter(Species == "setosa"))
iris %$% table(Species, Sepal.Length)
```


----

# Ch 19: Functions

### 19.2: When should you write a function?
Answer any 3
  
1. "True" is not a parameter because the function requires only one parameter since the na.rm and finite arguments in the range function are set to TRUE. The rescale01 function requires a vector of numeric values.   
NA would be the ouput for the missing value.  
  
2.

```r
# I wasn't sure what it meant by "mapped to", so I assumed it wants me to return those values

## Mapped to means that, you should replace all values like so
## -Inf -> 0
## Inf -> 1
## additionally, if (x == -Inf) Doesnt work for this function as x is a vector which contains multiple elements
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  if(x == -Inf)
    return(0)
  if(x == Inf)
    return(1)
  (x - rng[1]) / (rng[2] - rng[1])
}
```
  
5.

```r
## What is the question here?
x <- c(1, NA, NA)
y <- c(1, 2, NA, 0)
both_na <- function(x, y){
  sum(is.na(x)) + sum(is.na(y))
}
both_na(x, y)
```

```
## [1] 3
```

  
_Describe one time where you wish you had written a function, but didn't._
  
I wish I wrote a function while working on the Chem data (I would have avoided copying and pasting ggplot code). 

### 19.3: Functions are for humans and computers
Answer any 2

1. The first function checks if the first string starts with the second string. I would name it str_start. The second funtion removes the last element of a vector. I would name it rm_last_elem. The third function repeats the second vector until there are x amount of elements (equal to the length of the first vector). I would name it rep_vect_by_elem.

```r
f3 <- function(x, y) {
  rep(y, length.out = length(x))
}
f3(1:32,2:12)
```

```
##  [1]  2  3  4  5  6  7  8  9 10 11 12  2  3  4  5  6  7  8  9 10 11 12  2
## [24]  3  4  5  6  7  8  9 10 11
```

2.

```r
#int retrieve(int a, int i){
#  int x = a / pow(10, i - 1);
#  int digit = x % 10
#  return digit;
#}
```
  
I made this function for CSCI311. I can rename it to get_digit and rename its arguments to number and digit_place (number = 81324, 4 would be the 1st digit, 2 is the 2nd digit, etc.)
  
_What does "Functions are for humans and computers" mean to you?_
  
A function should be easy for a person to understand when looking at the code and when using it.

// What about for computers?

### 19.4 Conditional execution
Answer any 3
  
1. The if function does something when a condition is met while the ifelse function does something when the condition is true and false.
  

```r
# Example 1
x <- 2
y <- 0
if(x == 3)
  y <- x;
y
```

```
## [1] 0
```

```r
ifelse(x == 3, y <- x, y <- 1)
```

```
## [1] 1
```

```r
# Example 2
x <- 4
y <- 0
if(x > 3)
  y <- x;
y
```

```
## [1] 4
```

```r
ifelse(x > 3, y <- x, y <- 1)
```

```
## [1] 4
```

```r
# Example 3
x <- 4
y <- 0
if(x < 3)
  y <- x;
y
```

```
## [1] 0
```

```r
ifelse(x == 3, y <- x, y <- 1)
```

```
## [1] 1
```
  
2.

```r
greeting <- function(time = lubridate::hour(lubridate::now())){
  if(time < 12)
    "good morning"
  else if(time < 18)
    "good afternoon"
  else
    "good evening"
}
greeting()
```

```
## [1] "good morning"
```

  
3.

```r
fizzbuzz <- function(x){
  if(x%%3 == 0 & x%%5 == 0)
    "fizzbuzz"
  else if(x%%3 == 0)
    "fizz"
  else if(x%%5 == 0)
    "buzz"
  else
    x
}
fizzbuzz(10)
```

```
## [1] "buzz"
```

```r
fizzbuzz(15)
```

```
## [1] "fizzbuzz"
```

```r
fizzbuzz(9)
```

```
## [1] "fizz"
```

```r
fizzbuzz(7)
```

```
## [1] 7
```


### 19.5 Function arguments
Answer any 2
  
1.

```r
## If you want to write code that has place holder values, simply put eval = false in the ```{r} part of the code chunk
commas <- function(...) stringr::str_c(..., collapse = ", ")
commas(letters, collapse = "-")
```

It gives you an error because collapse is an argument for str_c not commmas.  

Not 100% on the verbage above, I think its because you declared the function with colapse given a default argument of ", " means that the compiler for stringr will not allow you to pass it a new argument, hence the error message.

3.  
The trim argument removes the given proportion of observations from each side of the vector. It would be useful when your data is skewed.  
  
### 19.6: Return values
_Is it mandatory that you `return()` a value from a function? If not, give on reasons for why you would want to do so. If so, explain what happens if you don't include the return._
  
It isn't mandatory, but it is really useful when you want to end a function under certain conditions before you reach the end. For example, if you catch an error in the input that would cause an error in the rest of the function. If you don't explicitly return something, (depending on how it was written) your function might not return the results or it will return the result of the last operation.  
  
### 19.7: Environment
_What's the problem with the example function at the beginning of this chapter?_  
The function uses y as a variable, but y is not defined. The function "knows" that x will be an input, but doesn't know where y is coming from. This causes it to look into your environment and might cause bugs if you have a variable y defined in your environment.
----

# 20: Vectors

###  20.3: Important types of atomic vector
Answer any 2
  
1. The functions are very similar and will pretty much get the same results except with inputs that are neither finite or infinite (NA's and NaN's). Since they are neither, both functions will return false, but the ! in !is.infinite(x) will change it to true.
  
2. The near function returns true if the two vectors are equal. The function is able to tolerate the manipulation of the vectors and say if they're close enough to being the same depending on the tolerance of comparison.
  
### 20.4: Using Atomic Vectors
Answer #4, and then 2 others. 
  

1. 
The function mean(is.na(x)) tells you the proportion of elements in x that are NA while sum(!is.finite(x)) gives the amount of elements in the vector that are not finite values.

4.

```r
## Please include what the question is
a <- function(x){
  x[length(x)]
}
a(1:12)
```

```
## [1] 12
```

```r
b <- function(x){
  x[1:length(x) %% 2 == 0]
}
b(1:12)
```

```
## [1]  2  4  6  8 10 12
```

```r
cc <- function(x){
  x[-length(x)]
}
cc(1:12)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11
```

```r
d <- function(x){
  x <- x[!is.na(x)]
  x[x %% 2 == 0]
}
test <- c(1:12, NA)
d(test)
```

```
## [1]  2  4  6  8 10 12
```
  
4. 

```r
x <- 1:12
x[14]
```

```
## [1] NA
```

```r
y <- c(abc = 1, def = 2, xyz = 5)
y["ddef"]
```

```
## <NA> 
##   NA
```
  
Subsetting with a positive integer that's bigger than the length of the vector returns NA. Similarly, subsetting with a name that doesn't exist also returns NA.

### 20.5: Recursive vectors (lists)
Answer either one
  
1. 
  
a) list(a, b, list(c, d), list(e, f)) = {a, b, {c, d}, {e,f}}  
b)list(list(list(list(list(list(a)))))) = {{{{{{a}}}}}}

// Run the code for a and re-evaluate your set notation.  'a' is a set (vector/list) of length one and so is b.  What you have above may technically be correct but I would argue that it would be more correct to have 'a' and 'b' within {}
  
### 20.7: Augmented vectors

_Describe at least two differences between a `data.frame` and a `tibble`_
  
Unlike data frames, tibbles limit printing to ten rows and the amount of columns that fit in the screen. Furthermore data frames use partial matching on column names while tibbles do not.
----

# Chapter 21: Iteration
//Don't forget chapter 21!
### 21.2: For Loops
Any one question

1.  

```r
#1.
output <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)) {  
  output[[i]] <- mean(mtcars[[i]])
}
output
```

```
##  [1]  20.090625   6.187500 230.721875 146.687500   3.596563   3.217250
##  [7]  17.848750   0.437500   0.406250   3.687500   2.812500
```

```r
#2.
#time_hour has two types ("POSIXct" and "POSIXt") so it gives me an error
#if i don't change it to something else
flights <- nycflights13::flights
flights$time_hour <- as.character(flights$time_hour)
output <- vector("character", ncol(flights))
for (i in 1:ncol(flights)) {  
  output[[i]] <- class(flights[[i]])
}
output
```

```
##  [1] "integer"   "integer"   "integer"   "integer"   "integer"  
##  [6] "numeric"   "integer"   "integer"   "numeric"   "character"
## [11] "integer"   "character" "character" "character" "numeric"  
## [16] "numeric"   "numeric"   "numeric"   "character"
```

```r
#3
output <- vector("double", ncol(iris))
for (i in seq_along(iris)) {  
  output[[i]] <- length(unique(iris[[i]]))
}
output
```

```
## [1] 35 23 43 22  3
```

```r
#4
mu <- c(-10,  0, 10, 100)
norms <- cbind("-10" = 1:10, "0" = 1:10, "10" = 1:10, "100" = 1:10)
for (i in 1:length(mu)) {
  norms[ ,i]<- rnorm(10, mean = mu[i])
}
norms
```

```
##              -10          0        10       100
##  [1,] -10.816432 -1.7500060  9.261131  99.12588
##  [2,] -11.469140 -0.9264333  9.659074 101.08868
##  [3,] -10.219580  0.9713595  8.915915 100.77214
##  [4,]  -8.996649 -1.2350755  9.909277 100.83279
##  [5,] -11.435374  0.4921697  8.361932 100.68485
##  [6,]  -8.239430  1.5259275  9.453678  99.07818
##  [7,]  -9.755496  0.4100462 10.168835 101.39065
##  [8,]  -8.598891  2.2593169 11.035527 100.76080
##  [9,]  -9.833644 -0.7228907 12.113562 100.12574
## [10,] -10.450003  0.8600983  9.290330  99.15035
```


### 21.3: For Loop Variations
Problem #1

```r
files <- as.list(files)
for (i in 1:length(files)) {
  assign(files[i], read.csv(files[i]))
}
dplyr::bind_rows(files)
```

### 21.4: For loops vs functionals
Problem #2


```r
col_summary <- function(df, fun) {
  for (nm in df) {
    if(is.numeric(df$nm) == FALSE)
      return()
  }
  out <- vector("double", length(df))
  for (i in seq_along(df)) {
    out[i] <- fun(df[[i]])
  }
  out
}
```


### 21.5: the map function
Any 2 problems
  
1.

```r
#1
map_dbl(mtcars, mean)
```

```
##        mpg        cyl       disp         hp       drat         wt 
##  20.090625   6.187500 230.721875 146.687500   3.596563   3.217250 
##       qsec         vs         am       gear       carb 
##  17.848750   0.437500   0.406250   3.687500   2.812500
```

```r
#2
map_chr(nycflights13::flights, typeof)
```

```
##           year          month            day       dep_time sched_dep_time 
##      "integer"      "integer"      "integer"      "integer"      "integer" 
##      dep_delay       arr_time sched_arr_time      arr_delay        carrier 
##       "double"      "integer"      "integer"       "double"    "character" 
##         flight        tailnum         origin           dest       air_time 
##      "integer"    "character"    "character"    "character"       "double" 
##       distance           hour         minute      time_hour 
##       "double"       "double"       "double"       "double"
```

```r
#3
myfun <- function(x) length(unique(x))
map(iris, myfun)
```

```
## $Sepal.Length
## [1] 35
## 
## $Sepal.Width
## [1] 23
## 
## $Petal.Length
## [1] 43
## 
## $Petal.Width
## [1] 22
## 
## $Species
## [1] 3
```

```r
#4
mu <- c(-10, 0, 10, 100)
map(mu, rnorm, n = 10)
```

```
## [[1]]
##  [1]  -8.998024 -11.875433  -9.510830  -8.763757  -9.554933  -8.554079
##  [7]  -8.941304  -9.836004 -10.493521 -10.418813
## 
## [[2]]
##  [1]  1.6904028  1.1347188  0.8972128 -0.2910479 -1.5086161 -0.2944618
##  [7]  0.2100169 -0.6502670 -1.8973574  0.7590664
## 
## [[3]]
##  [1] 10.453845  8.995673  9.939621 10.906163 10.299010  9.155798 11.280882
##  [8]  9.056416  9.584447 10.474228
## 
## [[4]]
##  [1] 101.61649  99.05537 101.19342  99.64898 100.03716  99.77095  97.75849
##  [8] 101.16997  99.18833  99.79433
```
  
4. map(-2:2, rnorm, n = 5) gives a list, that has five elements, for each element in in vector. Giving the output as a list lets it use vectors without getting an error with the vector. map_dbl(mu, rnorm, n = 10) gives an error because the result is no longer an atomic vector.
----

End here. The rest of 21 is for your info only


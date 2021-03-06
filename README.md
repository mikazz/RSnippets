# RSnippets
Collection of R code snippets


# Basics


## If
```r
if (i > 3){
    print("Yes")
} 
else {
    print("No")
}
```


## While
```r
while (i < 5){
    print(i)
    i <- i + 1
}
```


## For
```r
for (i in 1:4){
    j <- i + 10
    print(j)
}
```


## Hello World from function
```r
sayHello <- function(){
    print('Hello World')
}
sayHello()
```


# Program inside


## Help
```r
# Show help about function plot()
?plot

# Show use case example of plot()
example(plot)

# Show function names with test in its name
apropos("test")

# Show function names with 'normality test' text in description
help.search("normality test")
```


## Manage Objects
```r
# Show imported names
# Unless you specify check.names=FALSE, R will convert column names that are not valid variable names 
# (e.g. contain spaces or special characters or start with numbers) into valid variable names, e.g. 
# by replacing spaces with dots.
names(data)

# List all the created objects in the environment
ls()

# Delete created object
rm(z)
```


## Save Work
```r
# Save individual variables
save()

# Save file
save(yourname, file = "yourname.rda")

# Retrieve saved data
load("yourname.rda")

# Save the entire environment
save.image()

# Save history of typed commands
savehistory(file = "Chapter3.Rhistory")
```


## Working Directory
```r
# Check working directory (by default should be your user folder)
getwd()

# Set working directory
setwd()
```


## Files
```r
# Construct the universal path to a file from components in a platform-independent way
file.path("F:", "git", "main", "data", "README.md" )
# "F:/git/main/data/README.md"

# Lists files in a directory
list.files()

# Lists subdirectories of a directory
list.dirs()

# Tests whether a specific file exists in a location.
file.exists()

# Creates a file
file.create()

# Deletes files (and directories in Unix operating systems)
file.remove()

# Returns a name for a temporary file. If you create a file for example, with file.create() or write.
# table() using this returned name R creates a file in a temporary folder
tempfile()

# Returns the file path of a temporary folder on your file system
tempdir()
```


## Get file names
```r
filenames <- list.files("C:/path_to_my_data")  
first_letters <- substr(filenames, 1, 1)  
table(first_letters)
```


# Strings


## Concatenate multiple text elements. By default, paste() puts a space between the different elements
```r
paste("Hello", "world!")
```


## Extract or replace substrings in a character vector.
```r
substr(x, start=n1, stop=n2)
x <- "abcdef"
substr(x, 2, 4) is "bcd"
substr(x, 2, 4) <- "22222" is "a222ef"
```


## Search for pattern in x. If fixed =FALSE then pattern is a regular expression. If fixed=TRUE then pattern is a text string. Returns matching indices. 
    # grep(pattern, x , ignore.case=FALSE, fixed=FALSE)     
    grep("A", c("b","A","c"), fixed=TRUE) # returns 2


## Find pattern in x and replace with replacement text.
    # If fixed=FALSE then pattern is a regular expression.
    sub(pattern, replacement, x, ignore.case =FALSE, fixed=FALSE) 
    
    # If fixed = T then pattern is a text string.
    sub("\\s",".","Hello There") returns "Hello.There"


## Split the elements of character vector x at split.
    # strsplit(x, split)
    strsplit("abc", "") # returns 3 element vector "a","b","c"


## Concatenate strings after using sep string to seperate them.
    # paste(..., sep="")
    paste("x",1:3,sep="") # returns c("x1","x2" "x3")
    paste("x",1:3,sep="M") # returns c("xM1","xM2" "xM3")
    paste("Today is", date())


## Format String
    # Uppercase
    toupper(x)

    # Lowercase
    tolower(x)


## User input
    h <- "Hello"
    yourname <- readline("What is your name? ")
    # What is your name? Andrie
    
    paste(h, yourname)
    # [1] "Hello Andrie"

 
# Regex (Match exact strings)

    x <- c("apple", "banana", "pear")
    str_extract(x, "an")
    #> [1] NA   "an" NA


# Vectors


## Assign values to variables
    MyVar <- value
    # Or
    MyVar = value
    # Or
    value -> MyVar
    
    x <- 1:5 # 1 2 3 4 5


## Add the value 2 to each element in the vector x:
    x <- 1:5
    x + 2 # 3 4 5 6 7


## Join two vectors
    x + 6:10 # 7 9 11 13 15


## Join elements into a vector
    vector_var <- c(2, 4, 6) #[1] 2 4 6


## Create vector of integer sequence
    vector_var <- 2:6 
    #[1] 2 3 4 5 6


## Create vector of complex sequence
    vector_var <- seq(2, 3, by=0.5) # 2.0 2.5 3.0 


## Repeat a vector
    vector_var <- rep(1:2, times=3) # 1 2 1 2 1 2


## Repeat elements
    vector_var <- rep(1:2, each=3) # 1 1 1 2 2 2


## Vector indexing / Selecting Vector Elements By Position
    # The fourth element
    x[4]
    
    # All but the fourth
    x[-4]
    
    # Elements two to four
    x[2:4]
    
    # All elements except two to four
    x[-(2:4)]
    
    # First 5 elements
    x[1:5]
    
    # Last 5 elements
    x[(length(x)-5):length(x)]
    

## Vector indexing / Selecting Vector Elements By Value
    # How many elements?
    length(x)
    
    # Elements one and five
    x[c(1, 5)]
    
    # Elements which are equal to 10
    x[x == 10]
    
    # All elements less than zero
    x[x < 0]
    
    # Bigger than or less than values 
    x[ x< -2 | x > 2]
    
    # Elements in the set 1, 2, 5
    x[x %in%c(1, 2, 5)]
    
    # Which indices are largest 
    which(x == max(x))
    

## Vector indexing / Selecting Vector Elements By  Named Vectors
    x['apple'] Element with name 'apple'


# List


## Create and Acces List elements
    person = list(name=c("Steve","Harry"), surname="Toreno", age=25, married=T)

    person$name # "Steve" "Harry"
    person$surname # "Toreno"
    person$age # 25


## Iterate over list
    for(i in dataList){print(i)}


# Matrix


## Create Matrix
    matrix(0,2,4)


## Add names to columns
    counts <- matrix(c(3, 2, 4, 6, 5, 1, 8, 6, 1), ncol = 3)
    colnames(counts) <- c("sparrow", "dove", "crow")


# Array (3 dimensions)


# Basic Arithmetic Operators

    # y added to x
    x+y
    2 + 3 = 5
    
    # y subtracted from x
    x–y
    8 – 2 = 6
    
    # x multiplied by y
    x*y
    3 * 2 = 6

    # x divided by y
    x/y
    10 / 5 = 2
    
    # x raised to the power y
    x^y
    2 ^ 5 = 32
    
    # remainder of x divided by y (x mod y)
    x%%y
    7 %% 3 = 1

    # x divided by y but rounded down (integer divide)
    x%/%y
    7 %/% 3 = 2


# Functions


## Function with basic argument
    # Square function
    square <- function(x){
        squared <- x*x
        return(squared)
    }
    
    square(4) # 16


## Apply multiple functions to a data frame
```r
multi.fun <- function(x) {
      c(min = min(x), mean = mean(x), max = max(x))
}

# Apply function on builtin dataframe cars
sapply(cars, multi.fun)
```


## Function with multiple functions as arguments
```r
multi.sapply <- function(...) {
    # extract function arguments as list
    arglist <- match.call(expand.dots = FALSE)$... 

    # deparses the expressions defining
    # arguments as given in multi.apply call
    var.names <- sapply(arglist, deparse)

    # if any argument was given name then its name is nonempty
    # if no argument names were given then has.name is NULL
    has.name <- (names(arglist) != "")

    # for all arguments that had name substitue deparsed
    # expression by given name
    var.names[has.name] <- names(arglist)[has.name]

    # now evaluate the expressions given in arguments
    # go two generations back as we apply eval.parent
    # witinh lapply function
    arglist <- lapply(arglist, eval.parent, n = 2)

    # first argument contains data set
    x <- arglist[[1]]

    # and here we remove it from the list
    arglist[[1]] <- NULL

    # we use sapply twice - outer traverses functions and inner data set
    # because x is a defined argument name in sapply definition
    # we have to reorder arguments in function (FUN, x)
    result <- sapply(arglist, function (FUN, x) sapply(x, FUN), x)

    # in defining column names
    # we remove first element as it was name of data set argument
    colnames(result) <- var.names[-1]
    return(result)
}

# Apply function on builtin dataframe cars
multi.sapply(cars, min, mean, max)
```


## Throwing / Creating errors
```r
logitpercent <- function(x){
    if( any(x < 0 | x > 1) ) stop("x not between 0 and 1")
        log(x / (1 - x) )
}

logit(c("50%", "150%")) # Error in logit(as.numeric(x)/100) : x not between 0 and 1
```


## Create warnings
```r
logitpercent <- function(x){
x <- ifelse(x < 0 | x > 1, NA, x )
if( any(is.na(x)) ) warning("x not between 0 and 1")
    log(x / (1 - x) )
}

logitpercent(c("50%", "150%")) # Warning message: In logit(as.numeric(x)/100) : x not between 0 and 1
```


## Gray Code

    GrayEncode <- function(binary) {
        gray <- substr(binary,1,1)
        repeat {
        if (substr(binary,1,1) != substr(binary,2,2)) gray <- paste(gray,"1",sep="")
        else gray <- paste(gray,"0",sep="")
        binary <- substr(binary,2,nchar(binary))
        if (nchar(binary) <=1) {
            break
            }
        }
    return (gray)
    }
    GrayDecode <- function(gray) {
        binary <- substr(gray,1,1)
        repeat {
        if (substr(binary,nchar(binary),nchar(binary)) != substr(gray,2,2)) binary <- paste(binary ,"1",sep="")
        else binary <- paste(binary ,"0",sep="")
        gray <- substr(gray,2,nchar(gray))

        if (nchar(gray) <=1) {
            break
            }
        }
    return (binary)
    }


# Math Builtins
    # Newton Symbol/Binomial coefficient
    # Returns the number of possible combinations when drawing y elements at a time from x possibilities
    #  n! / ( k! (n - k)! )
    # choose(6,2) is 15
    choose(x, y)

    # Natural log
    log(x)
    
    # Sum
    sum(x)
    
    # Lagged differences, with lag indicating which lag to use
    diff(x, lag=1)
    
    # Exponential
    exp(x)
    
    # Mean
    mean(x)
    # Trimmed mean, removing any missing values and # 5 percent of highest and lowest scores
    mx <- mean(x, trim=.05, na.rm=TRUE) 
    
    # Largest element
    max(x)
    
    # Median
    median(x)
    
    # Smallest element
    min(x)
    
    # Range
    range(x)
    
    # Quantiles where x is the numeric vector whose quantiles are desired and probs is a numeric vector with probabilities in [0,1].
    quantile(x, probs)
    # 30th and 84th percentiles of x
    y <- quantile(x, c(.3,.84)) 
    
    # Round to n decimal places
    # round(123.456, digits = 2) # 123.46
    # Round numbers to multiples of  10, 100, and so on
    # round(-123.456, digits = -2) # -100
    round(x, n)
    
    # Rank of Vector elements
    rank(x)
    
    # Round to n significant figures
    # signif(-123.456, digits = 4) # -123.5
    signif(x, n)
    
    # Variance
    var(x)
    
    # Median absolute deviation
    mad(x)
    
    # Correlation
    cor(x, y)
    
    # The standard deviation
    sd(x)

    # Absolute value
    abs(x)

    # Square root
    sqrt(x)

    # ceiling(3.475) is 4
    ceiling(x)

    # floor(3.475) is 3
    floor(x)
    
    # Returns the factorial of x (x!)
    factorial(x)

    # trunc(5.99) is 5
    trunc(x)
    
    # round(3.475, digits=2) is 3.48
    round(x, digits=n)

    # signif(3.475, digits=2) is 3.5
    signif(x, digits=n)

    # Trigonometry
    # Calculate the cosine of an angle of 120 degrees
    # cos(120 * pi / 180)
    cos(x)
    
    sin(x)
    
    tan(x)
    
    acos(x)
    
    cosh(x)
    
    acosh(x)
    
    log(x)  natural logarithm

    log10(x)    common logarithm

    exp(x)  e^x


# Libraries


## Install library from bash i.e.: shiny
    sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""


## Install library From R
    install.packages('dplyr')
    
    
## Install the package along with all the packages (dependencies) required
    install.packages("Rcmdr", dependencies = TRUE)


## Load the package into the session, making all its functions available to use. 
    library(dplyr)

    # Use a particular function from a package (useful when there is collison in namespace)
    dplyr::select

    # Load a built-in dataset into the environment. 
    data(iris)


## Remove library
    detach(package:dplyr)


# Descriptive Statistics


## mean,median,25th and 75th quartiles,min,max
    summary(data)
    # Or
    sapply(mydata, mean, na.rm=TRUE)


## Column normalization (z-transformation)
The result will have mean=0 and sd=1.
    
    NormalizedVar <- (myVar - mean(myVar)) / sd(myVar)


# Dataset Operations


## Load Data
```r
# Read Tabular data with separated columns (commas or tabs)
# To import data, keeping the strings as strings, pass the argument stringsAsFactors = FALSE
read.table(file="myfile", sep="t", header=TRUE)

# Configured read.table() with all the arguments preset to read CSV files
read.csv(file="myfile")

# Configured read.csv() for data with a comma as the decimal point and a semicolon as the separator
read.csv2(file="myfile", header=TRUE)

# Read delimited files, with tabs as the default
read.delim(file="myfile", header=TRUE)

# Allows finer control over the read process when data isn’t tabular
scan("myfile", skip = 1, nmax=100)

# Reads text from a text file one line at a time
readLines("myfile")

# Read a file with dates in fixed-width format (each column in the data has a fixed number of characters)
read.fwf("myfile", widths=c(1,2,3)

# Reads SPSS data file
library("foreign")
read.spss("myfile")

# Reads Stata binary file
library("foreign")
read.dta("myfile")

# Reads SAS export file
library("foreign")
read.export("myfile")

# Load dataset with different encoding (Handling polish encoding)
fileEncoding='windows-1250'
# Skip the first 1825 lines
skip=1825
data = read.table('data.csv', header=T, sep=",")
```


## Write Data
    # Write tabular data
    write.table(head(iris), file = "clipboard", sep = "\t", row.names = FALSE)


## Load several files
```r
# Get all files in folder that match the pattern *.csv
files<-list.files(pattern="*.csv")

# Load all files
print("Loading files...")
for(n in 1:length(files)){
    # Import the file and sort the headers
    print(files[n])
    temp=read.table(files[n], header=T, sep=",")
}
```


## Save File
```r
# Prevent row names to be written to file
row.names=FALSE
# Save csv
write.table(data, file = "filename", append = FALSE, quote = TRUE, sep = ",",
        eol = "\n", 
        na = "NA", 
        dec = ".", 
        row.names = FALSE,
        col.names = TRUE, 
        qmethod = c("escape", "double"),
        fileEncoding = "windows-1250")
```


## Generate random data CSV file
```r
# Set the working directory
setwd("C:/!Migracja/R/SNIPPETS")

# Check working directory
getwd()

gen_data <- function(N, K, scaling) {
    alpha <- 2 * pi * (1:N) / K
    sin_pi_K <- 2 * sin(pi / K)

    X <- as.data.frame(matrix(data=rnorm(n=2*N), nrow=N, ncol=2) +
                       scaling*matrix(data = c(cos(alpha), sin(alpha)),
                                      nrow = N, ncol = 2) / sin_pi_K)
    return(data.frame(x = X$V1, y = X$V2))
}

set.seed(1)
write.table(x = gen_data(200, 4, 5), file = "test.txt",
            col.names = TRUE, row.names = FALSE,
            sep = ",", dec = ".")
```


## Apply function on rows / columns with apply
```r
counts <- matrix(c(3, 2, 4, 6, 5, 1, 8, 6, 1), ncol = 3)
colnames(counts) <- c("sparrow", "dove", "crow")
# 2 is The dimension or index over which the function has to be applied:
# The number 1 means row‐wise, and the number 2 means column‐wise.
# Here, we apply the function over the columns. In the case of moredimensional
# arrays, this index can be larger than 2.
apply(counts, 2, max)
apply(counts, 2, min)
```


## Merge two CSV Files with same headers
```r
d1=read.table("student-mat.csv", sep=";", header=TRUE)
d2=read.table("student-por.csv", sep=";", header=TRUE)

# Vector of headers
d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
print(nrow(d3)) # 382 students
```


# Data Cleanup


## Show information about dataset
```r
str(cars)
```


##  Convert yes/no to 1/0 (Replace data frame column values)
```r
data$x <- ifelse(data$x=='yes', 1,0) 
```


## Convert numerical values 1/0 to TRUE/FALSE
```r
data$x <- as.logical(as.integer(data$x))
```


## Convert factor to numerical integer
```r
dataset$x <- as.integer(as.factor(dataset$x))
```


## Convert to factor
```r
directions <- c("North", "East", "South", "South")
directions.factor <- factor(directions)
```


## Determine the number of NA values in a column (Sum NA Values)
```r
# Count NA values in column
sum(is.na(dataset$col))

# Count NA values in dataframe
sum(is.na(dataset))

# Count NA for each column
na_count <-sapply(dataset, function(y) sum(length(which(is.na(y)))))
na_count <- data.frame(na_count)
```


## Divide into groups (Group numerical objects into buckets or bins)
```r
# Remove NA values
missing.age <- is.na(dataset$age)
dataset <- dataset[!missing.age,]

# Next we will name our age groups (or "bins" or "buckets") 0-4, 5-9, 10-14 and so on.
labs <- c(paste(seq(0, 95, by = 5), seq(0 + 5 - 1, 100 - 1, by = 5), sep = "-"), paste(100, "+", sep = ""))

# Convert factor to numerical
dataset$age <- as.integer(as.factor(dataset$age))

# To add the ages to age groups, we create a new column agegroup and use the cut function to 
# break age into groups with the labels we defined in the previous step.
dataset$agegroup <- cut(dataset$age, breaks = c(seq(0, 100, by = 5), Inf), labels = labs, right = FALSE)
# new AgeGroup column shown alongside the Age data.
head(dataset[c("age", "agegroup")], 15)
```


## Remove columns
```r
# Remove column by name
dataset$x <- NULL

# Remove column by index (second column)
data[2] <- NULL

# Remove multiple columns by index
data[c(1,6,10,12,13,14,15)] <- NULL
```


## Get 20 records data sample
```r
data("iris")
iris[sample(nrow(iris), 20),]
```


# Plots


## Semilog plot (one log-scale axis)
```r
x = 1:100
y = x^2
plot(x, y, log="y")
```


## Basic Histogram     
    data1 <- read.table ("DATA1.txt", header=TRUE)
    hist(data1$X)
  
  
## XY Plot
    data1 <- read.table ("DATA1.txt", header=TRUE)
    plot(data1$X, data1$Y)
  
  
## Histogram and Frequency
    library(MASS)
    data(anorexia)
    attach(anorexia)

    # Create area for 2 plots
    par(mfrow=c(1,2), pty="s" )
    options(OutDec=",")

    # Histogram
    hist(Prewt, breaks=nclass.FD(Prewt), main="", col="slategrey", xlab="Weight", ylab="Frequency")
    title("a)", font.main=1)

    # Density function
    hist(Prewt, freq=FALSE, breaks=nclass.FD(Prewt), main="", col="slategrey", xlab="Weight", ylab="Density")
    title("b)", font.main=1)

    lines(density(Prewt, kernel="gaussian", width=10, n=150))
    detach(anorexia)


# Distributions
All these functions can be used by replacing the letter r with d, p or q to  
get, respectively, the probability density (dfunc(x, ...)), the cumulative  
probability density (pfunc(x, ...)), and the value of quantile (qfunc(p,...), with 0 < p < 1).  

## Gaussian (normal)
    # n random normal deviates with mean m and standard deviation sd. 
    rnorm(n, mean=0, sd=1)
    
    # Normal density function (by default m=0 sd=1)
    dnorm(x)
    
    # cumulative normal probability for q (area under the normal curve to the left of q)
    pnorm(1.96) is 0.975 
    pnorm(q)

    # Normal quantile (value at the p percentile of normal distribution 
    qnorm(.9) is 1.28 # 90th percentile
    qnorm(p)
    
    
## Exponential
    rexp(n, rate=1)
    
    
## Gamma
    rgamma(n, shape, scale=1)

    
##  Poisson
    rpois(n, lambda)

    
## Weibull
    rweibull(n, shape, scale=1)
    
    
## Cauchy
    rcauchy(n, location=0, scale=1)

    
## Beta
    rbeta(n, shape1, shape2)
    
    
## 'Student' (t)
    rt(n, df)
    
    
## Fisher–Snedecor (F) (χ2)
    rf(n, df1, df2)
    
    
## Pearson
    rchisq(n, df)
    
    
## Binomial
    # binomial distribution where size is the sample size and prob is the probability of a coin heads (pi)
    # prob of 0 to 5 heads of fair coin out of 10 flips dbinom(0:5, 10, .5)
    # prob of 5 or less heads of fair coin out of 10 flips pbinom(5, 10, .5) 
    dbinom(x, size, prob)
    
    
    
## Geometric
    rgeom(n, prob)
    
    
## Hypergeometric
    rhyper(nn, m, n, k)
    
    
## Logistic
    rlogis(n, location=0, scale=1)
    
    
## Lognormal
    rlnorm(n, meanlog=0, sdlog=1)
    
    
## Negative binomial
    rnbinom(n, size, prob)
    
    
## Uniform
    runif(n, min=0, max=1)
    
    
## Wilcoxon’s statistics
    rwilcox(nn, m, n), rsignrank(nn, n)


# Statistics
if p-value is bigger than given α level of significance we fail to reject the null hypothesis (no difference was     detected)
i.e:
p-value = 0.588 > 0.05 = α

#https://www.dummies.com/programming/r-projects-dummies-cheat-sheet/

    # F test to compare two variances
    var.test(x, y)
    
    # Shapiro-Wilk test to check for normality
    shapiro.test(x)
    
    # Two Sample t-test
    # Normal distribution
    # Homogeneity of variance
    t.test (x, y, alternative = 'less', var.equal = T)
    
    # Paired t-test (x and y are releated)
    # Normal distribution
    t.test (x ,y, paired = T, alternative = 'greater')

    # Perform a t-test for difference between means. 
    t.test(x, y)
    
    # Wilcoxon test
    # No Normal distribution
    # 2 Paired samples
    wilcox.test(x, y, paired=T, alternative='greater')
    
    binom.test()
    
    pairwise.t.test()
    
    power.t.test(),
    
    prop.test()
   
    # Use help.search("test")


# Linear Model


## Create linear model
    data1 <- read.table ("DATA1.txt", header=TRUE)
    X <- data1$X
    Y <- data1$Y
    lm(Y~X)

    lm.linear <- lm ( Y ~ X)
    lm.linear
    
    summary(lm.linear)


## Create linear model and Add plot with regression line
    # Load Dataset
    data1 <- read.table ("DATA1.txt", header=TRUE)
    X <- data1$X
    Y <- data1$Y
    
    # Create linear model
    lm(Y~X)
    lm.linear <- lm ( Y ~ X)
    lm.linear
    
    # Define particular width and height for plot
    dev.new(width=20, height=8)

    # Make simple plot of X and Y
    plot(data1$X, data1$Y)

    # Add regression line
    abline(lm.linear)

    # levels of confidence
    # ***  0 < p < 0.001
    # **   0.001 < p < 0.01
    # *    0.01 < p < 0.05
 
 
## Linear model residuals (Histogram reszt modelu)
    # Load Dataset
    data1 <- read.table ("DATA1.txt", header=TRUE)
    X <- data1$X
    Y <- data1$Y
    
    # Create linear model
    lm(Y~X)
    lm.linear <- lm ( Y ~ X)
    lm.linear

    residuals(lm.linear)
    lm.linear.resids <- residuals(lm.linear)
    hist(lm.linear.resids)


## Fitted values
Funkcja fitted zwraca jako wynik wartości dopasowane przez model -
wartości Y które uzyskalibyśmy przy najlepiej dopasowanej prostej
regresji, przy danych obserwacjach X
    
    # Load Dataset
    data1 <- read.table ("DATA1.txt", header=TRUE)
    X <- data1$X
    Y <- data1$Y
    
    # Create linear model
    lm(Y~X)
    lm.linear <- lm ( Y ~ X)
    lm.linear
    
    # Check value
    fitted(lm.linear)

    plot(X, Y)
    lines(X, fitted(lm.linear))


# Association rules
    
    # Set the number of displayed significant digits to two to make the output easier to read
    set.seed(1234)

    # Set the seed for the random number generator for predictability
    options(digits = 2)

    # Association rule visualization
    library("arulesViz")

    # Load sales data from a local grocery store (9835 transactions and 169 items(product groups))
    data("Groceries")

    # Mine association rules using the Apriori algorithm implemented in arules package
    rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))

    # Show set of association rules
    rules

    # Show top three rules with respect to the liftmeasure (a popular measure of rule strength)
    inspect(head(rules, n = 3, by ="lift"))

    # Show interface (arguments) of plot
    args(getS3method("plot", "rules"))

    # Visualization of association rules with scatter plot
    plot(rules)

    # Show default measures generated by Apriori
    head(quality(rules))

    # Customizethe plot by switching lift and confidence (lift on the y-axis)
    plot(rules, measure = c("support", "lift"), shading = "confidence")


# shiny package


Build interactive web apps

    #SERVER

    #
    # This is the server logic of a Shiny web application. You can run the
    # application by clicking 'Run App' above.
    #
    # Find out more about building applications with Shiny here:
    #
    #    http://shiny.rstudio.com/
    #

    library(shiny)
    library(ggplot2)
    library(tidyverse)
    # Define server logic required to draw a histogram
    shinyServer(function(input, output) {

      output$distPlot <- renderPlot({
        prep <-  filter(iris, Species == input$speciesSelector)
        reg <- input$regr
        ggplot(data = prep, mapping = aes(x= prep$Sepal.Width, y = prep$Sepal.Length, color = prep$Species)) + geom_point() + facet_grid(cols = vars(prep$Species)) + theme_bw() +labs(title = "Iris data viz") + stat_smooth(method = reg)

      })

    })


    #UI

    #
    # This is the user-interface definition of a Shiny web application. You can
    # run the application by clicking 'Run App' above.
    #
    # Find out more about building applications with Shiny here:
    #
    #    http://shiny.rstudio.com/
    #

    library(shiny)

    # Define UI for application that draws a histogram
    shinyUI(fluidPage(

      # Application title
      titlePanel("Iris data"),

      # Sidebar with a slider input for number of bins
      sidebarLayout(
        sidebarPanel(
          checkboxGroupInput("speciesSelector", "Species to show:",
                             c("Setosa" = "setosa",
                               "Versicolor" = "versicolor",
                               "Virginica" = "virginica")),
         radioButtons("regr", "Species to show:",
                             c("lm" = "lm",
                               "loess" = "loess",
                               "glm" = "glm"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
      )
    ))


# stringr package - string manipulation


The stringr package provides a set of  
internally consistent tools for working with character strings,  
i.e. sequences of characters surrounded by quotation marks.  

## Detect the presence of a pattern match in a string.
    # str_detect(string, pattern) 
    str_detect(fruit, "a")


## Find the indexes of strings that contain a pattern match.
    #str_which(string, pattern) 
    str_which(fruit, "a")


## Count the number of matches in a string.
    #str_count(string, pattern) 
    str_count(fruit, "a")


## Locate the positions of pattern matches in a string. Also str_locate_all.
    #str_locate(string, pattern)
    str_locate(fruit, "a")


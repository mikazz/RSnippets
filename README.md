# RSnippets
Collection of R code snippets

### Hello World and basic functions
    sayHello <- function(){
    print('hello')
    }
    sayHello()

### Assign values to variables
    MyVar <- value
#### or
    MyVar = value
#### or
    value -> MyVar
    

### Installing libraries
#### i.e.: shiny
    sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""
    
    
### Descriptive Statistics
#### mean,median,25th and 75th quartiles,min,max
    summary(data)
#### or
    sapply(mydata, mean, na.rm=TRUE)
    

### Column normalization (z-transformation)
#### The result will have mean=0 and sd=1.
    NormalizedVar <- (myVar - mean(myVar)) / sd(myVar)


### Load dataset
#### data.txt
    data1 <- read.table ("data.txt", header=TRUE)


### Basic Histogram
    hist(data1$X)
    
### Linear Model
    X <- data1 $X
    Y <- data1 $Y
    lm(Y ~ X )

    lm.linear <- lm ( Y ~ X)
    lm.linear
#### Model summary
    summary(lm.linear)

#### Add plot with regression line 
    # Make simple plot of X and Y
    plot(data1$X, data1$Y)
    # Add regression line
    abline(lm.linear)

    
####    ***  0 < p < 0.001
####    **   0.001 < p < 0.01
####    *    0.01 < p < 0.05

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

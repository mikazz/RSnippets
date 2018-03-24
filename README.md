# RSnippets
Collection of R code snippets

### Hello World and basic functions
    sayHello <- function(){
    print('hello')
    }
    sayHello()

### Assign
    var <- value
#### or
    var = value
#### or
    value -> var
    

### Installing libraries
#### i.e.: shiny
    sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""
    
    
### Descriptive Statistics
#### mean,median,25th and 75th quartiles,min,max
    summary(data)
#### or
    sapply(mydata, mean, na.rm=TRUE)
    

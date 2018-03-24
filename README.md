# RSnippets
Collection of R code snippets

### Hello World
    sayHello <- function(){
    print('hello')
    }
    sayHello()


### Installing libraries
#### i.e.: shiny
    sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""
    
    
### Descriptive Statistics
#### mean,median,25th and 75th quartiles,min,max
    summary(data)
#### or
    sapply(mydata, mean, na.rm=TRUE)
    

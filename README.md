# RSnippets
Collection of R code snippets


# Basics


## If Statements
    if (i > 3){
    	print(‘Yes’)
    } 
	else {
    	print(‘No’)
    }


## While
    while (i < 5){
		print(i)
		i <- i + 1
    }


## For loop
    for (i in 1:4){
		j <- i + 10
		print(j)
    }


## Hello World from basic function
    sayHello <- function(){
    	print('Hello World')
    }
    sayHello()


## Square function
    square <- function(x){
    	squared <- x*x
    	return(squared)
    }


# Basic Calculator

    2+2

    2^10 -1 # [1] 1023

    1/5 # [1] 0.2

    sin(pi/2) # [1] 1

    sin(pi/3)^2 + cos(pi/3)^2 #[1] 1

    > (3+7)^(4-2)
    [1] 100
    > atan2(1,1) # wywołanie funkcji arcus tangens, patrz tabela 1.1
    [1] 0.7853982
    > pi/4
    [1] 0.7853982
    > log(1024,2)
    [1] 10
    > choose(6,2) # symbol Newtona, nie każdy kalkulator potrafi go wyliczyć
    [1] 15


# Program inside


## Help
    # wyświetl pomoc dotyczącą funkcji plot()
    ?plot

    # wyświetl przykłady użycia funkcji plot()
    example(plot)

    # wyświetl nazwy funkcji ze słowem "test" w nazwie
    apropos("test")

    # wyświetl nazwy funkcji ze zwrotem ’normality test’ w opisie
    help.search("normality test")


## Manage Objects
    # Show imported names
    # Unless you specify check.names=FALSE, R will convert column names that are not valid variable names 
    # (e.g. contain spaces or special characters or start with numbers) into valid variable names, e.g. 
    # by replacing spaces with dots.
    names(data)

	# List all the created objects in the environment
	ls()
	
	# Delete created object
	rm(z)


## Save Work
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
	

## Check the Default working directory (should be your user folder)
	 getwd()


# Strings


## Concatenate multiple text elements. By default, paste() puts a space between the different elements
	paste("Hello", "world!")


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


## Math functions    
    log(x) Natural log. 
    sum(x) Sum.
    exp(x) Exponential. 
    mean(x) Mean.
    max(x) Largest element. 
    median(x) Median.
    min(x) Smallest element. 
    quantile(x) Percentage quantiles.
    round(x, n) Round to n decimal places.
    rank(x) Rank of elements.
    signif(x, n) Round to n significant figures.
    var(x) The variance.
    cor(x, y) Correlation. 
    sd(x) The standard deviation
    

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


## Read Tabular data with separated columns (commas or tabs)

	read.table(file="myfile", sep="t", header=TRUE)


## Configured read.table() with all the arguments preset to read CSV files

	read.csv(file="myfile")


## Configured read.csv() configured for data with a comma as the decimal point and a semicolon as the separator
	
	read.csv2(file=”myfile”, header=TRUE)


## Read delimited files, with tabs as the default
	
	read.delim(file=”myfile”, header=TRUE)


## Allows finer control over the read process when data isn’t tabular	
	
	scan("myfile", skip = 1, nmax=100)


## Reads text from a text file one line at a time	
	
	readLines("myfile")


## Read a file with dates in fixed-width format (each column in the data has a fixed number of characters)
	
	read.fwf("myfile", widths=c(1,2,3)


## Reads SPSS data file	
	
	library("foreign")
	read.spss("myfile")


## Reads Stata binary file	
	
	read.dta("myfile")


## Reads SAS export file
	
	read.export("myfile")
	

## Load dataset with different encoding
    # Handling polish encoding
    fileEncoding='windows-1250'

    # Skip the first 1825 lines.
    skip=1825

    data = read.table('data.csv', header=T, sep=",")


## Save csv
    # Prevent row names to be written to file
    row.names=FALSE

    write.table(data, file = "filename", append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", 
            na = "NA", 
            dec = ".", 
            row.names = FALSE,
            col.names = TRUE, 
            qmethod = c("escape", "double"),
            fileEncoding = "windows-1250")

## Load several files

    # Get all files in folder that match the pattern *.csv
    files<-list.files(pattern="*.csv")
    
    # Load all files
    print("Loading files...")
    for(n in 1:length(files)){
        # Import the file and sort the headers
        print(files[n])
        temp=read.table(files[n], header=T, sep=",")
    }


# Plots


## Semilog plot (one log-scale axis)
    x = 1:100
    y = x^2
    plot(x, y, log="y")


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


## Distributions
All these functions can be used by replacing the letter r with d, p or q to
get, respectively, the probability density (dfunc(x, ...)), the cumulative
probability density (pfunc(x, ...)), and the value of quantile (qfunc(p,...), with 0 < p < 1).

    #  Gaussian (normal)
    rnorm(n, mean=0, sd=1)
    
    #  exponential
    rexp(n, rate=1)
    
    # gamma
    rgamma(n, shape, scale=1)

    #  Poisson
    rpois(n, lambda)

    # Weibull
    rweibull(n, shape, scale=1)
    
    # Cauchy
    rcauchy(n, location=0, scale=1)

    # beta
    rbeta(n, shape1, shape2)
    
    # 'Student' (t)
    rt(n, df)
    
    # Fisher–Snedecor (F) (χ2)
    rf(n, df1, df2)
    
    # Pearson
    rchisq(n, df)
    
    # binomial
    rbinom(n, size, prob)
    
    # geometric
    rgeom(n, prob)
    
    # hypergeometric
    rhyper(nn, m, n, k)
    
    # logistic
    rlogis(n, location=0, scale=1)
    
    # lognormal
    rlnorm(n, meanlog=0, sdlog=1)
    
    # negative binomial
    rnbinom(n, size, prob)
    
    # uniform
    runif(n, min=0, max=1)
    
    # Wilcoxon’s statistics
    rwilcox(nn, m, n), rsignrank(nn, n)



# Statistics
if p-value is bigger than given α level of significance we fail to reject the null hypothesis (no difference was     detected)
i.e:
p-value = 0.588 > 0.05 = α

    F test to compare two variances
    var.test(x, y)
    
    # Two Sample t-test
    t.test (x, y, alternative = 'less', var.equal = T)
    
    # Paired t-test (x and y are releated)
    t.test (x ,y, paired = T, alternative = 'greater')

    # Perform a t-test for difference between means. 
    t.test(x, y)
    
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


# Shiny
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



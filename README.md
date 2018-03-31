# RSnippets
Collection of R code snippets

### Hello World from basic function
    sayHello <- function(){
    print('Hello World')
    }
    sayHello()

### Assign values to variables
    MyVar <- value
    # Or
    MyVar = value
    # Or
    value -> MyVar

### Assign vectors
    # All integers in the range 2-8
    vector_var <- 2:8
    # Which is the same as
    vector_var <- c(2,3,4,5,6,7,8)
    

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
    # data.txt
    data1 <- read.table("data.txt", header=TRUE)

### Load several files (Google trends)

    # Get all files in folder that match the pattern 20xx-Hx.csv
    files<-list.files(pattern="20[0-9][0-9]-H[1-2].csv")
    
    # Load all files
    print("Loading files...")
    for(n in 1:length(files)){
        # Import the file and sort the headers
        print(files[n])
        temp=read.table(files[n], header=T, sep=",")
    }



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

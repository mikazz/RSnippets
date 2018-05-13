# RSnippets
Collection of R code snippets



Dataset Operations
Statistics
Linear Model
Regex


# 1



### If Statements
    if (condition){
    Do something
    } else {
    Do something different
    }

Example

    if (i > 3){
    print(‘Yes’)
    } else {
    print(‘No’)
    }




### While

    while (condition){
    Do something
    }

Example

    while (i < 5){
    print(i)
    i <- i + 1
    }



### For loop

    for (variable in sequence){
    Do something
    }
Example:

    for (i in 1:4){
    j <- i + 10
    print(j)
    }



### Hello World from basic function
    sayHello <- function(){
    print('Hello World')
    }
    sayHello()



### Square function
    square <- function(x){
    squared <- x*x
    return(squared)
    }



### Assign values to variables
    MyVar <- value
    # Or
    MyVar = value
    # Or
    value -> MyVar




### Assign vectors
    # Join elements into a vector
    vector_var <- c(2, 4, 6) # 2 4 6
    
    # An integer sequence
    vector_var <- 2:6 # 2 3 4 5 6
    
    # A complex sequence
    vector_var <- seq(2, 3, by=0.5) # 2.0 2.5 3.0 

    # Repeat a vector
    vector_var <- rep(1:2, times=3) # 1 2 1 2 1 2

    # Repeat elements
    vector_var <- rep(1:2, each=3) # 1 1 1 2 2 2

### Math functions    
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
    

### Installing libraries
#### From bash i.e.: shiny
    sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""
#### From R
    # Download and install a package from CRAN
    install.packages('dplyr')

# 2


### Descriptive Statistics
#### mean,median,25th and 75th quartiles,min,max
    summary(data)

or

    sapply(mydata, mean, na.rm=TRUE)
    
### Column normalization (z-transformation)
The result will have mean=0 and sd=1.
    
    NormalizedVar <- (myVar - mean(myVar)) / sd(myVar)


## Dataset Operations

### Load dataset

#### Handling polish encoding

    data = read.table('history_csv_20180512_233919.csv', fileEncoding='windows-1250', header=T, sep=",")

#### Show imported names
Unless you specify check.names=FALSE, R will convert column names that are not valid variable names (e.g. contain spaces or special characters or start with numbers) into valid variable names, e.g. by replacing spaces with dots.

    names(data)
    
    
    

### Load several files (Google trends)

    # Get all files in folder that match the pattern *.csv
    files<-list.files(pattern="*.csv")
    
    # Load all files
    print("Loading files...")
    for(n in 1:length(files)){
        # Import the file and sort the headers
        print(files[n])
        temp=read.table(files[n], header=T, sep=",")
    }


### Basic Histogram
    
    hist(data1$X)
    
    
### Histogram and Frequency

    library(MASS)
    data(anorexia)
    attach(anorexia)

    # Create area for 2 plots
    par(mfrow=c(1,2), pty="s" )
    options(OutDec=",")

    #Histogram
    hist(Prewt, breaks=nclass.FD(Prewt), main="", col="slategrey", xlab="Weight", ylab="Frequency")
    title("a)", font.main=1)

    #Density function
    hist(Prewt, freq=FALSE, breaks=nclass.FD(Prewt), main="", col="slategrey", xlab="Weight", ylab="Density")
    title("b)", font.main=1)

    lines(density(Prewt, kernel="gaussian", width=10, n=150))
    detach(anorexia)

### Distributions
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

### Statistics
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


### Linear Model
    X <- data1 $X
    Y <- data1 $Y
    lm(Y ~ X )

    lm.linear <- lm ( Y ~ X)
    lm.linear


#### Model summary
    summary(lm.linear)


#### Add plot with regression line
Define particular width and height for plot

    dev.new(width=20, height=8)

Make simple plot of X and Y
    
    plot(data1$X, data1$Y)
Add regression line
    
    abline(lm.linear)

levels of confidence

    ***  0 < p < 0.001
    **   0.001 < p < 0.01
    *    0.01 < p < 0.05
    
### Regex
Simplest patterns match exact strings:

    x <- c("apple", "banana", "pear")
    str_extract(x, "an")
    #> [1] NA   "an" NA





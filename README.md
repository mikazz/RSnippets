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
    
#### Comma Delimited Files
    read_csv("file.csv")
    # To make file.csv run:
    write_file(x = "a,b,c\n1,2,3\n4,5,NA", path = "file.csv")
    
#### Semi-colon Delimited Files
    read_csv2("file2.csv")
    write_file(x = "a;b;c\n1;2;3\n4;5;NA", path = "file2.csv")

#### Files with Any Delimiter
    read_delim("file.txt", delim = "|")
    write_file(x = "a|b|c\n1|2|3\n4|5|NA", path = "file.txt")

#### Fixed Width Files
    read_fwf("file.fwf", col_positions = c(1, 3, 5))
    write_file(x = "a b c\n1 2 3\n4 5 NA", path = "file.fwf")

#### Tab Delimited Files
    read_tsv("file.tsv") Also read_table().
    write_file(x = "a\tb\tc\n1\t2\t3\n4\t5\tNA", path = "file.tsv")
    
    
    

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
    probability density (pfunc(x, ...)), and the value of quantile (qfunc(p,
    ...), with 0 < p < 1).

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
    
    #  Cauchy
    rcauchy(n, location=0, scale=1)

    # beta
    rbeta(n, shape1, shape2)
    
    #  'Student' (t)
    rt(n, df)
    
    # Fisher–Snedecor (F) (χ2)
    rf(n, df1, df2)

    rchisq(n, df) Pearson
    rbinom(n, size, prob) binomial
    rgeom(n, prob) geometric
    rhyper(nn, m, n, k) hypergeometric
    rlogis(n, location=0, scale=1) logistic
    rlnorm(n, meanlog=0, sdlog=1) lognormal
    rnbinom(n, size, prob) negative binomial
    runif(n, min=0, max=1) uniform
    rwilcox(nn, m, n), rsignrank(nn, n) Wilcoxon’s statistics



### Statistics
    # Perform a t-test for difference between means. 
    t.test(x, y)


    
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

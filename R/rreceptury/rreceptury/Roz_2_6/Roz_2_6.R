library(nortest)
library(tseries)
library(reshape)
set.seed(1)

Evaluate <- function(function.name) {
	eval(parse(text = function.name))
}

GenerateData <- function(data.type, number.of.observations) {
	if (data.type == "norm") {
    return (rnorm(number.of.observations))
  }
	return(replicate(number.of.observations, sum(runif(2))))
}

TestNormality <- function(test, data) {
  GetPvalue <- function(performed.test) {
    return(performed.test$p.value)
  }
	return(sapply(lapply(data, test), GetPvalue))
}

GetRejectionRate <- function(p.values) {
  return(round(mean(p.values < 0.05), digits = 4))
}

TEST_NAMES <- c("ad.test", "cvm.test", "lillie.test", "sf.test",
                "pearson.test", "shapiro.test", "jarque.bera.test")
TEST_LABELS <- substr(TEST_NAMES, start = 1, stop = nchar(TEST_NAMES) - 5)
TESTS <- sapply(TEST_NAMES, Evaluate)
BASE <- expand.grid(data.type = c("tria", "norm"), count = c(10, 100, 1000))

TestNormalityTests <- function(replications) {
	data.types <- rep(BASE$data.type, replications)
	counts <- rep(BASE$count, replications)
	samples <- mapply(GenerateData, data.types, counts, SIMPLIFY = F)
	results <- data.frame(data.types, counts,
                        test = rep(TEST_LABELS, each = length(data.types)),
		                    reject = unlist(lapply(TESTS, TestNormality,
                                               data = samples),
                                        use.names = FALSE))
	final.results <- aggregate(results[4], by = results[, -4], GetRejectionRate)
  molten.data <- melt(final.results, id.vars = 1:3)
  pivot.table <- cast(molten.data, data.types + test ~ counts)
  names(pivot.table)[3:5] <- paste("rej.", 10 ^ (1:3), sep = "")
  print(with(pivot.table, pivot.table[order(paste(data.types, test)), ]),
	      row.names = FALSE)
}

cat("\nCzas dzia³ania (s.):",
    system.time(TestNormalityTests(2 ^ 12))[3], "\n")

# Plik z danymi wejœciowymi do pobrania:
# http://archive.ics.uci.edu/ml/
#       machine-learning-databases/statlog/german/german.data-numeric

set.seed(1)
DATA_SET <- read.fwf("german.data-numeric.txt",
                     widths = rep(4, 25), header = FALSE)
names(DATA_SET)[25] <- "target"
DATA_SET$target <- 2 - DATA_SET$target

SplitDataSet <- function(data.set, training.fraction){
  random.numbers <- sample.int(nrow(data.set))
  quantiles <- quantile(random.numbers, probs = c(0, training.fraction, 1))
  split.labels <- cut(random.numbers, quantiles, include.lowest = T,
                      labels = c("training", "validation"))
  return(split(data.set, split.labels))
}
  
CalculateCost <-function(cut.off, cost.matrix, score, true.y){
  prediction <- ifelse(score > cut.off, 1, 0)
  confusion.matrix <- prop.table(table(factor(prediction, levels = c(0, 1)),
                                       true.y))
  return(sum(cost.matrix * confusion.matrix))
}

set <- SplitDataSet(DATA_SET, 0.5)

score <- costs <- list()
model <- glm(target ~ ., data = set$training, family = binomial())

CUT_OFFS <- seq(0.5, 1, by = 0.01) 
BAD_CREDIT_COST <- 5
LOST_CLIENT_COST <- 1
COST_MATRIX <- matrix(c(0, BAD_CREDIT_COST, LOST_CLIENT_COST, 0), 2)
score[[1]] <- predict(model, newdata = set$validation, type = "response")
costs[[1]] <- sapply(CUT_OFFS, CalculateCost, cost.matrix = COST_MATRIX,
                     score = score[[1]], true.y = set$validation$target)
score[[2]] <- predict(model, type = "response")
costs[[2]] <- sapply(CUT_OFFS, CalculateCost, cost.matrix = COST_MATRIX,
                     score = score[[2]], true.y = set$training$target)

plot(data.frame(CUT_OFFS, 0.7), type = "l", lty = 3, log = "y",
     ylim = range(c(0.7, unlist(costs))),
     ylab = "Koszt per klient", xlab = "Próg odciêcia")
for (i in 1:2) {
	 lines(CUT_OFFS, costs[[i]], lty = i, lwd = 2)
	 points(CUT_OFFS[which.min(costs[[i]])], min(costs[[i]]),
         pch = 19, cex = 1.3)
}

legend("topright", c("Walidacyjny", "Ucz¹cy", "bez modelu"),
       lty = c(1, 2, 3), cex = .7, ncol = 3,
       lwd = c(2, 2, 1))

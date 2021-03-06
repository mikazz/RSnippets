# Plik z danymi wej�ciowymi do pobrania:
# http://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data

library(party)
library(rpart)
library(randomForest)
library(RColorBrewer)
set.seed(1)

DATA_SET <- read.csv("car.data.txt", header = FALSE)
names(DATA_SET) <- c("buying", "maint", "doors", "persons",
                     "lug_boot", "safety", "class")
DATA_SET$class <- factor(ifelse(DATA_SET$class == "unacc", 0, 1))
TRAINING_SET_FRACTION <- 0.2
training.set.index <- (runif(nrow(DATA_SET)) < TRAINING_SET_FRACTION)
train.set <- DATA_SET[training.set.index, ]
test.set <- DATA_SET[!training.set.index, ]

ctree.model <- ctree(factor(class) ~ ., data = train.set,
                     controls = ctree_control(mincriterion = 0.99,
                                              minsplit = 20))
plot(ctree.model, tnex = 2, type = "extended")
devAskNewPage(ask = TRUE)

rpart.model <- rpart(class ~ ., train.set, cp = 0.00001, minsplit = 2)
plotcp(rpart.model)
minimum.error <- which.min(rpart.model$cptable[, "xerror"])
optimal.complexity <- rpart.model$cptable[minimum.error, "CP"]
points(minimum.error, rpart.model$cptable[minimum.error, "xerror"],
       pch = 19)
pruned.tree <- prune(rpart.model, cp = optimal.complexity)
plot(pruned.tree, compress = T, uniform = T, margin = 0.1,
     branch = 0.3, nspace = 2)
text(pruned.tree, use.n = TRUE, pretty = 0)

forest <- randomForest(class ~ ., data = train.set, ntree = 300)
par(mfrow = c(3, 1), mar = c(4, 4, 2, 1))
plot(forest, col = "black")
varImpPlot(forest, bg = 1)
plot(margin(forest, sort = TRUE), ylim = c(-1, 1), ylab = "margin")
abline(h = 0, lty = 2)

confusion.matrix <- list()
cat("Macierz trafno�ci ctree")
print(confusion.matrix[[1]] <- table(predict(ctree.model, new = test.set),
                                     test.set$class))
cat("\nMacierz trafno�ci rpart przyci�ty\n")
print(confusion.matrix[[2]] <- table(predict(pruned.tree, type = "class",
                                             newdata = test.set),
                                     test.set$class))
cat("\nMacierz trafno�ci las losowy")
print(confusion.matrix[[3]] <- table(predict(forest, newdata = test.set),
                                     test.set$class))
cat("\nPor�wnanie dok�adno�ci modeli\n")
CalculateAccuracy <- function(confusion.matrix) {
  return(sum(diag(confusion.matrix)) / sum(confusion.matrix))
}
print(data.frame(model = c("ctree", "rpart przyci�ty", "las losowy"),
                 dok�adno�� = sapply(confusion.matrix, CalculateAccuracy)),
      row.names = FALSE)

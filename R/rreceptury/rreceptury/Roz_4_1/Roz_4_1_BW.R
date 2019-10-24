# Plik z danymi wejœciowymi do pobrania:
# http://archive.ics.uci.edu/ml/
#         machine-learning-databases/communities/communities.data

library(leaps)
library(MASS)
library(lasso2)
set.seed(1)
RAW_DATA_SET <- read.csv("communities.data", head = F, na.str = "?")
DATA_SET <- RAW_DATA_SET[-4]
for (j in 1:ncol(DATA_SET)) {
  DATA_SET[is.na(DATA_SET[, j]), j] <- mean(DATA_SET[, j], na.rm = TRUE)
}
SCALED_DATA_SET <- scale(DATA_SET)
rows.to.erase <- c()
for (i in 1:nrow(DATA_SET)) {
  if (any(abs(SCALED_DATA_SET[i, ]) > 6)) {
    rows.to.erase <- c(rows.to.erase, i)
  }
}
FINAL_DATA <- data.frame(SCALED_DATA_SET[-rows.to.erase, ])

random.numbers <- sample.int(nrow(FINAL_DATA))
quantiles <- quantile(random.numbers, probs = c(0, 1/3, 2/3, 1))
split.labels <- cut(random.numbers, quantiles, include.lowest = T,
                    labels = c("training", "validation", "testing"))
split.data <- split(FINAL_DATA, split.labels)
train.X <- split.data$training[-1]
train.y <- split.data$training[1]
valid.X <- split.data$validation[-1]
valid.y <- split.data$validation[1]
test.X <- split.data$testing[-1]
test.y <- split.data$testing[1]

GetSelectionMethodMse <- function(train.X, train.y, valid.X, valid.y,
                                  test.X, test.y, method = "exhaustive") {
  formula <- as.formula(paste(names(train.y), "~.", sep = ""))
  best.subset.regression <- regsubsets(formula, nvmax = ncol(train.X),
                                       data = cbind(train.X, train.y),
                                       method = method)
	bsr.models <- summary(best.subset.regression)$which
	error <- model <- list()
	error$valid <- error$train <- numeric(nrow(bsr.models))
	for (i in 1:nrow(bsr.models)){
		selected.variables <- bsr.models[i, -1]
		X <- train.X[selected.variables]
		model[[i]] <- lm(formula, data = cbind.data.frame(X, train.y))
		X <- valid.X[selected.variables]
		prediction <- predict(model[[i]], newdata = cbind.data.frame(X))
		error$valid[i] <- mean((prediction - valid.y) ^ 2)
    error$train[i] <- mean((predict(model[[i]]) - train.y) ^ 2)
  }
  prediction <- predict(model[[which.min(error$valid)]],
                        newdata = cbind.data.frame(test.X))
  error$test <- mean((prediction - test.y) ^ 2)
  return(error)
}

GetRidgeMse <- function(train.X, train.y, valid.X, valid.y,
                        test.X, test.y, lambda){
  formula <- as.formula(paste(names(train.y), "~.", sep = ""))
  ridge.regression <- lm.ridge(formula, data = cbind(train.X, train.y),
                               lambda = lambda)
  error <- list()
  error$valid <- error$train <- numeric(length(lambda))
	for (i in 1:length(lambda)){
		prediction <- coef(ridge.regression)[i, ] %*% t(cbind(1, valid.X))
		error$valid[i] <- mean((prediction - valid.y) ^ 2)
    prediction <- coef(ridge.regression)[i, ] %*% t(cbind(1, train.X))
  	error$train[i] <- mean((prediction - train.y) ^ 2)
  }
  prediction <- coef(ridge.regression)[which.min(error$valid), ] %*%
                t(cbind(1, test.X))
  error$test <- mean((prediction - test.y) ^ 2)
  return(error)
}

GetLassoMse <- function(train.X, train.y, valid.X, valid.y,
                        test.X, test.y, bound) {
	formula <- as.formula(paste(names(train.y), "~.",sep = ""))
	lasso <- l1ce(formula, data = cbind(train.X, train.y),
                bound = bound, standardize = FALSE, sweep.out = ~ 1)
	error <- list()
	error$train <- error$valid <- numeric(length(bound))
	for(i in 1:length(bound)){
		prediction <- predict(lasso[i], newdata = cbind(valid.X, valid.y))
		error$valid[i] <- mean((valid.y - prediction) ^ 2)
    error$train[i] <- mean((train.y - predict(lasso[i])) ^ 2)
  }
	prediction <- predict(lasso[which.min(error$valid)],
                        newdata = cbind(test.X, test.y))
	error$test <- mean((test.y - prediction) ^ 2)
	return(error)
}

par(mfrow = c(2, 2))
METHODS <- c("forward", "backward")
comparison.table <- data.frame()
for(i in 1:(length(METHODS))) {
	error <- GetSelectionMethodMse(train.X, train.y, valid.X, valid.y,
                                 test.X, test.y, method = METHODS[i])
  plot(1:length(error$train), error$train, "l", lty = 2,
       lwd = 2, ylim = range(unlist(error)),
       xlab = "Liczba zmiennych", ylab = "MSE",
       main = paste("Regresja", METHODS[i]))
  lines(1:length(error$valid), error$valid, lwd = 2)
  points(which.min(error$valid), min(error$valid),
         cex = 1.5, pch = 19)
  comparison.table <- rbind(data.frame(method = METHODS[i],
                                       test.error = format(error$test),
                                       valid.error = format(min(error$valid)),
                                       train.error = 
                                         format(error$train[which.min(error$valid)]),
                                       stringsAsFactors = FALSE),
                            comparison.table)
}

LAMBDAS <- exp(seq(0, log(500), length.out = 100))
ridge.errors <- GetRidgeMse(train.X, train.y, valid.X, valid.y,
                            test.X, test.y, LAMBDAS)
plot(LAMBDAS, ridge.errors$train, "l", log = "x", lty = 2,
     ylim = range(unlist(ridge.errors)),
     ylab = "MSE", main = "Regresja grzbietowa", lwd = 2)
lines(LAMBDAS, ridge.errors$valid, lwd = 2)
points(LAMBDAS[which.min(ridge.errors$valid)],
       min(ridge.errors$valid), pch = 19, cex = 1.5)
comparison.table <- rbind(c("ridge", format(ridge.errors$test),
                            format(min(ridge.errors$valid)),
                            format(ridge.errors$train[which.min(ridge.errors$valid)])),
                          comparison.table)

BOUNDS <- seq(0.00001, 0.005, length.out = 100)
lasso.errors <- GetLassoMse(train.X, train.y, valid.X, valid.y,
                            test.X, test.y, BOUNDS)
plot(BOUNDS, lasso.errors$train, type = "l", lty = 2, lwd = 2,
     ylim = range(unlist(lasso.errors)),
     log = "x", ylab = "MSE", main = "Regresja LASSO")
lines(BOUNDS, lasso.errors$valid, lwd = 2)
points(BOUNDS[which.min(lasso.errors$valid)], min(lasso.errors$valid),
       pch = 19, cex = 1.5)

print(rbind(c("lasso", format(lasso.errors$test),
              format(min(lasso.errors$valid)),
              format(lasso.errors$train[which.min(lasso.errors$valid)])),
            comparison.table))

# Plik z danymi wejœciowymi do pobrania:
# http://archive.ics.uci.edu/ml/machine-learning-databases/
# housing/housing.data

library(nnet)
set.seed(1)

DATA_SET <- read.table("housing.data")
names(DATA_SET) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE",
                     "DIS", "RAD", "TAX", "PTRATIO", "B", "LSTAT", "MEDV")
DATA_SET <- DATA_SET[-2]
SCALED_DATA <- scale(DATA_SET[-ncol(DATA_SET)])
FINAL_DATA <- cbind(SCALED_DATA, DATA_SET[ncol(DATA_SET)])
TRAIN_PART <- VALID_PART <- 0.4
random.numbers <- sample.int(nrow(FINAL_DATA))
quantiles <- quantile(random.numbers,
                      prob = c(0, TRAIN_PART, TRAIN_PART + VALID_PART, 1))
split.labels <- cut(random.numbers, quantiles, include.lowest = T,
                    labels=c("train", "valid", "test"))
data <- split(FINAL_DATA, split.labels)

NEURONS <- 5
DECAYS <- seq(0, 40, length.out = 100)
wts.parameter <-  2 * runif(NEURONS * ncol(FINAL_DATA) + NEURONS + 1) - 1
train.error <- valid.error <- numeric(length(DECAYS))
neural.nets <- list()
progress.bar <- winProgressBar("Postep w %", "0% zrobione", 0, 1, 0)
for (d in 1:length(DECAYS)){
  neural.nets[[d]] <- nnet(MEDV ~ ., data = data$train, size = NEURONS,
                           decay = DECAYS[d], linout = T, maxit = 10000,
                           trace = FALSE, Wts = wts.parameter)
  train.error[d] <- mean(neural.nets[[d]]$residuals ^ 2)
  prediction <- predict(neural.nets[[d]], newdata = data$valid)
  valid.error[d] <- mean((prediction - data$valid$MEDV) ^ 2)
  percentage <- d / length(DECAYS)
  setWinProgressBar(progress.bar, percentage, "Postep w %",
                    sprintf("%d%% zrobione", round(100 * percentage)))
}
close(progress.bar)

best.neural.net <- neural.nets[[which.min(valid.error)]]
test.prediction <- predict(best.neural.net, newdata = data$test)
best.net.test.error <- mean((test.prediction - data$test$MEDV) ^ 2)

ols <- lm(MEDV ~ ., data = data$train)
ols.train.error <- mean(ols$residuals ^ 2)
prediction <- predict(ols, newdata = data$valid)
ols.valid.error <- mean((prediction - data$valid$MEDV) ^ 2)
prediction <- predict(ols, newdata = data$test)
ols.test.error <- mean((prediction - data$test$MEDV) ^ 2)

plot(DECAYS, train.error, "l", ylim = range(c(train.error, valid.error)),
     lwd = 2, col = "red", xlab = "Parametr decay", ylab = "MSE")
lines(DECAYS, valid.error, "l", col = "blue", lwd = 2)
points(DECAYS[which.min(valid.error)], min(valid.error),
       pch = 19, col = "blue", cex = 1.5)
points(DECAYS[which.min(valid.error)], best.net.test.error,
       pch = 19, col = "green", cex = 1.5)
abline(h = ols.train.error, col = "red", lty = 2)
abline(h = ols.valid.error, col = "blue", lty = 2)
abline(h = ols.test.error, col = "green", lty = 2)
legend("top", lty = c(1, 1, NA, 2, 2, 2), lwd = c(2, 2, NA, 1, 1, 1),
       col = c("red", "blue", "green"), pch = c(NA, NA, 19, NA, NA, NA),
       y.intersp = 0.7, ncol = 2,
       legend = c("Net train", "Net valid", "Net test",
                  "OLS train", "OLS valid", "OLS test"))                                                    

devAskNewPage(ask = TRUE)
par(mfrow = c(4, 3), mar = c(2.5, 2.5, 2, 1))
zeros <- data.frame(matrix(0, ncol = ncol(DATA_SET) - 1, nrow = 100))
names(zeros) <- names(DATA_SET[-ncol(DATA_SET)])  
for(j in 1:ncol(zeros)){
  x.change <- zeros
  x.change[, j] <- seq(-3, 3, length.out = 100)
  prediction <- predict(best.neural.net, newdata = x.change)
  plot(x.change[, j][-100], diff(prediction) / (6 / 99), ylim = c(-10, 10),
       "l", lwd = 2, main = paste(names(DATA_SET)[j]), col = "blue")
  abline(h = 0, lty = 2)
  abline(h = ols$coefficients[j + 1], lty = 2, col = "red", lwd = 2)
}

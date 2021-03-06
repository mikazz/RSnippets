# Plik z danymi wej�ciowymi do pobrania:
# http://archive.ics.uci.edu/ml/machine-learning-databases/
# statlog/australian/australian.dat

library(locfit)
set.seed(1)

DATA_SET <- read.table("australian.dat", header = FALSE, sep = " ")
names(DATA_SET) <- c(paste("A", 1:14, sep = ""), "class")
TRAINING_FRACTION <- 0.5
training.indices <- (sample.int(nrow(DATA_SET)) / nrow(DATA_SET)
                     <= TRAINING_FRACTION)
train.set <- DATA_SET[training.indices, ]
test.set <- DATA_SET[!training.indices, ]

ols.model <- lm(class ~ ., data = train.set)
train.score <- predict(ols.model)
test.score <- predict(ols.model, newdata = test.set)

BANDWIDTHS <- seq(0.3, 2.3, by = 0.02)
DEGREES <- c(1, 2)
models <- list(list(), list())
mse <- matrix(nrow = length(BANDWIDTHS), ncol = length(DEGREES))
for (i in 1:length(DEGREES)) {
	for (j in 1:length(BANDWIDTHS)){
		models[[i]][[j]] <- locfit(train.set$class ~ lp(train.score,
                                                    deg = DEGREES[i],
                                                    nn = BANDWIDTHS[j]),
                               family = "binomial")
		prediction <- predict(models[[i]][[j]],
                          newdata = data.frame(train.score = test.score))
		mse[j,i] <- mean((prediction - test.set$class) ^ 2)
	}
}
plot(0, 0, "n", xlab = "Parametr wyg�adzania span", ylab = "MSE",
     xlim = range(BANDWIDTHS), ylim = range(mse))
for (i in 1:length(DEGREES)) {
  lines(BANDWIDTHS, mse[, i], "l", col = i + 1, lwd = 2)
  points(BANDWIDTHS[which.min(mse[, i])], min(mse[, i]),
         col = i + 1, pch = 19, cex = 1.3)
}
legend("topright", c("liniowa", "kwadratowa"), col = c(2, 3), lwd = 2)
optimal.bandwidth <- ((which.min(mse) - 1) %% length(BANDWIDTHS)) + 1
optimal.degree <- 1 + (which.min(mse) %/% length(BANDWIDTHS))
points(BANDWIDTHS[optimal.bandwidth], min(mse),
       cex = 2, pch = 19, col = optimal.degree + 1)

score <- seq(min(train.score), max(train.score), by = 0.01)
probability <- predict(models[[optimal.degree]][[optimal.bandwidth]],
                       newdata = data.frame(train.score = score))
devAskNewPage(ask = TRUE)
conditional.density <- cdplot(factor(train.set$class) ~ train.score,
                              ylevels = 2:1, plot = FALSE, bw = "ucv")
plot(score, conditional.density[[1]](score), "l",
      xlab = "Warto�� score'u", ylab = "Prawdopodobie�stwo",
      xlim = range(score), ylim = range(score), lwd = 3, lty = 3)
lines(score, probability, "l", col = "red", lwd = 2)
abline(0, 1, col = "blue", lwd = 1, lty = 2)
abline(h = 1, col = "grey")
abline(h = 0, col = "grey")
legend("left", c("prop. g�sto�ci class = 1", "regresja lokalna",
                 "prosta y = x"),
       lty = c(3, 1, 2), lwd = c(3, 2, 1),
       col = c("black", "red", "blue"), bty = "n")


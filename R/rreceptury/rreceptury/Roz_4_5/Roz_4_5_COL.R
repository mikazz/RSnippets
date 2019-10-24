library(nnet)
set.seed(1)

SAMPLE_SIZE <- 200
X <- seq(-2, 2, length.out = SAMPLE_SIZE)
TRUE_Y <- X ^ 2 / 2 + sin(4 * X)
y <- TRUE_Y + 2 * rnorm(SAMPLE_SIZE)

GetBootstrapPrediction <- function(neurons) {
  bootstrap.indices <- sample(SAMPLE_SIZE, replace = T)
  bootstrap.sample.y <- y[bootstrap.indices]
  bootstrap.sample.x <- X[bootstrap.indices]
	bootstrap.model <- nnet(bootstrap.sample.y ~ bootstrap.sample.x, lin = T,
                          size = neurons, trace = FALSE, maxit = 10 ^ 6)
	return(predict(bootstrap.model, data.frame(bootstrap.sample.x = X)))
}
NEURONS <- c(2, 4, 6, 8)
progress.bar <- winProgressBar("Postêp w %", "0% zrobione", 0, 1, 0)
BOOTSTRAP_REPLICATIONS <- 1000
bootstrap.predictions <- bootstrap.average <- vector("list", length(NEURONS))
bootstrap.ci95 <- single.model.prediction <- vector("list", length(NEURONS))
for (i in 1:BOOTSTRAP_REPLICATIONS) {
  for (j in 1:length(NEURONS)) {
	  bootstrap.predictions[[j]] <- cbind(bootstrap.predictions[[j]],
                                        GetBootstrapPrediction(NEURONS[j]))
  }
	percentage <- i / BOOTSTRAP_REPLICATIONS
	setWinProgressBar(progress.bar, percentage, "Postêp w %",
                    sprintf("%d%% zrobione", round(100 * percentage)))
}
close(progress.bar)

bootstrap.mse <- single.model.mse <- numeric(length(NEURONS))
for (i in 1:length(NEURONS)) {
  bootstrap.average[[i]] <- apply(bootstrap.predictions[[i]], 1, mean)
  bootstrap.ci95[[i]] <- apply(bootstrap.predictions[[i]], 1, quantile,
                               probs = c(0.025, 0.975))
  bootstrap.mse[i] <- mean((bootstrap.average[[i]] - TRUE_Y) ^ 2  )
  single.model <- nnet(y ~ X, size = NEURONS[i],
                       linout = T, trace = F, maxit = 10 ^ 6)
  single.model.prediction[[i]] <- predict(single.model)
  single.model.mse[i] <- mean((single.model.prediction[[i]] - TRUE_Y) ^ 2)
}
main <- paste(NEURONS, " neuron", c("y", "y", "ów", "ów"),
              " bag.MSE = ", round(bootstrap.mse, 2),
              ", net.MSE = ", round(single.model.mse, 2), sep = "")
par(mfrow = c(2, 2), mar = c(3, 2, 2, 1))
for (n in 1:length(NEURONS)) {
  plot(X, y,xlim = c(-2, 2), ylim = c(-5, 6), main = main[n])
	lines(X, TRUE_Y, lwd = 4)	
	lines(X, bootstrap.average[[n]], lwd = 3, col = 3)
  lines(X, bootstrap.ci95[[n]][1,], lwd = 1, col = 4)
  lines(X, bootstrap.ci95[[n]][2,], lwd = 1, col = 4)
  lines(X, single.model.prediction[[n]], col = 2, lwd = 3)
}
legend("bottomright", bty = "o",
       leg = c("Teoretyczna", "Pojedyncza sieæ", "Bagging", "95%-CI"),
       lwd = c(3, 3, 3, 1), col = 1:4, y.inter = 0.25, x.inter = 0.25)


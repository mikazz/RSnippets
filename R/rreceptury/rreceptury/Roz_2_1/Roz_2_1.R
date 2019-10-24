set.seed(1)
SIZES <- seq(from = 10, to = 200, by = 10)
REPLICATIONS <- 2 ^ 10
SimulateRSquared <- function(size) {
		x <- rnorm(size)
		y <- x + rnorm(size)
		model <- lm(y ~ x)
		return(summary(model)$r.squared)
}

r.squared.mean <- numeric(length(SIZES))
r.squared.quantile5 <- numeric(length(SIZES))
r.squared.quantile95 <- numeric(length(SIZES))

progress.bar <- winProgressBar("Postêp w %", "0% zrobione", 0, 1, 0)
for (i in 1:length(SIZES)) {
  result <- replicate(REPLICATIONS, SimulateRSquared(SIZES[i]))
	r.squared.mean[i] <- mean(result)
	r.squared.quantile5[i] <- quantile(result, 0.05)
	r.squared.quantile95[i] <- quantile(result, 0.95)
	percentage <- i / length(SIZES)
	setWinProgressBar(progress.bar, percentage, "Postêp w %",
	                  sprintf("%d%% zrobione", round(100 * percentage)))
}
close(progress.bar)

plot(SIZES, r.squared.mean,
     ylim = c(min(r.squared.quantile5), max(r.squared.quantile95)),
     xlab = "wielkoœæ próby", ylab = expression(R^2))
lines(SIZES, r.squared.quantile5)
lines(SIZES, r.squared.quantile95)

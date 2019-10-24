# Plik z danymi wejœciowymi do pobrania:
# http://archive.ics.uci.edu/ml/
# machine-learning-databases/housing/housing.data

set.seed(1)

GetSplitLabels <- function(data.length, proportions) {
	proportioned.labels <- rep(1:length(proportions), proportions)
	labels <- rep(proportioned.labels,len = data.length)
	return(sample(labels, data.length))
}

CV_FOLDS <- 10
SPAN_LEVELS <- seq(from = 0.1, to = 1, length.out = 100)
RAW_DATA_SET <- readLines("housing.data.txt")
LSTAT <- as.numeric(substr(RAW_DATA_SET, 85, 90))
MEDV <- as.numeric(substr(RAW_DATA_SET, 92, 97))
split.labels <- GetSplitLabels(length(LSTAT), rep(1, CV_FOLDS))

sse <- numeric(length(SPAN_LEVELS))
for (fold in 1:CV_FOLDS) {
	training.x <- LSTAT[split.labels != fold]
	training.y <- MEDV[split.labels != fold]
	testing.x <- LSTAT[split.labels == fold]
	testing.y <- MEDV[split.labels == fold]
	for (i in 1:length(SPAN_LEVELS)) {
		model <- loess(training.y ~ training.x, span = SPAN_LEVELS[i],
		               control = loess.control(surface = "direct"))
		prediction <- predict(model, data.frame(training.x = testing.x))
		sse[i] <- sse[i] + sum((prediction - testing.y) ^ 2)
	}
}
optimal.span <- SPAN_LEVELS[which.min(sse)]
model <- loess(MEDV ~ LSTAT, span = optimal.span)

par(mfrow = c(1, 2))
plot(SPAN_LEVELS, sse, pch = 19)
points(optimal.span, sse[which.min(sse)], col = "red", pch = 19)
plot(LSTAT, MEDV, pch = 20)
lines(sort(LSTAT), predict(model)[order(LSTAT)], col = "red", lwd = 3)


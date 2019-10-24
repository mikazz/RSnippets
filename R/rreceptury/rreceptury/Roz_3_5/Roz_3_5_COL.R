# Plik z danymi wejœciowymi do pobrania:
# http://archive.ics.uci.edu/ml/
# machine-learning-databases/statlog/australian/australian.dat

library(ROCR)
set.seed(1)

DATA_SET <- read.table("australian.dat", header = F, sep = " ")
names(DATA_SET) <- c(paste("A", 1:14, sep = ""), "class")
DATA_SET$A4 <- ifelse(DATA_SET$A4 == 1, 0, 1)
DATA_SET$A12 <- ifelse(DATA_SET$A12 == 1, 0, 1)
DATA_SET$A14 <- log(DATA_SET$A14)

TRAINING_FRACTION <- 0.5
training.set.indices <- (sample.int(nrow(DATA_SET)) / nrow(DATA_SET)
                         <= TRAINING_FRACTION)
train.set <- DATA_SET[training.set.indices, ]
test.set <- DATA_SET[!training.set.indices, ]

full.logit <- glm(class ~ ., data = train.set, family = binomial)
BIC.logit <- step(full.logit, k = log(nrow(train.set)), trace = 0)

score.or.class <- gain <- lift <- roc <- auc <- prediction.object <- list()
score.or.class[[1]] <- list(test.set$class, test.set$class)
score.or.class[[2]] <- list(predict(BIC.logit, type = "response"),
                            train.set$class)
score.or.class[[3]] <- list(predict(BIC.logit, new = test.set, "response"),
                            test.set$class)
class.average <- mean(test.set$class)
random.class <- 1
for (i in 1:(nrow(test.set) - 1)) {
	random.class <- c(random.class, mean(random.class) < class.average)
}
score.or.class[[4]] <- list(seq(0, 1, len = nrow(test.set)), random.class)

for (i in 1:length(score.or.class)) {
  prediction.object[[i]] <- prediction(score.or.class[[i]][[1]],
                                       score.or.class[[i]][[2]])
  gain[[i]] <- performance(prediction.object[[i]], "tpr", "rpp")
  lift[[i]] <- performance(prediction.object[[i]], "lift", "rpp")
  roc[[i]] <- performance(prediction.object[[i]], "tpr", "fpr")
  auc[[i]] <- performance(prediction.object[[i]], "auc")
}
LEGEND_LABELS <- c("wizard", "train", "test", "random")
ShowCurve <- function(list, name, AUC = FALSE, legend.position = "right") {
  for (i in 1:length(list)) {
    plot(list[[i]], main = paste("Krzywa", name),
         col = i, lwd = 2, add = (i != 1), xlim = c(0, 1))
    if (AUC) {
      text(.2, 0.9 - i * 0.1, pos = 4, col = i, cex = .9,
           paste("AUC =", round(auc[[i]]@y.values[[1]], digit = 2)))
    }
  }
  legend(legend.position, lty = 1, lwd = 2, col = 1:4, y.intersp = .3,
         legend = LEGEND_LABELS, seg.len = 0.5, bty = "n")
}
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
ShowCurve(gain, "Gain")
ShowCurve(lift, "Lift", legend.position = "topright")
ShowCurve(roc, "ROC", AUC = TRUE)

class0.score.density <- class1.score.density <- list()
max.density <- 0
for(i in 1:(length(prediction.object))) {
	predictions <- prediction.object[[i]]@predictions[[1]]
	labels <- prediction.object[[i]]@labels[[1]]
  class0.score.density[[i]] <- density(predictions[labels == "0"],
                                       kernel =  "epanechnikov", bw = 0.05)
  class1.score.density[[i]] <- density(predictions[labels == "1"],
                                       kernel =  "epanechnikov", bw = 0.05)
	max.density <- max(class0.score.density[[i]]$y,
                     class1.score.density[[i]]$y, max.density)
}   
plot(0, 0, type = "n", xlim = c(-0.1, 1.1), ylim = c(0, max.density),
     xlab = "Score", ylab = "Wartoœæ funkcji gêstoœci",
     main = "Warunkowe funkcje gêstoœci score'u")
for(i in 1:length(prediction.object)) {
    lines(class0.score.density[[i]], col = i, lwd = 2)
    lines(class1.score.density[[i]], col = i, lwd = 2, lty=2)
}   
legend("top", lty = 1, lwd = 2, col=1:4, y.intersp = .3,
         legend = LEGEND_LABELS, seg.len = 0.5, bty = "n")


library(mgcv)
library(ROCR)
library(Ecdat)

set.seed(1)

data(Participation)
LABELS <- factor(rep(c("train", "test"), length = nrow(Participation)))
random.labels <- sample(LABELS)
split.data <- split(Participation, random.labels)

glm.model <- glm(lfp ~ lnnlinc + age,
                 family = binomial, data = split.data$train)
gam.model <- gam(lfp ~ s(lnnlinc) + s(age),
                 family = binomial, data = split.data$train)
glm.prediction <- predict(glm.model, newdata = split.data$test)
gam.prediction <- as.vector(predict(gam.model, newdata = split.data$test))
plot(gam.model, pages = 1)

devAskNewPage(TRUE)
plot(performance(prediction(gam.prediction, split.data$test$lfp),
                 "tpr", "fpr"),
     lwd = 2, lty = 2)
plot(performance(prediction(glm.prediction, split.data$test$lfp),
                 "tpr", "fpr"),
     add = TRUE, lwd = 2, lty = 1)
legend("bottomright", c("GLM", "GAM"),
       lwd = 2, lty = 1:2)

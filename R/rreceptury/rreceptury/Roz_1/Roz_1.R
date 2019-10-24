library(Ecdat)
library(MKmisc)
library(boot)
set.seed(1)

data(Participation)
str(Participation)

GetSingleCoefficient <- function(data.set, indices) {
  single.model <- glm(lfp ~ . + I(age ^ 2), data = data.set[indices, ],
                      family = binomial(link = probit))
  coef(single.model)
}

GetBootstrapInterval <- function(index) {
    boot.ci(coefficient.bootstrap, index = index, type = "perc")$percent[4:5]
}

glm.model <- glm(lfp ~ . + I(age ^ 2), data = Participation,
                 family = binomial(link = probit))
summary(glm.model)
HLgof.test(fitted(glm.model), as.integer(Participation$lfp) - 1)
table(fitted(glm.model) > 0.5, Participation$lfp)
standard.intervals <- confint(glm.model)

coefficient.bootstrap <- boot(Participation, GetSingleCoefficient, 1000)
bootstrap.intervals <- sapply(1:nrow(standard.intervals),
                              GetBootstrapInterval)
                    
pdf("Roz_1.pdf", width = 9, height = 4, encoding="CP1250.enc")
par(mfrow = c(1, 2), mar=c(4.5, 5, 2, 1))
dotchart(coef(glm.model), pch = "|", lcolor = NULL,
         xlim = range(standard.intervals, bootstrap.intervals),
         xlab = "oszacowanie", main = "Przedzia³y ufnoœci oszacowañ")
abline(v = 0, col = "grey90", lty = 2)
for (i in seq_along(coef(glm.model))) {
  lines(standard.intervals[i, ], c(i, i) + 0.05)
  lines(bootstrap.intervals[, i], c(i, i) - 0.05, col = "grey70")
}
legend("topright", c("parametryczny", "bootstrapowy"),
       lty = 1, col = c("black", "grey70"))

prediction.data <- data.frame(lnnlinc = 10, age = seq(2, 6.2, len = 100),
                              educ = 9, nyc = 0, noc = 1, foreign = "yes")
prediction <-  predict(glm.model, newdata = prediction.data, se.fit = TRUE)
lower.bounds <- with(prediction, fit + qnorm(0.025) * se.fit)
upper.bounds <- with(prediction, fit + qnorm(0.975) * se.fit)
probabilities <- pnorm(cbind(prediction$fit, lower.bounds, upper.bounds))
matplot(prediction.data$age, probabilities, type = "l", lty = c(1, 2, 2),
        col = "black", xlab = "age", ylab = "Pr(lfp = yes)",
        main = "Prognoza z 95% przedzia³em ufnoœci")
dev.off()

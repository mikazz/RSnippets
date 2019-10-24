library(graphics)
set.seed(1)
FILE.NAME <- "testRegresji.pdf"
COUNTS <- 2 ^ (3:6)

pdf(FILE.NAME)
par(mfrow = c(2, 2))
for (count in COUNTS) {
	x <- seq(0, 2, length.out = count)
	y <- x + rnorm(count)
	model <- lm(y ~ x)
	xlab.label <- paste("y =", format(model$coeff[1], digits = 4),
                      "+", format(model$coeff[2], digits = 4),
                      "* x + e")
	plot(x, y, xlab = xlab.label, ylab = "", main = paste("n =", count))
	matlines(x, predict(model, interval = "confidence"),
	         type = "l", lty = c(1, 2, 2), col = "red")
	abline(0, 1 , col = "blue", lwd = 2)
}
dev.off()
shell.exec(paste(getwd(), "/", FILE.NAME, sep = ""))


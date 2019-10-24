# Plik z danymi wejœciowymi do pobrania:
# http://shazam.econ.ubc.ca/student/ramu/DATA4-12

DATA_SET <- read.table("DATA4-12.txt")

OptimizeMfrow <- function(elements) {
	columns <- ceiling(sqrt(elements))
	rows <- ifelse(columns * (columns - 1) < elements, columns, columns - 1)
	return(c(rows, columns))
}

DoHistogram <- function(values, values.name) {
	histogram <- hist(values, plot = FALSE)
	density.estimate <- density(values)
	y.maximum <- max(histogram$density, density.estimate$y)
	plot(histogram, freq = FALSE, ylim = c(0, y.maximum), 
	     xlab = values.name, ylab = "gêstoœæ", main = NULL)
	lines(density.estimate, lwd = 2)
}

DoScatterplot <- function(x.values, x.name) {
	plot(x.values, DATA_SET$MORT,
       xlab = x.name, ylab = "MORT", main = NULL, col = gray(0.4))
	lines(smooth.spline(x.values, DATA_SET$MORT), lwd = 2)
	abline(lm(DATA_SET$MORT ~ x.values)$coef, col = gray(0.7), lwd = 2, lty = 2)
}
names(DATA_SET) <- c("MORT", "INCC", "POV", "EDU1", "EDU2", "ALCC",
                     "TOBC", "HEXC", "PHYS", "URB", "AGED")

cat("Nazwy zmiennych:\n", names(DATA_SET))
cat("\n\nPodstawowe statystyki opisowe:\n")
print(summary(DATA_SET))
cat("\nMacierz korelacji:\n")
print(cor(DATA_SET), digits = 1)

par(mfrow = OptimizeMfrow(ncol(DATA_SET)),  mar = c(5, 4, 1, 1))
invisible(mapply(DoHistogram, DATA_SET, names(DATA_SET)))

devAskNewPage(ask = TRUE)
par(mfrow = OptimizeMfrow(ncol(DATA_SET) - 1),  mar = c(5, 4, 1, 1))
invisible(mapply(DoScatterplot, DATA_SET[-1], names(DATA_SET[-1])))
plot.new()
plot.new()
legend("left", c("dane", "liniowy", "wyg³adzany"), bty = "n",
       col = c(gray(0.4), gray(0.7), "black"), pch = c(1, -1, -1),
       lty = c(-1, 2, 1), lwd = c(-1, 2, 2))

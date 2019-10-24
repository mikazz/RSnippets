# Plik z danymi wejœciowymi do pobrania:
# http://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data

RAW_DATA_SET <- read.table("car.data.txt", sep = ",")
names(RAW_DATA_SET) <- c("buying", "maint", "doors", "persons",
                         "lug_boot", "safety", "car.ok")
LEVELS <- c("vhigh", "high", "med", "low")
DATA_SET <- transform(RAW_DATA_SET, car.ok = factor(car.ok != "unacc"),
                      safety = ordered(safety, LEVELS[-1]),
                      buying = ordered(buying, LEVELS),
                      maint = ordered(maint, LEVELS))
print(summary(DATA_SET))

CalculateProportions <- function(data.set, variable.name) {
	round(100 * prop.table(table(data.set[variable.name])), digits = 2)
}

par(mfrow = c(2, 3), ps = 18, mex = .7)
GREY_LEVELS <- c(99, 66, 33, 0)
GREY_COLORS <- paste("grey", GREY_LEVELS, sep = "")
for (name in names(DATA_SET)[1:6]) {
	variable.name <- parse(text = name)
	cat("\n", rep("=", 60), "\nVariable: ", name, sep = "")
	count.table <- with(DATA_SET, table(car.ok, eval(variable.name)))
	print(100 * prop.table(count.table, 1), digits = 4)
	cat("---\n")
	print(by(DATA_SET, DATA_SET$car.ok, CalculateProportions, name))
	plot(100 * prop.table(count.table, 1), col = GREY_COLORS, main = name)
}

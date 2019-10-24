# Plik z danymi wejœciowymi do pobrania:
# http://www.nber.org/data/industrial-production-index/ip-sectors.xls
library(XLConnect)

FILE_NAME <- "ip-sectors.xls"
WORKBOOK <- loadWorkbook(FILE_NAME)
DATA_SET <- readWorksheet(WORKBOOK, getSheets(WORKBOOK))

CalculateReturns <- function(variable) {
  return(diff(variable) / variable[-length(variable)])
}
attr(CalculateReturns, "name") <- "arytmetyczna"

CalculateLogReturns <- function(variable) {
  return(diff(log(variable)))
} 
attr(CalculateLogReturns, "name") <- "logarytmiczna"
RETURNS_FUNCTIONS <- c(CalculateReturns, CalculateLogReturns)

par(mfrow = c(2, 2), mex = .7)
RAW_DATA <- DATA_SET[, -1]

for (returns.function in RETURNS_FUNCTIONS) {
  flat.data <- stack(data.frame(apply(RAW_DATA, 2, returns.function)))
  names(flat.data) <- c("ip", "industry")	
	means <- with(flat.data, tapply(ip, industry, mean))
	standard.deviations <- with(flat.data, tapply(ip, industry, sd))
	plot(means, standard.deviations, pch = 15, xlab = "œrednia",
	     ylab = "odchylenie standardowe",
       main = paste(attr(returns.function, "name"), "/ p³aska"))
	text(means, standard.deviations, levels(flat.data$industry),
       pos = c(3, 4, 4, 4, 2, 4, 4))
	means <- apply(sapply(RAW_DATA, returns.function), 2, mean)
	standard.deviations <- apply(sapply(RAW_DATA, returns.function), 2, sd)
	plot(means, standard.deviations, pch = 15, xlab = "œrednia",
	     ylab = "odchylenie standardowe",
       main = paste(attr(returns.function, "name"), "/ surowa"))
	text(means, standard.deviations, names(RAW_DATA),
       pos = c(4, 4, 4, 4, 3, 4, 2))
}

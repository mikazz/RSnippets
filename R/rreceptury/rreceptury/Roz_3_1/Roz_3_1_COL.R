# Pliki z danymi wejœciowymi do pobrania:
# http://kdd.ics.uci.edu/databases/tic/dictionary.txt
# http://kdd.ics.uci.edu/databases/tic/ticdata2000.txt

library(ROCR)
set.seed(1)

LINES <- readLines("dictionary.txt")
SELECTED_LINES <- LINES[4:89]
LIST_OF_STRING_VECTORS <- strsplit(SELECTED_LINES, split = " ")
GetSecondElement <- function(vector) {
  return(vector[2])
}
VARIABLE_NAMES <- sapply(LIST_OF_STRING_VECTORS, GetSecondElement)

RAW_DATA_SET <- read.delim("ticdata2000.txt", header = F)
names(RAW_DATA_SET) <- VARIABLE_NAMES
DATA_SET <- RAW_DATA_SET[, c(-1, -5)]

LABELS <- rep(rep(c("training", "validation"), c(3, 2)), len = nrow(DATA_SET))
observation.type <- factor((sample(LABELS, nrow(DATA_SET))))
splitted.data.set <- split(DATA_SET, observation.type)

MINIMUM_LEVEL <- 0.000001
selected.variables <- ncol(DATA_SET)
for (i in 1:(ncol(DATA_SET) - 1)) {
	if (cor.test(splitted.data.set$training$CARAVAN,
               splitted.data.set$training[, i])$p.value < MINIMUM_LEVEL)
		  selected.variables <- c(selected.variables, i)
}

predictions <- prediction.object <- roc  <- model <- list()
legend.label <- auc <- NULL
NAMES <- c("pe³ny", "selekcja")
model[[1]] <- glm(CARAVAN ~ ., family = "binomial",
                  data = splitted.data.set$training)
model[[2]] <- glm(CARAVAN ~ ., family = "binomial",
                  data = splitted.data.set$training[, selected.variables])

pdf("corVarSelect.pdf", encoding="CP1250.enc")
for (i in 1:length(model)) {
	predictions[[i]] <- predict(model[[i]], new = splitted.data.set$validation)
	prediction.object[[i]] <- prediction(predictions[[i]],
                                       splitted.data.set$validation$CARAVAN)
	roc[[i]] <- performance(prediction.object[[i]], "tpr", "fpr")
	auc[i] <- attr(performance(prediction.object[[i]], "auc"), "y.values")
	legend.label[i] <- paste(NAMES[i], "(AUC=", format(auc[i], digits = 4), ")",
                           sep = "")
	plot(roc[[i]], add = (i != 1), col = i + 1)
}
legend("bottomright", legend.label, col = 1 + (1:length(model)),
       title = "Modele", lty = 1)
dev.off()


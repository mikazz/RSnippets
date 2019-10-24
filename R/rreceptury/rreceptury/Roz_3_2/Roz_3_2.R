set.seed(1)
NUMBER_OF_OBSERVATIONS <- 128
NUMBER_OF_CLASSIFIERS <- 1024

VALIDATION_DATA <- rep(c(0, 1), NUMBER_OF_OBSERVATIONS / 2)
TEST_DATA <- rep(c(0, 1), NUMBER_OF_OBSERVATIONS / 2)

GetClassifierAccuracy <- function(classifier.id, data) {
	prediction <- rbinom(length(data), 1, 0.5)
	return(mean(prediction == data))
}

validation.data.accuracies <- sapply(1:NUMBER_OF_CLASSIFIERS,
                                     GetClassifierAccuracy,
                                     data = VALIDATION_DATA)
validation.data.best.classifier <- which.max(validation.data.accuracies)

cat("Rozk³ad trafnoœci na zbiorze walidacyjnym:\n")
print(summary(validation.data.accuracies))
cat("Trafnoœæ najlepszego klasyfikatora na zbiorze testowym:",
    GetClassifierAccuracy(validation.data.best.classifier, TEST_DATA),
    "\n")

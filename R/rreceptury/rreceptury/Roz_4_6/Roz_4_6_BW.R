# Plik z danymi wejœciowymi do pobrania:
# http://shazam.econ.ubc.ca/student/ramu/DATA4-12

library(cluster)
library(car)
set.seed(1)

REPLICATIONS <- 100
DATA_SET <- read.table("DATA4-12.txt")
SCALED_DATA <- data.frame(scale(DATA_SET))
names(SCALED_DATA) <- c("MORT", "INCC", "POV", "EDU1", "EDU2", "ALCC",
                        "TOBC", "HEXC", "PHYS", "URB", "AGED")

GetBestKmeans <- function(data.set, number.of.clusters) {
	minimum.total.within.sum.of.squares <- Inf
	for (i in 1:REPLICATIONS) {
		kmeans.model <- kmeans(data.set, number.of.clusters)    
		if (kmeans.model$tot.withinss < minimum.total.within.sum.of.squares) {
			best.kmeans.model <- kmeans.model
			minimum.total.within.sum.of.squares <- best.kmeans.model$tot.withinss
		}
	}
	return(best.kmeans.model)
}

dissimilarity.matrix <- daisy(SCALED_DATA)
kmeans.models <- list()
par(mfrow = c(2, 2), mar = c(5, 4, 2, 2))
for (i in 1:4) {
	kmeans.models[[i]] <- GetBestKmeans(SCALED_DATA, i + 1)
	plot(silhouette(kmeans.models[[i]]$cluster, dissimilarity.matrix),
       main = "", do.clus.stat = F)
}

devAskNewPage(ask = TRUE)
pca <- princomp( ~ ., data = SCALED_DATA, cor = F)
pca.scores <- pca$scores[, 1:2]
pca.scores.dissimilarity.matrix <- daisy(pca.scores)
pca.kmeans.models <- list()
par(mfrow = c(2, 2), mar = c(5, 4, 2, 2))
for (i in 1:4) {
	pca.kmeans.models[[i]] <- GetBestKmeans(pca.scores, i + 1)
	plot(silhouette(pca.kmeans.models[[i]]$cl, pca.scores.dissimilarity.matrix),
       main = "", do.clus.stat = F)
}

labels <- recode(kmeans.models[[3]]$cl,
                 paste(order(kmeans.models[[3]]$size), 1:4,
                       sep = "=", collapse = ";"))
pca.labels <- recode(pca.kmeans.models[[3]]$cl,
                     paste(order(pca.kmeans.models[[3]]$size),
                           1:4, sep="=", collapse=";"))
par(mfrow = c(1, 2))
plot(pca.scores, pch = labels, lwd = 1 + (labels != pca.labels) * 2)
plot(pca.scores, pch = pca.labels, lwd = 1 + (labels != pca.labels) * 2)
print(table(labels, pca.labels))

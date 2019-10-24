set.seed(1)

DoDummyVariables <- function(variable, function.number = 1,
                             dummy.name = deparse(substitute(variable)),
                             separator = ".") {
	functions <- list()
	functions[[1]] <- function(factor) {
		final.data.frame <- data.frame(factor)
		for (level in levels(final.data.frame[, 1])) {
			final.data.frame[, level] <- as.integer(factor == level)
		}
		return(final.data.frame)
	}
	functions[[2]] <- function(factor) {
		rep.factor <- rep(factor, times = length(levels(factor)))
		rep.levels <- rep(levels(factor), each = length(factor))
		result <- unstack(data.frame(dummy = as.integer(rep.factor == rep.levels),
                                 rep.levels),
                      dummy ~ rep.levels)
		return(data.frame(factor, result))
	}
	functions[[3]] <- function(factor) {
    CheckSingleFactor <- function(single.factor) {
      return(as.integer(single.factor == levels(single.factor)))
    }
		result <- t(sapply(factor, CheckSingleFactor))
		return(data.frame(factor, result))
	}
	functions[[4]] <- function(factor) {
		x <- rep(factor, times = length(levels(factor)))
		time <- factor(rep(levels(factor), each = length(factor)))
		id <- factor(rep(seq(along.with = factor),
                     times = length(levels(factor))))
		long.data <- data.frame(factor, dummy = as.integer(x == time),
                            time, id)
		return(reshape(long.data, v.names = "dummy", direction = "wide")[, -2])
	}
	functions[[5]] <- function(factor) {
		final.data.frame <- data.frame(factor)
		for (level in levels(final.data.frame[, 1])) {
			for(i in seq(along.with = factor)) {
				final.data.frame[i, level] <- as.integer(factor[i] == level)
			}
		}
		return(final.data.frame)
	}
	final <- functions[[i]](factor(variable))
	colnames(final) <- c(dummy.name, paste(dummy.name, levels(final[, 1]),
                                         sep = separator))
	return(final)
}

variable <- sample(factor(c("A", "B", "C", "D")), 20000, replace = TRUE)
for (i in 1:5) {
	cat("Time", i, ":", system.time(DoDummyVariables(variable, i))[3], "\n")
}

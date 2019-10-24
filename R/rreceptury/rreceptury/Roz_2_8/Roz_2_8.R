FormatFile <- function(in.file) {
	Embrace <- function (line.number) {
		return (paste("[", line.number, "]", sep = ""))
	}

	FormatLine <- function(line) {
		line.number <<- line.number + 1
		return(paste(format(Embrace(line.number), width = max.width),
                 gsub("\t", "  ", line)))
	}

	lines <- readLines(in.file)
  out.file <- paste(in.file, "f", sep = "")
	max.width <- nchar(Embrace(length(lines)))
	line.number <- 0
	output <- sapply(lines, FormatLine)
	writeLines(output, out.file)
	return(out.file)
}

r.files <- list.files(pattern = glob2rx("*.R"), recursive = T)
sapply(r.files, FormatFile)

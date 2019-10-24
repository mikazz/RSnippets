temp <- c(5,7,6,4,8)
barplot(temp, main="By default")

#barplot(temp, col="coral", main="With coloring")
"Hex Coloring"
barplot(temp, col="#c00000", main="#c00000")


barplot(temp, col="#AA4371", bg="#1c1616", main="#AA4371")

par(bg="#1c1616")
plot(rnorm(100))
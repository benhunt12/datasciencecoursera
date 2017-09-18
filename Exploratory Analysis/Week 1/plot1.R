plot1 <- function(real){
  png(filename = "plot1.png",height = 480, width = 480)
  hist(real$gapower, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
  dev.off()
}

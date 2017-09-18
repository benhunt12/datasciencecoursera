plot2 <- function(real){
  png(filename = "plot2.png",height = 480, width = 480)
  plot(data$realtime,data$gapower, type="l", xlab = "", ylab="Global Active Power (kilowatts)")
  dev.off()
}
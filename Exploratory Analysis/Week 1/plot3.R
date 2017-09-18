plot3 <- function(real){
  png(filename = "plot3.png",height = 480, width = 480)
  plot(real$x,real$sub1, type="n", xlab = "", ylab = "Energy sub metering")
  lines(real$x,real$sub1, col = "black")
  lines(real$x,real$sub2, col = "red")
  lines(real$x,real$sub3, col = "blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = "solid")
  dev.off()
}
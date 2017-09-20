plot5 <- function(){
  ## assuming you're in the correct directory, read NEI/SCC file
  NEI <- readRDS("summarySCC_PM25.rds")
  
  ## get the data from Baltimore and car data
  baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
  
  ag <- aggregate(Emissions ~ year, baltimore, sum)
  
  ## create plot
  png("plot5.png")
  p <- ggplot(ag, aes(year, Emissions))
  p <- p + geom_point() + theme_bw() + geom_line() + xlab("Year") + ylab("PM2.5 Emissions (in tons)") + ggtitle("Emissions From Motor Vehicles in Baltimore ")
  print(p)
  dev.off()
}
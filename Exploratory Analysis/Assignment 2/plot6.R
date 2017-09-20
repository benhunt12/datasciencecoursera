## there is a large space between the two lines simply because the emission
## levels in LA are much, much higher than those Baltimore

## the red line is the same data in plot5.png, it's just compressed for to account
## for the larger range on the y-axis

plot6 <- function(){
  ## assuming you're in the correct directory, read NEI/SCC file
  NEI <- readRDS("summarySCC_PM25.rds")
  
  ## get the data from Baltimore and car data
  baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
  agBalt <- aggregate(Emissions ~ year, baltimore, sum)
  
  ## get the data from Los Angeles and car data
  los <- subset(NEI, fips == "06037" & type == "ON-ROAD")
  agLA <- aggregate(Emissions ~ year, los, sum)
  
  ## create plot
  png("png6.png")
  p <- ggplot(agBalt, aes(year)) +
    geom_line(aes(y = Emissions), colour = "red") +
    geom_line(data = agLA, aes(y = Emissions), colour = "green") +
    theme_bw() +
    xlab("Year") + ylab("PM2.5 Emissions (in tons)") + 
    ggtitle("Emissions From Motor Vehicles in Baltimore(RED) and Los Angeles(GREEN)")
  print(p)
  dev.off()
  
  
}
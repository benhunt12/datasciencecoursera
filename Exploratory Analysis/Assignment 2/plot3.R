## based on the graphs, you can see that all types of sources has seen 
## decreases in PM2.5 except for the type "POINT" which have seen
## increases

plot3 <- function(){
  ## assuming you're in the correct directory, read NEI file
  NEI <- readRDS("summarySCC_PM25.rds")
  
  ## get the data from Baltimore
  baltimore <- subset(NEI, fips == "24510")
  
  ## subset data
  ag <- aggregate(Emissions ~ year + type, baltimore, sum)
  
  png("plot3.png")
  ## plot subsetted data, labeling axis and setting name arguements for the years
  p <- ggplot(ag, aes(year, Emissions, col = type))
  p <- p + geom_point() + geom_line() + theme_bw() + ggtitle("Baltimore Emissions by Year and Type")
  print(p)
  dev.off()
}
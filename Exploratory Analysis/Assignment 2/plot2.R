plot2 <- function(){
  ## assuming you're in the correct directory, read NEI file
  NEI <- readRDS("summarySCC_PM25.rds")
  
  ## get the data from Baltimore
  baltimore <- subset(NEI, fips == "24510")
  
  ## subset data
  ag <- aggregate(Emissions ~ year, baltimore, sum)
  
  png("plot2.png")
  ## plot subsetted data, labeling axis and setting name arguements for the years
  barplot(ag$Emissions,ag$year, main = "Total PM2.5 in Baltimore Emissions By Year", xlab = "Years", ylab = "PM2.5 Emissions (in tons)", names.arg = c("1999","2002","2005","2008"))
  dev.off()
}
plot1 <- function(){
  ## assuming you're in the correct directory, read NEI file
  NEI <- readRDS("summarySCC_PM25.rds")
  
  ## subset data
  ag <- aggregate(Emissions ~ year, NEI, sum)
  
  png("plot1.png")
  ## plot subsetted data, labeling axis and setting name arguements for the years
  barplot(ag$Emissions,ag$year, main = "Total PM2.5 Emissions By Year", xlab = "Years", ylab = "PM2.5 Emissions (in tons)", names.arg = c("1999","2002","2005","2008"))
  dev.off()
}

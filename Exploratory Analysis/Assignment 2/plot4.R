plot4 <- function(){
  ## assuming you're in the correct directory, read NEI/SCC file
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ## combine the two data by the SCC code
  merge <- merge(NEI,SCC, by ="SCC")
  
  ## get all instances of the string "coal"
  coal <- grepl("coal", merge$Short.Name)
  
  ## subset the data based on the presence of "coal"
  newCoal <- subset(merge, coal)
  
  ## aggregate data
  ag <- aggregate(Emissions ~ year, newCoal, sum)
  
  ## create png file and print graph
  png("plot4.png")
  p <- ggplot(ag, aes(year, Emissions))
  p <- p + geom_point() + theme_bw() + geom_line() + xlab("Year") + ylab("PM2.5 Emissions (in tons)") + ggtitle("Emissions Due to Coal Combustion")
  print(p)
  dev.off()
}
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

by_year <- filter(NEI,fips == "24510") %>% group_by(year,type) 
sum_by_year <- summarise(by_year,Emissions = sum(Emissions),na.rm = TRUE)

## build plot
qplot(year,Emissions, data = sum_by_year, color = type, main = "PM 2.5 Emissions over time for Baltimore City by type",geom = c("point","line"))

dev.copy(png, file = "./plot3.png", height = 480, width = 480) ## copy to .png
dev.off() ## Close PNG device
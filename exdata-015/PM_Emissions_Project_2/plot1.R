library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

by_year <- group_by(NEI,year) 
sum_by_year <- summarise(by_year,Emissions = sum(Emissions),na.rm = TRUE)

## build plot
plot(sum_by_year$year,sum_by_year$Emissions,type = "b", xlab = "year", ylab = "total emissions", main = "PM 2.5 Emissions over time" )

dev.copy(png, file = "./plot1.png", height = 480, width = 480) ## copy to .png
dev.off() ## Close PNG device
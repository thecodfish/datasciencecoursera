library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedNEI = merge(NEI,SCC,by.x = "SCC", by.y = "SCC", all = TRUE)

by_year <- filter(mergedNEI,EI.Sector == c("Mobile - On-Road Diesel Heavy Duty Vehicles","Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Gasoline Light Duty Vehicles")) %>% filter(fips == c("24510","06037")) %>% group_by(year,fips) 
sum_by_year <- summarise(by_year,Emissions = sum(Emissions),na.rm = TRUE)

## build plot
qplot(year,Emissions, data = sum_by_year, color = fips, main = "PM 2.5 Emissions over time for motor vehicles in Baltimore City (24510) vs. LA County (06037)",geom = c("point","line"))
                                                                                                                                                                                                                                                    
dev.copy(png, file = "./plot6.png", height = 480, width = 700) ## copy to .png
dev.off() ## Close PNG device
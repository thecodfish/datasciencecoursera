library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedNEI = merge(NEI,SCC,by.x = "SCC", by.y = "SCC", all = TRUE)

by_year <- filter(mergedNEI,EI.Sector == c("Fuel Comb - Comm/Institutional - Coal","Fuel Comb - Electric Generation - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal")) %>% group_by(year,EI.Sector) 
sum_by_year <- summarise(by_year,Emissions = sum(Emissions),na.rm = TRUE)

## build plot
qplot(year,Emissions, data = sum_by_year, color = EI.Sector, main = "PM 2.5 Emissions over time for coal related sources",geom = c("point","line"))

dev.copy(png, file = "./plot4.png", height = 480, width = 600) ## copy to .png
dev.off() ## Close PNG device
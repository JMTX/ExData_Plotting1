#load usefull library
library(sqldf)
library(lubridate)

#--------------------------------------------------------------
#step 1: read the data
#
#Note : fill first the project_rep variable with the path 
#       of the rep where you unzipped the dataset zip file
#--------------------------------------------------------------
#go to the dataset rep 
#fill first the project_rep variable with the path of the rep where you unzipped the dataset zip file
project_rep ="."
dataset_rep = paste(project_rep,"/exdata_data_household_power_consumption",sep="")
setwd(dataset_rep)

#read the dataset but only the obs with a date between 1/2/2007 and 2/2/2007 
data_1 <- read.csv.sql(file="household_power_consumption.txt",sep=";", 
                       sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", eol = "\n")

#------------------------------------------------------------------------------------
# step 2: plot the histogram in a png file

#Note: I tested different color for the graph but I dont think I found the correct one
#-------------------------------------------------------------------------------------
#open png device
png(filename = "plot1.png", width = 480, height = 480,
    pointsize = 12, bg = "white",  res = NA)
#write the histogram in "plot1.png"
hist(data_1$Global_active_power,col="orangered",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")#col="firebrick1")
#close png device
dev.off()
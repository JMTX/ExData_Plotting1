#load usefull library
library(sqldf)
library(lubridate)
library(dplyr)

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

#-----------------------------------------------------------------------------------
#step 2: convert some str into date format 
#-----------------------------------------------------------------------------------

#convert the Date of type str in type Date
data_1$Date<-dmy(data_1$Date)

#build a variable time_test to take into account the day and the time
time_test<-strptime(x=paste(data_1$Date,data_1$Time),format="%Y-%m-%d %H:%M:%S")

#---------------------------------------------------------------------------------
#step 3: plot the graph into a png file 
#---------------------------------------------------------------------------------

#change the language of the Date to have it in english
Sys.setlocale("LC_TIME", "C")

#open png device
png(filename = "plot2.png", width = 480, height = 480,
    pointsize = 12, bg = "white",  res = NA)

#plot the graph
plot(time_test,data_1$Global_active_power, type="o",pch="",
     xlab="",ylab="Global Active Power (kilowatts)")

#close png device
dev.off()
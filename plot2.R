plot2<-function(){
        
        wd<-getwd()
        setwd("consumption")
        
        #load data
        consumption<-read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
        
        #transform column to dates
        consumption$Date<-as.Date(consumption$Date, format="%d/%m/%Y")
        
        #find desired time period
        select<-consumption[consumption$Date=="2007/02/01" | consumption$Date=="2007/02/02",]
        
        #combine Date and Time column
        select$DateTime<-paste(select$Date, select$Time, sep=" ")
        
        select$y<- strptime(select$DateTime,  "%Y-%m-%d %H:%M:%S")
        
        #load data for that period
        select$x<-select$Global_active_power
        
        #open png file
        png("plot2.png", width = 480, height = 480)
        
        #create graph
        Sys.setlocale("LC_ALL","C")
        plot(select$y, select$x, ylab="Global Active Power (kilowatts)", xlab="", type='l')
        
        #close png
        dev.off()
        setwd(wd)
}
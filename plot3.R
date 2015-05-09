plot3<-function(){
        
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
        select$x1<-select$Sub_metering_1
        select$x2<-select$Sub_metering_2
        select$x3<-select$Sub_metering_3
        
        #open png file
        png("plot3.png", width = 480, height = 480)
        
        #create graph
        Sys.setlocale("LC_ALL","C")
        plot(select$y, select$x1, type='n', ylab="Energy sub metering", xlab="")
        lines(select$y, select$x1)
        lines(select$y, select$x2, col='red')
        lines(select$y, select$x3, col='blue')
        legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering 2", "Sub_metering_3"))
        
        #close png
        dev.off()
        setwd(wd)
}


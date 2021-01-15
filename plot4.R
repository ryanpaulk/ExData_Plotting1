library(data.table)
library(dplyr)
hpc <- fread("household_power_consumption.txt", na.strings = "?")
View(hpc)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

feb <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")
if (!file.exists("febset.txt")) {
  fwrite(feb, file = "febset.txt")
}
febset <- fread("febset.txt")
febset <- mutate(febset, datetime = as.POSIXct(paste(febset$Date, febset$Time)))
if (!file.exists("plot4.png")) {
  png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
  ##plot1
  plot(febset$datetime, febset$Global_active_power, type = "l", xlab = "", 
       ylab = "Global Active Power")
  ##plot2
  plot(febset$datetime, febset$Voltage, type = "l", xlab = "datetime",
       ylab = "Voltage")

  ##plot3
  plot(febset$datetime, febset$Sub_metering_1, type = "l", col = "black", xlab = "",
       ylab = "Energy sub meeting")
  lines(febset$datetime, febset$Sub_metering_2, col = "red", type = "l", xlab = "",
        ylab = "Energy sub meeting")
  lines(febset$datetime, febset$Sub_metering_3, col = "blue", type = "l", xlab = "",
        ylab = "Energy sub meeting")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = c(1,1), lwd = c(1,1), bty = "n")
  
  ##plot4
  plot(febset$datetime, febset$Global_reactive_power, type = "l", xlab = "datetime",
       ylab = "Global_ractive_power")
  
  dev.off()
}

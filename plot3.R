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
if (!file.exists("plot3.png")) {
  png("plot3.png", width = 480, height = 480)
  
plot(febset$datetime, febset$Sub_metering_1, type = "l", col = "black", xlab = "",
     ylab = "Energy sub meeting")
lines(febset$datetime, febset$Sub_metering_2, col = "red", type = "l", xlab = "",
     ylab = "Energy sub meeting")
lines(febset$datetime, febset$Sub_metering_3, col = "blue", type = "l", xlab = "",
     ylab = "Energy sub meeting")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = c(1,1), lwd = c(1,1))
dev.off()
}
  
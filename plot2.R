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

if (!file.exists("plot2.png")) {
  png("plot2.png", height = 480, width = 480)

plot(febset$datetime, febset$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
}
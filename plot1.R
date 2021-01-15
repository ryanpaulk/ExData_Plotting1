library(data.table)
hpc <- fread("household_power_consumption.txt")
View(hpc)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
feb <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")
if (!file.exists("febset.txt")) {
  fwrite(feb, file = "febset.txt")
}
febset <- fread("febset.txt")

if (!file.exists("plot1.png")) {
  png("plot1.png", width = 480, height = 480)
  hist(febset$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
  dev.off()
}
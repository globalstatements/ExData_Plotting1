
# Read input data with 1,442 days
allpowerdata <- read.csv("household_power_consumption.txt",
                         sep=";", na.strings="?")
# Subset with 2 days, February 1-2, 2007
the_days_str <- c("1/2/2007", "2/2/2007")
the_days_rows <- as.character(allpowerdata$Date) %in% the_days_str
powerdata <- allpowerdata[the_days_rows, ]

# Convert date and time to POSIXlt
powerdata$ndatetime <- strptime(
  paste(powerdata$Date, powerdata$Time, sep=" "),
  format="%d/%m/%Y %H:%M:%S")

# Open PNG file for output
png("plot4.png", width=480, height=480)
# Panels for 4 plots
# all are point-to-point line graphs with time in x axis
par(mfrow = c(2, 2))
# Row 1, left
# PGlobal active power 
plot(x=powerdata$ndatetime, y=powerdata$Global_active_power,
     type="l", main="", xlab="",
     ylab="Global Active Power")
# Row 1, right
# Voltage
plot(x=powerdata$ndatetime, y=powerdata$Voltage,
      type="l", main="", xlab="datetime",
      ylab="Voltage")
     
# Row 2, left
# Multiple submeters
plot(x=powerdata$ndatetime, y=powerdata$Sub_metering_1,
     type="l", main="", xlab="",
     ylab="Energy sub metering")
lines(x=powerdata$ndatetime, y=powerdata$Sub_metering_2,
      col="red")
lines(x=powerdata$ndatetime, y=powerdata$Sub_metering_3,
      col="blue")
legend("topright", bty="n", lwd=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2",
                "Sub_metering_3"))
# Row 2, right
# Global_reactive_power
plot(x=powerdata$ndatetime, y=powerdata$Global_reactive_power,
     type="l", main="", xlab="datetime",
     ylab="Global_reactive_power")
     

# Close output
dev.off()


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
png("plot3.png", width=480, height=480)
par(mfrow = c(1, 1))

# Multiple time-flow point-to-point line graphs for submeters
plot(x=powerdata$ndatetime, y=powerdata$Sub_metering_1,
     type="l", main="", xlab="",
     ylab="Energy sub metering")
lines(x=powerdata$ndatetime, y=powerdata$Sub_metering_2,
      col="red")
lines(x=powerdata$ndatetime, y=powerdata$Sub_metering_3,
      col="blue")
legend("topright", lwd=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2",
                "Sub_metering_3"))
# Close output
dev.off()

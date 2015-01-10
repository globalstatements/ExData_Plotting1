
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
png("plot2.png", width=480, height=480)
par(mfrow = c(1, 1))

# Time-flow point-to-point line graph of global active power
plot(powerdata$ndatetime, powerdata$Global_active_power,
     type="l", main="", xlab="",
     ylab="Global Active Power (kilowatts)")
# Close output
dev.off()

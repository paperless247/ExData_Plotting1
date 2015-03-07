# ExData Project 1

# load the data, then subset data from the dates 2007-02-01 and 2007-02-02
d  <- read.table("household_power_consumption.txt", header = TRUE, sep=";")
df <- d[as.Date(d$Date, "%d/%m/%Y") %in% as.Date(c("2007-02-01", "2007-02-02")), ]

# combine Date and Time and convert to datetime class
df$datetime <-strptime(paste(df$Date, df$Time), "%d/%m/%Y %T")

# convert other variables to numbers
# missing values coded as "?" are forced to become NA
for(v in names(df)[3:9]){
  df[[v]] <- as.numeric(as.character(df[[v]]))
}

# plot4: 2 by 2
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfcol = c(2, 2))

## 1
with(df, {
  plot(datetime, Global_active_power, type = "n",
       xlab = NA, ylab = "Global Active Power (kilowatts)")
  lines(datetime, Global_active_power)
})

## 2
with(df, {
  plot(datetime, Sub_metering_1,
       xlab = NA, ylab ="Energy sub metering", type = "n")
  lines(datetime, Sub_metering_1, col = "black")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
})
legend("topright", bty = "n", lty = c(1,1,1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

## 3
with(df, {
  plot(datetime, Voltage, type = "n",
       xlab = NA, ylab = "Voltage (V)")
  lines(datetime, Voltage)
})

## 4
with(df, {
  plot(datetime, Global_reactive_power, type = "n",
       xlab = NA, ylab = "Global Reactive Power (kilowatts)")
  lines(datetime, Global_reactive_power)
})

dev.off()
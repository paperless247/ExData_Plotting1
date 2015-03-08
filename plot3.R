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

# plot3: sub meterings in the two days
png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
with(df, {
  plot(datetime, Sub_metering_1,
       xlab = NA, ylab ="Energy sub metering", type = "l", col = "black")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
})
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
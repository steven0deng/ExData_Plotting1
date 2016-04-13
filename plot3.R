library(data.table)
fileSource <- 'grep "Date\\|^1/2/2007\\|^2/2/2007" household_power_consumption.txt | sed "s/?//g"'
data <- fread(fileSource, header = TRUE, stringsAsFactors = FALSE, sep=';',
              data.table = FALSE)
data$DateTime <- strptime(paste(data$Date, data$Time), 
                          format = '%d/%m/%Y %H:%M:%S')
data$mins <- as.numeric(data$DateTime - data$DateTime[1], 
                        units='mins')
par(bg = "transparent")
png('plot3.png', width = 480, height = 480, bg = "transparent")
with(data, plot(Sub_metering_1 ~ mins, type='n',  xaxt = "n", xlab = '', 
                ylab = 'Energy sub metering'))
with(data, lines(mins, Sub_metering_1, col='black'))
with(data, lines(mins, Sub_metering_2, col='red'))
with(data, lines(mins, Sub_metering_3, col='blue'))
axis(1, at=c(0, 1440, 2880), labels = c('Thu', 'Fri', 'Sat'))
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty = c(1,1,1), col = c('black','red','blue'))
dev.off()

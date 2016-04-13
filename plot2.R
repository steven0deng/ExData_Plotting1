library(data.table)
fileSource <- 'grep "Date\\|^1/2/2007\\|^2/2/2007" household_power_consumption.txt | sed "s/?//g"'
data <- fread(fileSource, header = TRUE, stringsAsFactors = FALSE, sep=';',
              data.table = FALSE)
data$DateTime <- strptime(paste(data$Date, data$Time), 
                          format = '%d/%m/%Y %H:%M:%S')
data$mins <- as.numeric(data$DateTime - data$DateTime[1], 
                        units='mins')
par(bg = "transparent")
png('plot2.png', width = 480, height = 480, bg = "transparent")
with(data, plot(Global_active_power ~ mins, type='l',  xaxt = "n", xlab = '', 
                ylab = 'Global Active Power (kilowatts)'))
axis(1, at=c(0, 1440, 2880), labels = c('Thu', 'Fri', 'Sat'))
dev.off()

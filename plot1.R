library(data.table)
fileSource <- 'grep "Date\\|^1/2/2007\\|^2/2/2007" household_power_consumption.txt | sed "s/?//g"'
data <- fread(fileSource, header = TRUE, stringsAsFactors = FALSE, sep=';',
              data.table = FALSE)
par(bg = "transparent")
png('plot1.png', width = 480, height = 480, bg = "transparent")
hist(data$Global_active_power,col='red', xlab='Global Active Power (kilowatts)',
     main = 'Global Active Power')
dev.off()
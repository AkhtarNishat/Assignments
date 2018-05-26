install.packages("DataCombine")
install.packages("forecast")
library("zoo")
library("datasets")
library("forecast")
library("tseries")
#Preparing the data
data <- read.csv('C:/Users/Owner/Desktop/IrishTravels1.csv', header = FALSE, stringsAsFactors = FALSE)[-c(1, 2, 3, 4, 5, 70, 71, 72, 73),]
data <- data[complete.cases(data),]
row.names(data) <- NULL #getting rid of row names.
colnames <- c("Quater", "Domestic", "Outbound") # renaming the columns
colnames(data) <- colnames
data$Domestic <- as.numeric(as.character(data$Domestic))
data$Outbound <- as.numeric(as.character(data$Outbound))
#converting the quater column to numeric
data$Quater <- as.yearqtr(sub("Q(.)(....)", "\\2-\\1", data$Quater))
str(data$Quater)
#removing columns not required
data$Domestic <- NULL
data$Quater <- NULL
str(data)
#putting data to ts()
ts_data <- ts(data, frequency = 4, start = c(2000, 1))
plot(ts_data)
# Test if a time series is stationary
# p-value < 0.05 indicates the TS is stationary
adf.test(ts_data) # p-value = 0.9019
# Computes the Kwiatkowski-Phillips-Schmidt-Shin (KPSS) test 
# for the null hypothesis that x is level or trend stationary
kpss.test(ts_data) #specified a KPSS test of the null hypothesis that the time series is level stationary (i.e., stationary around a constant mean).
start(ts_data) #start time of data
end(ts_data) #end time of data
frequency(ts_data) #ts_data
class(ts_data)
plot(ts_data) #viewing time series
abline(reg = lm(ts_data ~ time(ts_data))) # mean is changing
cycle(ts_data)
#viewing general trend
plot(aggregate(ts_data, FUN = mean))
#viewing seasonality
boxplot(ts_data ~ cycle(ts_data), xlab = "Quaters", ylab = "Outbound Irish Tavels")
# viewing trend
plot(ts_data)
#making the time series stationary
ts_data <- diff(log(ts_data))
plot(ts_data)
plot(diff(log(ts_data)))
######################################
#Using Auto Arima
model <- auto.arima(ts_data)
model
forecast(model)
plot(forecast(model))
######################################
#Testing the model
#slecting a portion of oringinal to make test-timeseries
test <- ts(ts_data, frequency = 4, start = c(2000, 1), end = c(2013, 4))
#recreating the model
test_model <- auto.arima(test)
test_model
forecast(test_model)
plot(ts_data, main = "Test(Forecast) & Original", xlab = "Time(quaterly)", ylab = "Outbound Irish Tavels", type = "l", col = "Maroon")
par(new = TRUE)
plot(forecast(test_model), lty = "dashed", axes = FALSE, main = "")
mtext("Original(RED),Test(BlacknBlue)", side = 3)
######################################################
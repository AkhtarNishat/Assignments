
#Installing the Packages
install.packages("pwr")
library(pwr)
library(dplyr)
#calculating Effect size
Effect_size <- pwr.chisq.test(w = NULL, N = 68, df = 2, sig.level = 0.05, power = 0.9)
Effect_size
plot(N)
#Importing the dataset
data <- read.csv('C:/Users/Owner/Desktop/IrishTravels1.csv', header = FALSE, stringsAsFactors = FALSE)[-c(1, 2, 3, 4, 5),]
str(data)
colnames <- c("Year/Quater", "Domestic", "Outbound") # renaming the columns
colnames(data) <- colnames
data$Domestic <- as.numeric(as.character(data$Domestic))
data$Outbound <- as.numeric(as.character(data$Outbound))
row.names(data) <- NULL #getting rid of row names.
data <- sample_n(data, 68)
str(data)

#Applying the statistical method
result1 <- chisq.test(data$Domestic, data$Outbound)
result1
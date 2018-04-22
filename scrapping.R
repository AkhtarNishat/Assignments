#Installing library 'rvest' to scrape (or harvest) data from html web pages easily
install.packages('rvest')
library(rvest)

#Specifying url of website to be scrapped
url <- 'https://uk.flightaware.com/live/airport/EIDW/departures'

#reading the html code
web_page <- read_html(url)

#quick look at the contents of web page
head(web_page)
str(web_page)

#titles of the web_page
titles_html <- html_nodes(web_page,'tr:nth-child(2) > th:nth-child(n)')
titles <- html_text(titles_html)
head(titles)

#1st Column : Identification_Code
Identification_Code_html <- html_nodes(web_page, 'td:nth-child(1) > span > a')
Identification_Code <- html_text(Identification_Code_html)
Identification_Code <- Identification_Code[3:22] #removing trailing NA columns
Identification_Code

#2nd Column : Type
Type_html <- html_nodes(web_page, 'td:nth-child(2) > span > a')
Type <- html_text(Type_html)
Type

#3rd Column : Destination
Destination_html <- html_nodes(web_page, 'span.hint > span')
Destination <- html_text(Destination_html)
Destination

#4th Column : Departure
Departure_html <- html_nodes(web_page, 'tr:nth-child(n) > td:nth-child(4)')
Departure <- html_text(Departure_html)
Departure

#5th Column : Estimated_arrival
Estimated_arrival_html <- html_nodes(web_page, 'tr:nth-child(n) > td:nth-child(5)')
Estimated_arrival <- html_text(Estimated_arrival_html)
Estimated_arrival

#Creating Dataframe
Flights <- data.frame(Identification_Codeification_Code, Type, Destination, Departure, Estimated_arrival)
Flights

#Writing the Dataframe to csv
write.csv(Flights, file = "MyData.csv", row.names = FALSE)

#Reading the csv
MyData <- read.csv('MyData.csv')
MyData
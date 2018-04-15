#amalgamating all of the crime data from each csv file into one dataset
csv_file_list <- list.files(path = "C:/Users/Owner/Downloads/NI Crime Data/", pattern = "*.csv", recursive = TRUE)
csv_file_list
combine_results <- function(csv_file_list) {
    all_NI_data <- NULL
    for (csv_file in csv_file_list) {
        file <- read.csv(paste("C:/Users/Owner/Downloads/NI Crime Data/", csv_file, sep = ""), header = TRUE, stringsAsFactors = FALSE)
        all_NI_data <- rbind(all_NI_data, file)
    }
    return(all_NI_data)
}
#Saving all of the crime data from each csv file into one dataset
AllNICrimeData <- combine_results(csv_file_list)
str(AllNICrimeData)
head(AllNICrimeData)
#Saving the dataset into a csv file called All_NI_Crime_Data. 
write.csv(AllNICrimeData, file = "AllNICrimeData.csv", quote = FALSE, na = "", row.names = FALSE)
Data <- read.csv(file = "C:/Users/Owner/Documents/GitHub/DataScienceShare-2018/Lotto/AllNICrimeData.csv", sep = ",", stringsAsFactors = FALSE)
str(Data)
head(Data)
#Count and show the number of rows in the All_NI_Crime_Data dataset.
nrow(AllNICrimeData)
#removing the unwanted attributes:
AllNICrimeData_subset = AllNICrimeData[, c(2, 5, 6, 7, 10)]
write.csv(AllNICrimeData_subset, file = "Subset_Crime_Data.csv", quote = FALSE, na = "", row.names = FALSE)
SubsetData <- read.csv(file = "C:/Users/Owner/Documents/GitHub/DataScienceShare-2018/Lotto/Subset_Crime_Data.csv", sep = ",", stringsAsFactors = FALSE)
#Showing the structure of the modified file.
str(SubsetData)
head(SubsetData)
#Factorising the Crime type attribute & Showing the modified structure.
Crime.type <- factor(SubsetData$'Crime.type', order = TRUE)
SubsetData$'Crime.type' <- Crime.type
str(SubsetData)
#Modifying the AllNICrimeData dataset so that the Location attribute contains only a street name.
Location <- gsub("On or near ", "", as.character(AllNICrimeData$Location))
AllNICrimeData$Location <- Location
# Modify the resultant empty location attributes with a suitable identifier.
AllNICrimeData$Location[AllNICrimeData$Location == ""] <- "Not Given"
head(AllNICrimeData,20)
#Bringing NIPOSTCODE data
CleanNIPostcodeData <- read.csv("C:/Users/Owner/Documents/GitHub/DataScienceShare-2018/Lotto/CleanNIPostcodeData.csv", header = TRUE, stringsAsFactors = FALSE)
str(CleanNIPostcodeData)
head(CleanNIPostcodeData, 20)
#finding a suitable postcode value from the postcode dataset
Crime_location <- toupper(AllNICrimeData$Location)
Postcode_Location <- toupper(CleanNIPostcodeData$Primary_Thorfare)
post_code <- CleanNIPostcodeData$Postcode
#Creating the function
Find_Post_Code <- function(Crime_location, Postcode_Location) {
    for (x in post_code) { 
    ifelse(Crime_location[x] == Postcode_Location, post_code, NA)
}
    return(Find_Post_Code)
    }
Find_Post_Code(Crime_location,Postcode_Location)
#the structure and number of values in Find_Post_Code
str(Find_Post_Code)
nrow(Find_Post_Code)
#Appending the data output from your find_a_postcode function to the AllNICrimeData dataset. Show the modified structure.
AllNICrimeData$PostCode = find_a_postcode
str(AllNICrimeData)
#creating 'tidy_location' for all data with incomplete location & finding a close match. 
AllNICrimeData[AllNICrimeData$Location == "Not Given",] <- AllNICrimeData[match(AllNICrimeData$Location[AllNICrimeData$x.coordinates == ""], AllNICrimeData$x.coordinates),]
#showing the first 10 rows of data.

#(h) Append the AllNICrimeData dataset with new attributes Town, County and
#Postcode. Use the NIPostcode dataset and match the location attribute to perform
#the join between both datasets. Modify Town and County attributes to become
#unordered factors. Show the modified AllNICrimeData structure.

#(i) Save your modified AllNICrimeData dataset in a csv file called FinalNICrimeData.

#(j) Search for all crime data where town contains Strabane and postcode contains
#BT82. Show the first 10 rows of this data
### Course Project for Getting and Cleaning Data (Paul Schiavone)

#### Loading the data  
* Using Read.Table load the data friles from working directory into data fram objects
* xTrain = read.table("./train/X_train.txt")
* subjectTrain = read.table("./train/subject_train.txt")
* yTrain = read.table("./train/y_train.txt")
* xTest = read.table("./test/X_test.txt")
* subjectTest = read.table("./test/subject_test.txt")
* yTest = read.table("./test/y_test.txt")
* features = read.table("features.txt") # original variable names
* activityLabels = read.table("activity_labels.txt") # k v pair key is int, val is str

#### Perform Exlporatory Analysis to determine structure and properties of the data
* Examine structure and properties of datasets

#### Combine Datasets
* column bind the subject and y data to the train and test data respectively
* row bind the newly created test and train datasets into CompDF
* extract feature vector and use as the names for the CompDF

#### Subset the Data
* Create new data fram by only selecting variables that contain mean and std data
* meanVec = grep("mean", names(compDF))
* stdVec = grep("std", names(compDF))
* indicesVec = sort(c(meanVec, stdVec, 562:563)) 
* tidyDF = compDF[, indicesVec] 

#### Convert Activites to a meanigful factor variable

#### Change Variable names to "User" and "Activity"

#### Reshape the data and create a processed tidy data set
* tidyMelt = melt(tidyDF, id=c("User", "Activity"))
* tidyCast = dcast(tidyMelt, User + Activity ~ variable, mean)

#### write tidyCast to file
* write.csv(tidyCast, file="tidyDF.csv")



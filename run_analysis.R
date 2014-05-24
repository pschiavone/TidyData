
xTrain = read.table("./train/X_train.txt")

subjectTrain = read.table("./train/subject_train.txt")

yTrain = read.table("./train/y_train.txt")

xTest = read.table("./test/X_test.txt")

subjectTest = read.table("./test/subject_test.txt")

yTest = read.table("./test/y_test.txt")

features = read.table("features.txt") # original variable names

activityLabels = read.table("activity_labels.txt") # k v pair key is int, val is str

#bind the subjectTrain and yTrain datasets to the xTrain data frame and build new df
newTrainDF = cbind(xTrain, c(subjectTrain, yTrain))
#bind the subjectTrain and yTrain datasets to the xTrain data frame and build new df
newTestDF = cbind(xTest, c(subjectTest, yTest))

compDF = rbind(newTrainDF, newTestDF)

# add feature names to variable names
names(compDF) = features[,2]

meanVec = grep("mean", names(compDF))
stdVec = grep("std", names(compDF))
indicesVec = sort(c(meanVec, stdVec, 562:563)) # used to subset combined dataset

tidyDF = compDF[, indicesVec] #subset only mean and std variables

temp = tidyDF[,length(tidyDF)]
temp = gsub(1,activityLabels[1,2], temp)
temp = gsub(2,activityLabels[2,2], temp)
temp = gsub(3,activityLabels[3,2], temp)
temp = gsub(4,activityLabels[4,2], temp)
temp = gsub(5,activityLabels[5,2], temp)
temp = gsub(6,activityLabels[6,2], temp)
temp = factor(temp)
tidyDF[, length(tidyDF)] = temp

names(tidyDF)[80] = "User"
names(tidyDF)[81] = "Activity"

tidyMelt = melt(tidyDF, id=c("User", "Activity"))
tidyCast = dcast(tidyMelt, User + Activity ~ variable, mean)

#write tidyCast to file
write.csv(tidyCast, file="tidyDF.csv")
 
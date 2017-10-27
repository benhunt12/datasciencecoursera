## working directory is my desktop
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

## explore the dataset 
str(subject_test)
str(subject_train)
str(x_test)
str(x_train)
str(y_test)
str(y_train)
str(features)

## So the training set is a complete set of subjects with activities that are all labeled.
## The test set is the same data, but with a lot of unknowns in naming.
## Using the features.txt, we can set the names of the x_test table to match x_train
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]

## subject_train and subject test both have the same column name, but V1 doesnt really
## make sense, so we'll call them ID

colnames(subject_test) <- "ID"; colnames(subject_train) <- "ID"

## the y_test and y_train tables have a similar problem, where the name V1 doesnt represent
## the data well. We'll call them act

colnames(y_test) <- "act"; colnames(y_train) <- "act"

## now combine the three test files and three train files
train <- cbind(subject_train, x_train, y_train)
test <- cbind(subject_test, x_test, y_test)

data <- as.data.frame(rbind(train, test))

## just reorder by ID, use unique to check
data <- data[order(data$ID),]
unique(data$ID)

## use grep() togo grab the columns with mean, sd, ID, or act
search <- colnames(data)
retData <- grep(".*mean.*|.*std.*|ID|act", search, ignore.case = T)

tidy <- data[, retData]

## create activity labels, factor variable with 6 levels
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
str(labels)


tidy$act <- as.character(tidy$act)
for(i in 1:length(tidy$act)){
  if(tidy$act[i] == 1) tidy$act[i] <- as.character(labels[1,2])
  else if(tidy$act[i] == 2) tidy$act[i] <- as.character(labels[2,2])
  else if(tidy$act[i] == 3) tidy$act[i] <- as.character(labels[3,2])
  else if(tidy$act[i] == 4) tidy$act[i] <- as.character(labels[4,2])
  else if(tidy$act[i] == 5) tidy$act[i] <- as.character(labels[5,2])
  else tidy$act[i] <- as.character(labels[6,2])
}

## get mean for each activity for each subject ID
ag <- aggregate(. ~ ID + act, data = tidy, FUN = mean)
write.table(ag, file = "mean.txt", row.name=FALSE)



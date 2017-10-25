## working directory is my desktop
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")


subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

## explore the dataset 
str(subject_test)
str(subject_train)
str(x_test)
str(x_train)
str(y_test)
str(y_train)

## So the training set is a complete set of subjects with activities that are all labeled.
## The test set is the same data, but with a lot of unknowns in naming.
## Using the features.txt, we can set the names of the x_test table to match x_train

features <- read.table("./UCI HAR Dataset/features.txt")
colnames(x_test) <- features[,2]

## subject_train and subject test both have the same column name, but V1 doesnt really
## make sense, so we'll call them ID

colnames(subject_test) <- "ID"; colnames(subject_train) <- "ID"

## the y_test and y_train tables have a similar problem, where the name V1 doesnt represent
## the data well. We'll call them activity

colnames(y_test) <- "activity"; colnames(y_train) <- "activity"

## now combine the three test files and three train files
train <- cbind(subject_train, x_train, y_train)
test <- cbind(subject_test, x_test, y_test)

data <- as.data.frame(rbind(train, test))

## just reorder by ID, use unique to check
data <- data[order(data$ID),]
unique(data$ID)

## write for output
write.table(data, file = "tidy.txt", row.name=FALSE)

## get mean for each activity for each subject ID
ag <- aggregate(. ~ ID + activity, data = data, FUN = mean)
write.table(ag, file = "mean.txt", row.name=FALSE)

CODEBOOK

First, we read in the data. The UCI HAR Dataset folder is on my desktop, hence my method for reading it in. I'm keeping the naming convention the same as well to avoid confusion. Data named with "...test" are from the test set, and data with "...train" are from the training set.

```{r}
  ## working directory is my desktop
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt") 
  
  features <- read.table("./UCI HAR Dataset/features.txt")
```

Just exploring the sets a litte. We should assume that each set(training and testing sets) should be very similar, in terms of data, column names and dimensions. 

```{r}
  ## explore the datasets 
  str(subject_test)
  str(subject_train)
  str(x_test)
  str(x_train)
  str(y_test)
  str(y_train)
```
1. Both the "subject" sets contain the "ID" of the participant and are both labeled "V1".
2. Both "x" sets contain 561 variables, with the training set having many more observations, which makes sense. The variables are labeled "V1" - "V561", we can assume these are the sets with the real data, and these with correspond to the names in features.txt, which has 561 observations.
3. The "y" sets contain the classification of the activity.

First, let's set the names of the "x" datasets using the "features" set, which is 561x2. The first column is just the index, so we'll take the second column.
```{r}
  ## So the training set is a complete set of subjects with activities that are all labeled.
  ## The test set is the same data, but with a lot of unknowns in naming.
  ## Using the features.txt, we can set the names of the x_test table to match x_train
  colnames(x_train) <- features[,2]
  colnames(x_test) <- features[,2]
```
Now, "V1" aren't very descriptive names for the "y" datasets containing ativity type or the "subject" datasets containing the subject number. We'll change those to "act" and "ID", respectively.

```{r}
  ## subject_train and subject test both have the same column name, but V1 doesnt really
  ## make sense, so we'll call them ID
  colnames(subject_test) <- "ID"; colnames(subject_train) <- "ID"

  ## the y_test and y_train tables have a similar problem, where the name V1 doesnt represent
  ## the data well. We'll call them activity
  colnames(y_test) <- "act"; colnames(y_train) <- "act"
```
Now we can combine the "subject", "x" and "y" datasets to create complete training and testing datasets, using *cbind()*.

```{r}
  ## now combine the three test files and three train files
  train <- cbind(subject_train, x_train, y_train)
  test <- cbind(subject_test, x_test, y_test)
```
Then combine the training and testing set to create the original data. Then we reorder the data, simply to check and make sure we've combined it all correctly. You can also view the new set using *View()*.

```{r}
  data <- as.data.frame(rbind(train, test))
  
  ## just reorder by ID, use unique to check
  data <- data[order(data$ID),]
  unique(data$ID)
  
  View(data)
```

Now we want to grab only the columns that contain the mean and standard deviation. But we also want to keep the "ID" and "activity" labels

```{r}
  ## use grep() togo grab the columns with mean, sd, ID, or act
  search <- colnames(data)
  retData <- grep(".*mean.*|.*std.*|ID|act", search, ignore.case = T)

  tidy <- data[, retData]
```
Next, we need to replace the numerical activity ID's with their labels. So we load activity_labels.txt, then loop through it, and where a value appears, we replace it with it's corresponding activity.

```{r}
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
```
Then we just need to aggregate the data by mean for each subject and activity.

```{r}
  ## get mean for each activity for each subject ID
  ag <- aggregate(. ~ ID + act, data = tidy, FUN = mean)
  write.table(ag, file = "tidy.txt", row.name=FALSE)
```
Done!












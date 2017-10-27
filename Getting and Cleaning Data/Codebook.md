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



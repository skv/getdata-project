## 0 Prerequisites

for(p in c("data.table", "reshape2")) {
	if (!require(p, character.only = TRUE, quietly = TRUE))	install.packages(p)
	require(p, character.only = TRUE, quietly = TRUE)
}

## 1 Merge the training and the test sets to create one data set.

DATA_DIR <- "UCI HAR Dataset"

load_and_merge_data <- function(prefix) {
    do.call(rbind, lapply(c("train", "test"), function(category) {
        ## "UCI HAR Dataset/train/X_train.txt")
        fpath <- file.path(DATA_DIR, category, paste0(prefix, "_", category, ".txt"))
        #message(fpath)
        read.table(fpath)
    }))
}

data <- list(
          x=load_and_merge_data("X"),
          y=load_and_merge_data("y"),
    subject=load_and_merge_data("subject")
)

## 2 Extract only the measurements on the mean and standard deviation for each measurement. 

features <- read.table(file.path(DATA_DIR, "features.txt"), col.names=c("FeatureID", "FeatureName"), header=F, as.is=T)[,2]
colnames(data$x) <- features

features_subset <- grepl("(mean|std)\\(", features)
data$x <- data$x[,features_subset]

#### Result 2: name cols in data$x and filter out all except mean and std

## 3 Use descriptive activity names to name the activities in the data set

activity_labels <- read.table(file.path(DATA_DIR, "activity_labels.txt"), col.names=c("ActivityID", "ActivityName"), header=F, as.is=T)
activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)

colnames(data$y) <- c("ActivityID")
data$y <- merge(data$y, activity_labels)

#### Result 3: 2nd col in data$y with name "ActivityName"

## 4 Appropriately label the data set with descriptive variable names. 

# Naming for data$x and data$y was in steps 2-3
colnames(data$subject) <- c("Subject")

## 5 From the data set in step 4, create a second, independent tidy data set
## with the average of each variable for each activity and each subject.

melted_data <- melt(cbind(data$y, data$subject, data$x),
                    id = c(colnames(data$y), colnames(data$subject)),
                    measure.vars = colnames(data$x)
            )

### Apply mean function to melted dataset via dcast
tidy_data <- dcast(melted_data, Subject + ActivityName ~ variable, mean)

write.table(tidy_data, file = "tidy_dataset.txt", row.name=FALSE)

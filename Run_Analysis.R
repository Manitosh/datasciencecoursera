# Include library
library(plyr)

# We will complete the following steps in following sequence

# 1. We will first merge the training and test data to create one data set, it will help to work on combined data
#    1.1 Load X_train.txt ,  Y_train.txt and subject_train.txt
#    1.2 Load X_test.txt ,  Y_test.txt and subject_test.txt
#    1.2 combined data for X,Y and Subject
# 2.  we will load features file so can get all columns with mean and sd in their name
# 3. Get the data from comibed data set for desired columns
# 4. Load activity data
# 5. Put correct activities name
# 6. Get whole dataset
# 7. Get mean and avergae data
# 8. Ceate dataset

# Step 1
my_train_x <- read.table("train/X_train.txt")
my_train_y <- read.table("train/y_train.txt")
my_subject_train <- read.table("train/subject_train.txt")

my_test_x <- read.table("test/X_test.txt")
my_test_y <- read.table("test/y_test.txt")
my_subject_test <- read.table("test/subject_test.txt")

# combined x data
combined_x_data <- rbind(my_train_x, my_test_x)

# combined y data
combined_y_data <- rbind(my_train_y, my_test_y)

# Comined 'subject' data
combined_subject_data <- rbind(my_subject_train, my_subject_test)




# Step 2
features <- read.table("features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

#Step 3
combined_x_data <- combined_x_data[, mean_and_std_features]
names(combined_x_data) <- features[mean_and_std_features, 2]

# Step 4
activities <- read.table("activity_labels.txt")

# Step 5
combined_y_data[, 1] <- activities[combined_y_data[, 1], 2]
names(combined_y_data) <- "activity"
names(combined_subject_data) <- "subject"

#Step 6
my_whole_data <- cbind(combined_x_data, combined_y_data, combined_subject_data)

# Step 7
my_average <- ddply(my_whole_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(my_average, "my_Quiz_2_data.txt", row.name=FALSE)
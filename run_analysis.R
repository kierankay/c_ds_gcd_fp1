# 1. Merge the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set with thehead average of each variable for each activity and each subject.  

folder = "./UCI HAR Dataset/";  

# load training, test, feature, and labels data
training_set = read.table(file = paste(folder, "train/X_train.txt", sep = ""), header = 0);
training_labels = read.table(file = paste(folder, "train/y_train.txt", sep = ""), header = 0);
training_subjects = read.table(file = paste(folder, "train/subject_train.txt", sep = ""), header = 0);
test_set = read.table(file = paste(folder, "test/X_test.txt", sep = ""), header = 0);
test_labels = read.table(file = paste(folder, "test/y_test.txt", sep = ""), header = 0);
test_subjects = read.table(file = paste(folder, "test/subject_test.txt", sep = ""), header = 0);
features = read.table(file = paste(folder, "features.txt", sep = ""), header = 0);
activity_labels = read.table(file = paste(folder, "activity_labels.txt", sep =""), header = 0);

# merge training and test data sets
merged_set = rbind(training_set, test_set);

# merge training and test activity labels
merged_labels = rbind(training_labels, test_labels);
merged_labels = factor(factor(merged_labels[,1]), labels=activity_labels[,2]);

# merge training and test subjects
merged_subjects = rbind(training_subjects, test_subjects);
colnames(merged_subjects) = "Subject";

# filter on and extract mean and standard deviation data from data set
features_formatted = features[,2];
filtered_features = grep("mean|std",features_formatted);
merged_data = merged_set[,filtered_features];

# set features as column names
filtered_feature_names = grep("mean|std",features_formatted, value=TRUE);
colnames(merged_data) = filtered_feature_names;

# bind subjects and activities to data, and label activities column
merged_data = cbind(merged_subjects, merged_labels, merged_data);
colnames(merged_data)[2] = "Activity"

# create tidy data set of averages for subject and activity, and output
aggregated_data = aggregate(merged_data[,-(1:2)], list(merged_data[,1],merged_data[,2]), mean);
tidy_data = aggregated_data[with(aggregated_data, order(Group.1, Group.2)), ];
setnames(tidy_data, old=c("Group.1","Group.2"), new = c("Subject","Activity"));
write.table(tidy_data, file = paste(folder,"tidy_data.txt", sep=""), row.name=FALSE);
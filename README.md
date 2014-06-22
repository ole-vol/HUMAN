Getting a tidy dataset out of the raw data of the Human+Activity+Recognition+Using+Smartphones - Measurement

1. Reading the test and training data x,y and subjects into 
subjects_test and subjects_train, x_test and x_train
2. Rowbinding them together. (rbind)
3. Reading the features names and adding them to the feature measurment x
4. Creating a data.table with x,y and subjects
5. ubsetting only the variable with means and standart derivates in its names
and creating a second data frame measure_mean_std with these variables and the acitivty-numbers
and subject numbers.
6. reading the activity-labels and setting them as levels of the activiy numbers
7. Setting the activity-lables from factors to character so that you reading the activitys in the table.
8. writing the table to measure_mean_std.txt


Creating the second table:

1. Splitting the first data set from above (measurement) in activity- tables  (Y is the activity-number) 
2. creating a dummy variable saver which will save the COLUMNS of the matrix measure_avg_split,
which will have the avg features for each subject and each activity
3. for each feature of the measurement a columns is created which includes in the first
#six rows the avg of the feature for the first subject and the six activitys and in the second
#six rows the avg of the feature for the second subject and the six activitys and so on...
4. wrting a dataframe out of the matrix measure_avg_split
5. labeling the variables of the measurement with the feature-names
6. step adding the activity column to the data frame. Because the first six rows a the
#activitys og the first person, they are labeled with 1:6, as the next sixt rows and so on.
7. the first 6 rows of the data frame belongs to the first subject and the second
# six rows to second subject and so on.. So we creating a vector which looks like 
#(1,1,1,1,1,1,2,2,2,2,2,2,3....) and adding a column with the subject numbers to the data frame
8. reading the activity-labels and setting them as levels of the activiy numbers
9. Setting the activity-lables from factors to character so that you reading the activitys in the table.
10. writing the data frame to measure_splits.txt

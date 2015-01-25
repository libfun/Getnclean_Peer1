# Getting and Cleaning Data Course Project Codebook

## Data

The only output, as suggested by the Assignment, is the file new_tidy_set.txt containing dataset from task 5.  
It contains averages of all mean and standard deviation features from concatenated training and test datasets averaged by subject.

## Script actions

1. Download and extract the archive  
2. Read train dataset into data_train variable  
3. Get feature names from features.txt file and apply them to data_train  
4. Select features with means and standard deviations and subset by them  
5. Add column of labels and subjects to the dataset  
6. Repeat above for the test dataset  
7. Concatenate both sets to get full set  
8. Create new independent set with the average of each variable by subject  
9. Omit unnecessary feature and label  
10. Save dataset  

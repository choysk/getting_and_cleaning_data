# getting_and_cleaning_data

This is R script called run_analysis.R that does the following:

 1. Merges the training data from in a column-wise fashion:
    a. X_train.txt - Contains variables based on accelerometer and gyroscope 3-axial raw signals.
                     One record for each subject and activity.
        
    b. y_train.txt - Contains only one column - the activity id. 
                     Each record is related to the same row in X_train.txt.

    c. subject_train.txt - Contains the subject id took part in the experiments.
                     Each record is related to the same row in X_train.txt.

 2. Merges the similar set of test data (X_test.txt, y_test.txt, subject_test.txt as in Step 1.
 
 3. Merges both the test and training data in a row-wise fashion.
 
 5. Adds Activity Name column by looking up a 6 row table with activity id and Activity Name. 
 
 7. Extracts only the measurements on the mean and standard deviation for each measurement - using 
    grep with "mean" and "std" - into a new dataset.

 8. Creates a second, independent tidy data set with the average of each variable for each activity 
    and each subject and write to a text file (.txt) with "," as the variable separator.


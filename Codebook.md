run_analysis.R description
--------------------------------
* The script assumes that the working directory is "UCI HAR Dataset" directory
* Script does following:

  1. Reads the following files:
    * X_train.txt
    * X_test.txt 
    * features.txt
    * activity_labels.txt
    * subject_train.txt
    * subject_test.txt
    * y_train.txt
    * y_test.txt
  
  2. Converts y_[train|test] data from numeric encoding to spelled out format, i.e. STANDING, WALKING, etc
    * Used activity_labels.txt for conversion
    * Resultant data frame is called al_train and al_test, al stands for activity list.
  
  3. From features list obtained from features.txt, determined the column numbers to select from X_[train|test] 
    dataset
      * The resultant data sets are named as X_filtered_[train|test] data frames
  
  4. Merges the data sets x_filtered_[train|test],al_[train|test],subject
  5. Combines X, activity labels, and subject in a data frame, and named the columns of data frame
  6. Writes the resultant tidy data frame into text file
  7. Per last requirements, determines new set of columns--columns with means, and creates new tidy data set
  and wrote to disk.
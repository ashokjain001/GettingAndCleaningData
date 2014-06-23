The main aim of this file is to illustrate the steps performed for
getting and Cleaning Data class project.
https://class.coursera.org/getdata-004

This repo contains 
1)README.md 
2)run_analysis.R
3)codebook.md

The data is obtained from this link
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
%20Dataset.zip

For more information on the data please visit
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+
Smartphones

File contains seperate folder for test and train data. The very first
step is to combine both test and training. we use rbind function to
achieve this step, at the end of this step we have 10299 rows and 561
columns. Second step is to select only the column which has mean and std
words in it, we can do this by using grep fucntion and extracting only
the required rows. We end up with 66 columns. Now combining the subjects
and activities(activity_id) they perform with the rest of the data set
using cbind function. Merge dataset with the activitylabels data set
using merge fucntion on activityid and activity. Removing '()' and '-'
from the column names for further analysis.


The last step is to find average of each variable based on each subject
and activities they perform. aggregate function is used and in the end
tidy data has 180 rows and 58 columns. 


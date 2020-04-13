---
title: "Code Book for Data Cleaning Project"
author: "StarLord99x"
date: "4/12/2020"
output: html_document
---

## Description of project_data_tidy.txt

The project_data_tidy.txt file contains the tidy data set submitted
to demonstrate accomplishment of the project objectives. The
variables in this data table are:

* subject_id is the unique identifier for each subject
* test_or_train indicates whether the subject was in the training or test set
* activity_index identifies the activity associated with a given observation
* activity_label is the human-readable description of the activity
* The remaining columns are extracted from the original data set. Only the mean and standard deviation variables were extracted. Decriptions of these variables can be found in the zipped file.

## Description of project_data_means_tidy.txt

The project_data_means_tidy.txt file contains the means of each
observation by activity and subject. Thevariables in this data
table are:

* activity_label is the human-readable description of the activity
* subject_id is the unique identifier for each subject
* The remaining columns are the averages of each variable extracted from the original data set for each activty and subject combination.

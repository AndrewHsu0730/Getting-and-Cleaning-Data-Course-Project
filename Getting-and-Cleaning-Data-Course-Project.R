library(rlang)
X_train <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
data <- rbind(X_train, X_test)

subject_train <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
subject_id <- rbind(subject_train, subject_test)

y_train <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
label <- rbind(y_train, y_test)

complete <- cbind(subject_id, label, data)

features <- read.table("C:/Users/Andrew Hsu/OneDrive/Desktop/Aquarium/IT/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
for (feature in  features) {print(feature)}
colnames(complete) <- c("id", "activity", feature)
cn <- colnames(complete)

mean <- grep("mean()", cn[1:563])
std <- grep("std()", cn[1:563])
filtered_cs <- sort(c(mean, std))
complete <- complete[ , c(1, 2, filtered_cs)]

complete[ , 2] <- ifelse(complete$activity == 1, "Walking", ifelse(complete$activity == 2, "Walking_Upstairs", ifelse(complete$activity == 3, "Walking_Downstairs", ifelse(complete$activity == 4, "Sitting", ifelse(complete$activity == 5, "Standing", "Laying")))))
first_dataset <- complete
View(first_dataset)

variables
first_dataset %>%
  group_by(id, activity) %>%
  summarise_all(.funs = mean)
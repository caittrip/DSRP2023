superData <- read.csv("contestant_table.csv")
age <- superData$age

## I am going to use the age column to find my statistics
# Question 4
mean(age) # 33.41019
median(age) # 31
range(age) # 18 75
max(age)-min(age) # 57



# Question 5
var(age) # 101.9769
sd(age) # 10.09836
IQR(age) # 14

# Question 6: Outliers
lower <- mean(age) - 3*sd(age) # 3.11
upper <- mean(age) + 3*sd(age) # 63.70528
# Any age above 63 is an outlier
# Removing Outliers

updatedAge <- age[age > lower & age < upper] 


mean(updatedAge) # 33.13736
median(updatedAge) # 30

# Surprisingly, the median changed more than the mean

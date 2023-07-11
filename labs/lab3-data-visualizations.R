superData <- read.csv("contestant_table.csv")
install.packages("ggplot2")
library(ggplot2)

summary(superData)
str(superData)

## Distribution
ggplot(data = superData, aes(x = age)) + 
  geom_histogram(color = "deeppink4", fill = "pink") +
  labs(x = "Age of Survivor Contestant",
       y = "Count",
       title = " Age Distribution of Survivor Contestants")

## Numeric vs. Categorical
ggplot(data = superData, aes(x = gender, y = votes_against)) + 
  geom_violin(aes(fill = gender)) + # need aes if not in ggplot
  geom_boxplot(width = 0.2, color = "gray5") + 
  labs(x = "Gender of Survivor Contestant",
       y = "Votes Against",
       title = "Votes Against Survivor Contestants by Gender")

## Numeric vs. Numeric
ggplot(data = superData, aes(x = age, y = num_boot)) + 
  geom_point(aes(color = gender)) +
  labs(x = "Age of Survivor Contestant",
       y = "Boot Order",
       title = "Placement of Survivor Contestant by Age") + 
  scale_y_reverse()


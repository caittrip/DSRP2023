survivor <- read.csv("contestant_table.csv")
library("ggplot2")
library("janitor")
library("dplyr")
library("tidyr")

## Categorical variable: Gender (M or F)
## Numeric variable: Age
## Null Hypothesis: There is no difference in mean age of male and female survivor contestants
## Alternative Hypothesis: The mean age of male survivor contestants is greater than the mean age of female survivor contestants
## Two tailed, unpaired test

males <- survivor |> filter(gender == "M")
females <- survivor |> filter(gender == "F")

t.test(males$age, females$age, paired = F, alternative = "greater") 

## p-value = 0.000676. Since this is less than our significance level of 0.05, we reject the null hypothesis
## Mean age of male survivor contestants is greater than mean age of female survivor contestants


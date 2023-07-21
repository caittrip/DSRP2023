survivor <- read.csv("contestant_table.csv")
library("ggplot2")
library("janitor")
library("dplyr")
library("tidyr")
library("corrplot")
## Test for significant difference between 2 groups ####
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

## Test for significant difference between 3+ groups ####
# Null Hypothesis: There is no difference between finish among different genders listed (M, F, N).
# Alternative Hypothesis: There is a difference between finish among different genders listed (M, F, N).
head(survivor)
anova_survivor_results <- aov(finish ~ gender, survivor)

summary(anova_survivor_results)

TukeyHSD(anova_survivor_results)

## Test for significant association between categorical variables ####
# Finish and Gender
# Null Hypothesis: There is no difference between finish among different genders listed (M, F, N).
# Alternative Hypothesis: There is a difference between finish among different genders listed (M, F, N).
survivor_clean <- survivor |>
  filter(gender != "N")
t <- table(survivor_clean$finish, survivor_clean$gender)

chisq_result <- chisq.test(t)

chisq_result$p.value
chisq_result$residuals

corrplot(chisq_result$residuals, is.corr = F)

## For Fun: Only New Era Seasons ####
survivor_clean <- survivor |>
  filter(gender != "N",
         num_season %in% c("41", "42", "43"))
t <- table(survivor_clean$finish, survivor_clean$gender)

chisq_result <- chisq.test(t)

chisq_result$p.value
chisq_result$residuals

corrplot(chisq_result$residuals, is.corr = F)

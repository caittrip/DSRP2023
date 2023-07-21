## Trying to predict the finish of a contestant given demographics

## Step 1: Collect Data
survivor <- read.csv("contestant_table.csv")
head(survivor)

## Step 2: Clean and Process Data

?na
library(dplyr)
survivorN <- filter(survivor, gender != "N")
survivorMutate <- mutate(survivorN,
                         gender = as.factor(survivorN$gender))
?filter
gender <- survivorMutate$gender
class(gender)
## Step 3: Visualize Data
library(reshape2)
library(ggplot2)



ggplot(survivorMutate, aes(x = gender, y = finish)) +
  geom_point() +
  theme_minimal()

ggplot(survivorMutate, aes(x = gender, y = finish, fill = finish)) + 
  geom_tile() +
  scale_fill_gradient2(low = "red", 
                       high = "blue", 
                       mid = "white",
                       midpoint = 0)


?prcomp
survivorMutateNum <- select(survivorMutate, -gender)

pca_survivor <- prcomp(survivorMutateNum, scale. = T)
summary(pca_survivor)
pca_survivor$rotation

pca_survivor$rotation^2

## get the x values of PCAs and make it a data frame
pca_survivor_vals <- as.data.frame(pca_survivor$x)
pca_survivor_vals$Species <- survivorMutate$gender

ggplot(pca_vals, aes(PC1, PC2, color = Species)) +
  geom_point() +
  theme_minimal()
## Step 4: Perform Feature Selection
# Classification
# Predict finish

## Step 5: Separate Data into Testing and Training Sets
library(rsample)

# Set a seed for reproduceability 
set.seed(71723)
# Create a split
class_split <- initial_split(survivorMutate, prop = 0.75) # 75% of data into training set


class_train <- training(class_split)
class_test <- testing(class_split)


?pca
## Steps 6 & 7: Choose a ML Model and Train It
library(parsnip)

log_fit_survivor <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(gender ~ ., data = class_train)

log_fit_survivor$fit
summary(log_fit_survivor$fit)
length(log_fit_survivor)


forest_class_fit_survivor <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification") |>
  fit(gender ~ finish, data = class_train)

forest_class_fit_survivor$fit

## Step 8: Evaluate Model Performance on Test Set
# Calculate errors for regression

library(Metrics)
library(MLmetrics)
class_results <- class_test

class_results_survivor$log_pred <- predict(log_fit_survivor, class_test)$.pred_class

f1(class_results$Species, class_results$log_pred)
F1_Score(class_results$gender, log_fit$fit)
f1(class_results, forest_class_fit)

length(class_results$gender)
length(class_results$log_fit)
length(log_pred)
length(forest_class_fit)
length(class_test)
length(class_results)
length(log_fit)
class_results
length(class_train)

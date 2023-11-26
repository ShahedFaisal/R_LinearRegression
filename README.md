# Predictive Modeling with R: Linear Regression

## Overview

This repository contains R code for implementing linear regression on a housing dataset ("train.csv"). The objective is to predict housing prices ("SalePrice") based on various features. The code covers data loading, initial checks, variable selection, data cleaning, creation of dummy variables, model building using stepwise regression, handling outliers, and evaluating model performance.

## Key Steps

-   Read the dataset and perform preliminary checks to ensure data integrity.

-   Select relevant variables and create a refined dataset.

-   Utilize the `caret` library to create dummy variables for categorical features.

-   Apply stepwise regression using the `MASS` library to identify significant variables.

-   Assess model performance, identify outliers, and refine the regression model accordingly.

-   Generate predictions on the training set and evaluate the model's accuracy.

-   Apply the trained model to the "test.csv" dataset for predicting housing prices.

## Model Evaluation

The R-squared value of 0.8441 indicates that approximately 84.41% of the variability in the dependent variable ("SalePrice") is explained by the independent variables included in the model. A higher R-squared suggests a better fit of the model to the data. In the context of housing price prediction, this implies that the selected features contribute significantly to explaining the variation in house prices.

## Note

-   Ensure the presence of "train.csv" and "test.csv" datasets in the working directory for proper code execution.

Refer to the source code in the repository for a detailed understanding of the implementation.

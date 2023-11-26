# Predictive Modeling with R: Linear Regression

## Overview

This repository contains R code for implementing linear regression on a housing dataset ("train.csv"). The objective is to predict housing prices ("SalePrice") based on various factors. The code covers data loading, initial checks, variable selection, data cleaning, creation of dummy variables, model building using stepwise regression, handling outliers, and evaluating model performance.

## Key Steps

-   Read the dataset and perform preliminary checks to ensure data integrity.

-   Select relevant variables and create a refined dataset.

-   Utilize the `caret` library to create dummy variables for categorical factors.

-   Apply stepwise regression using the `MASS` library to identify significant variables.

-   Assess model performance, identify outliers, and refine the regression model accordingly.

-   Generate predictions on the training set and evaluate the model's accuracy.

-   Apply the trained model to the "test.csv" dataset for predicting housing prices.

## Note

Ensure the presence of "train.csv" and "test.csv" datasets in the working directory for proper code execution.

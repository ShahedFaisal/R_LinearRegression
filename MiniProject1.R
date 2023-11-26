# Use 'train.csv' to create a data set called HPrice_Train in R

HPrice_Train = read.csv("train.csv", stringsAsFactors=TRUE)


# Do initial checks to see whether the dataset is created correctly (i.e. check
# whether ‘HPrice_Train’ is a data frame, str(), dim(), head(), names() of the
# data set etc.)

is.data.frame(HPrice_Train)
str(HPrice_Train)
dim(HPrice_Train)
head(HPrice_Train)
names(HPrice_Train)


# Retain only the following variables: "Id", "MSSubClass", "MSZoning",
# "LotFrontage", "LotArea", "LotConfig", "OverallQual", "YearBuilt",
# "TotalBsmtSF", "CentralAir", "GrLivArea", "FullBath", "HalfBath",
# "BedroomAbvGr", "GarageArea", "SalePrice". You can call the new data
# HPrice_Train1

var_keep = c("Id", "MSSubClass", "MSZoning", "LotFrontage", "LotArea",
              "LotConfig", "OverallQual", "YearBuilt", "TotalBsmtSF",
              "CentralAir", "GrLivArea", "FullBath", "HalfBath", "BedroomAbvGr",
              "GarageArea", "SalePrice")

HPrice_Train1 = HPrice_Train[var_keep]


# Check the structure, summary, and first few observations of HPrice_Train1

str(HPrice_Train1)
summary(HPrice_Train1)
head(HPrice_Train1)


# Create dummy variables for variables that are factor – library called caret
# may be used for creating dummy variables. This can be saved as HPrice_Train2
# ----- print first 6 observations of HPrice_Train2

library(caret)

dmy = dummyVars(~ ., data = HPrice_Train1, fullRank = T)
HPrice_Train2 = data.frame(predict(dmy, newdata = HPrice_Train1))
head(HPrice_Train2)


# Get a best fitting Regression of SalePrice on relevant variables - Retain
# variables for which coefficients are significant at 15% (feel free to use
# stepwise regression to identify significant variables)

library(MASS)

lm1 = lm(SalePrice ~ ., data = HPrice_Train2)
step_lm1 = stepAIC(lm1, direction = 'both', trace = F)


# Report R-square, Coefficients and p-values (i.e. summary of regression result)

summary(step_lm1)
# Multiple R-squared:  0.7849


# Plot residual plots to see whether (i) the assumption of normality is
# satisfied, (ii) any observation is influencing the results significantly

par(mfrow=c(2,2))
plot(step_lm1)

# Normal Q-Q plots shows that most of the observations are along the line (some
# minor deviations at the beginning and ending of the line are expected).
# However, we need to watch out for observations 524 and 1299.

# Residual vs Leverage plot shows that the observation 1299 is outside the cook
# distance line of 1 -- clearly an outlier. Observation 524 is closer to the
# cook distance of 0.5 -- maybe treated as outlier.

# Removing outliers

HPrice_Train2 = HPrice_Train2[-c(524, 1299),]

# Re-running regression to finalize model

lm2 = lm(SalePrice ~ ., data = HPrice_Train2)
step_lm2 = stepAIC(lm2, direction = 'both', trace = F)

summary(step_lm2)
# Multiple R-squared:  0.8441


# Get the predicted values and Error for observations in the dataset,
# HPrice_Train2 --- print first 6 observations to show the predicted values

HPrice_Train2$Predicted = predict(step_lm2, newdata = HPrice_Train2,
                                  type = 'response')
head(HPrice_Train2)


# Calculate Root Mean Square Error (RMSE), Mean Absolute Error (MAE), Mean
# Percent Error(MPE) and Mean Absolute Percent Error(MAPE).

library(forecast)

accuracy(HPrice_Train2$Predicted, HPrice_Train2$SalePrice)
# Root Mean Square Error (RMSE): 32936.25
# Mean of Absolute Error (MAE): 23170.25
# Mean of Percent Error (MPE): -1.030967
# Mean of Absolute Percent Error (MAPE): 14.21038


# Get the predicted values in the test sample. Make sure to follow the following
# steps before prediction

# (a) Use 'test.csv' to create a data set called HPrice_Test in R

HPrice_Test = read.csv("test.csv", stringsAsFactors=TRUE)
dim(HPrice_Test)


# (b) Retain only the following variables: "Id", "MSSubClass", "MSZoning",
# "LotFrontage", "LotArea", "LotConfig", "OverallQual", "YearBuilt",
# "TotalBsmtSF", "CentralAir", "GrLivArea", "FullBath", "HalfBath",
# "BedroomAbvGr", "GarageArea". You can call the new data HPrice_Test1 (remember
# test data does not contain “SalePrice”)

var_keep = c("Id", "MSSubClass", "MSZoning", "LotFrontage", "LotArea",
             "LotConfig", "OverallQual", "YearBuilt", "TotalBsmtSF",
             "CentralAir", "GrLivArea", "FullBath", "HalfBath", "BedroomAbvGr",
             "GarageArea")

HPrice_Test1 = HPrice_Test[var_keep]


# (c) Create dummy variables for variables that are factor – library called
# caret may be used for creating dummy variables. This can be saved as
# HPrice_Test2

dmy = dummyVars(~ ., data = HPrice_Test1, fullRank = T)
HPrice_Test2 = as.data.frame(predict(dmy, newdata = HPrice_Test1))
head(HPrice_Test2)


# (d) Now, you can use this dataset (HPrice_Test2) to make the prediction

HPrice_Test2$Predicted = predict(step_lm2, newdata = HPrice_Test2,
                                 type = 'response')
head(HPrice_Test2)
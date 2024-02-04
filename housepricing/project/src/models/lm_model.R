library(data.table)
library(Metrics)
library(caret)

set.seed(77)

# access files
train <- fread('./housepricing/project/volume/data/interim/train.csv')
test <- fread('./housepricing/project/volume/data/interim/test.csv')
submission <- fread('./housepricing/project/volume/data/raw/example_sub.csv')


# initialize y vector, remove NA values from test set, and combine
y_train = train$SalePrice

test$SalePrice <- as.numeric(test$SalePrice)
test$SalePrice = 10

master <- rbind(train,test)

#test
dummies <- dummyVars(SalePrice ~ ., data = master)
train <- predict(dummies, newdata = train)
test <- predict(dummies, newdata = test)

train <- data.table(train)
train$SalePrice <- y_train
test <- data.table(test)

lm_model <- lm(SalePrice~ ., data=train)
summary(lm_model)

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
y_test = submission$SalePrice

test$SalePrice <- as.numeric(test$SalePrice)
test$SalePrice = 0

master <- rbind(train,test)


#test
dummies <- dummyVars(SalePrice ~ Qual + Cond, data = master)
train <- predict(dummies, newdata = train)
test <- predict(dummies, newdata = test)

train <- data.table(train)
test <- data.table(test)
train$SalePrice <- y_train

lm_model <- lm(SalePrice~ ., data=train)
summary(lm_model)

# save submission
test$SalePrice <- predict(lm_model, newdata=test)
submission$SalePrice <- test$SalePrice
fwrite(submission, './housepricing/project/volume/data/processed/submission.csv')

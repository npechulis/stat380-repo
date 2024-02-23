library(data.table)

set.seed(77)


# access files
train <- fread('./project/volume/data/interim/train.csv')
test <- fread('./project/volume/data/interim/test.csv')

# make qual and cond variables easier to work with since letters don't matter
test$Qual <- as.numeric(gsub("[^0-9]", "", test$Qual))
test$Cond <- as.numeric(gsub("[^0-9]", "", test$Cond))
train$Qual <- as.numeric(gsub("[^0-9]", "", train$Qual))
train$Cond <- as.numeric(gsub("[^0-9]", "", train$Cond))

# begin regression and review summary
input <- train[,c("LotArea","FullBath","HalfBath","TotRmsAbvGrd","TotalBsmtSF","BedroomAbvGr","GrLivArea","Age", 'YrSold','SalePrice', 'Qual', 'Cond')]
lm_model = lm(SalePrice~LotArea+FullBath+HalfBath+TotRmsAbvGrd+TotalBsmtSF+BedroomAbvGr+GrLivArea+Age+YrSold+Qual+Cond, data=input)
#summary(lm_model)


# apply our model to test data set
test$SalePrice<-predict(lm_model,newdata = test[,.(LotArea,FullBath,HalfBath,TotRmsAbvGrd,TotalBsmtSF,BedroomAbvGr,GrLivArea,Age,YrSold,Qual,Cond)])

# make numeric id column so that final submission values match
test[, NumericId := as.numeric(gsub("test_", "", Id))]
submission <- test[order(NumericId), .(Id, SalePrice)]

# write final submission file and save model
fwrite(submission, './project/volume/data/processed/submission.csv')
saveRDS(lm_model,"./project/volume/data/processed/final_lm_model.txt")


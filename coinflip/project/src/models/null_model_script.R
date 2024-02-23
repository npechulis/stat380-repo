library(data.table)

train <- fread('./project/volume/data/interim/train.csv')
test <- fread('./project/volume/data/interim/test.csv')

# guess 0.5 for every one as null submission
test$result = 0.5
null_submit = test[, c('id', 'result')]
fwrite(null_submit,"./project/volume/data/processed/null_submit.csv")

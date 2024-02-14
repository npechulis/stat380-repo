library(data.table)

train <- fread('./coinflip/project/volume/data/interim/train.csv')
test <- fread('./coinflip/project/volume/data/interim/test.csv')

test$result = 0.5
null_submit = test[, c('id', 'result')]
fwrite(null_submit,"./coinflip/project/volume/data/processed/null_submit.csv")

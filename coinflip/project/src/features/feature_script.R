library(data.table)

train <- fread('./coinflip/project/volume/data/raw/train_file.csv')
test <- fread('./coinflip/project/volume/data/raw/test_file.csv')

# No data cleaning necessary

fwrite(train, './coinflip/project/volume/data/interim/train.csv')
fwrite(test, './coinflip/project/volume/data/interim/test.csv')

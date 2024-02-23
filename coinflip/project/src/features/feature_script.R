library(data.table)

train <- fread('./project/volume/data/raw/train_file.csv')
test <- fread('./project/volume/data/raw/test_file.csv')

# No data cleaning necessary

fwrite(train, './project/volume/data/interim/train.csv')
fwrite(test, './project/volume/data/interim/test.csv')

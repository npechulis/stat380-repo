library(data.table)
housedata <- fread('./housepricing/project/volume/data/raw/Stat_380_housedata.csv')
qctable <- fread('./housepricing/project/volume/data/raw/Stat_380_QC_table.csv')

set.seed(77)

# merge data sets
merged_data <- merge(housedata, qctable, all.x=T)

# remove lot frontage since it has null values and isn't very useful
merged_data <- merged_data[, LotFrontage := NULL]

# make train and test sets and move to interim
train <- merged_data[grep("train_", merged_data$Id), ]
test <- merged_data[grep("test_", merged_data$Id), ]

fwrite(train[, c('Id', 'LotArea', 'TotRmsAbvGrd', 'GrLivArea', 'BedroomAbvGr', 'SalePrice'), with=F], './housepricing/project/volume/data/interim/train.csv')
fwrite(test[, c('Id', 'LotArea', 'TotRmsAbvGrd', 'GrLivArea', 'BedroomAbvGr', 'SalePrice'), with=F], './housepricing/project/volume/data/interim/test.csv')

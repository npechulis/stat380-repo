library(data.table)
housedata <- fread('./housepricing/project/volume/data/raw/Stat_380_housedata.csv')
qctable <- fread('./housepricing/project/volume/data/raw/Stat_380_QC_table.csv')

set.seed(77)

# merge data sets
merged_data <- merge(housedata, qctable, all.x=T)

# make train and test sets and also create age column
train <- merged_data[grep("train_", merged_data$Id), ]
test <- merged_data[grep("test_", merged_data$Id), ]
train[, 'Age':= YrSold - YearBuilt]
test[, 'Age':= YrSold - YearBuilt]


# shorten the table to include only variables I'm using and write to interim
fwrite(train[, c('Id', 'LotArea', 'FullBath', 'HalfBath', 'TotRmsAbvGrd', 'TotalBsmtSF', 'BedroomAbvGr', 'GrLivArea', 'YrSold','SalePrice', 'Qual', 'Cond', 'Age'), with=F], './housepricing/project/volume/data/interim/train.csv')
fwrite(test[, c('Id', 'LotArea','FullBath', 'HalfBath', 'TotRmsAbvGrd', 'TotalBsmtSF', 'BedroomAbvGr', 'GrLivArea', 'YrSold','SalePrice', 'Qual', 'Cond', 'Age'), with=F], './housepricing/project/volume/data/interim/test.csv')

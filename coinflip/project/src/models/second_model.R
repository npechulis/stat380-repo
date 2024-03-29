library(data.table)

train <- fread('./project/volume/data/interim/train.csv')
test <- fread('./project/volume/data/interim/test.csv')

# fit logistic regression model
glm_model = glm(result ~ V1+V2+V3+V4+V5+V6+V7+V8+V9+V10, family=binomial,data=train)
#summary(glm_model)

test$result <- predict(glm_model, newdata=test, type='response')

# create submission file and save model
second_submission = test[, c('id', 'result')]
fwrite(second_submission,"./project/volume/data/processed/second_submission.csv")

saveRDS(glm_model, './project/volume/models/glm.model')


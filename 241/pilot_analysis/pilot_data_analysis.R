library(readr)
library(data.table)
library(stargazer)
library(sandwich)
library(lmtest)
library(knitr)
library(here)


# =========================
# LOAD DATA
# =========================
d_rds = readRDS(here("data","processed","clean_pilot_data_zr.rds"))
d = d_rds[keep_flag == 1]

#My interpretation is it’s mostly to make sure everything is working as expected, we aren't seeing attrition between groups, etc, anything that would prompt us to adjust our survey design at all

#To add to what Ryan says, I would estimate the ATE in multiple regressions (without covariates and with) to see if we get any effect. Probably our power is too low, but at least we could see how the coefficients are impacted by adding covariates. (Running it the way we think we will, like Gerardo said with clustered errors). I might run separate regressions for accurate, authentic, and believable to see if things are different for these different aspects of credibility. What do you think?



# =========================
# DESCRIPTIVE STATISTICS
# =========================

# Key variables summary
vars <- c("expert_trust_index",
          "health_engagement_index",
          "meat_exp_cred",
          "meat_infl_cred",
          "oil_exp_cred",
          "oil_infl_cred",
          "oil_cred",
          "meat_cred")

stargazer(
  as.data.frame(d[, ..vars]),
  type = "text",
  header = FALSE,
  title = "Descriptive Statistics for Pilot Variables",
  summary.stat = c("mean","sd","min","max")
)

#Count of missing values
lapply(d[, ..vars], function(x) sum(is.na(x)))


# =========================
# HISTOGRAMS
# =========================

hist(d$expert_trust_index,
     main = "Trust in Experts",
     xlab = "Index")

hist(d$meat_exp_cred,
     main = "Meat Expert Credibility",
     xlab = "Credibility")

hist(d$meat_infl_cred,
     main = "Meat Influencer Credibility",
     xlab = "Credibility")

hist(d$oil_exp_cred,
     main = "Oil Expert Credibility",
     xlab = "Credibility")

hist(d$oil_infl_cred,
     main = "Oil Influencer Credibility",
     xlab = "Credibility")

# =========================
# PAIRED T-TESTS
# =========================

# Meat condition
t_meat <- t.test(d$meat_exp_cred,
                d$meat_infl_cred,              paired = FALSE)
print(t_meat)
#not significant difference between meat expert credibility and meat influencer credibility


# Oil condition
t_oil <- t.test(d$oil_exp_cred,
                d$oil_infl_cred,
                paired = FALSE)

print(t_oil)
#Not significant difference between oil expert credibility and oil influencer credibility



# =========================
# REGRESSION ANALYSIS
# =========================

# Oil credibility models
# -------------------------
# 1. Baseline model
# -------------------------
model_oil_1 <- lm(oil_cred ~ post_oil_source, data = d)
coeftest(model_oil_1, vcov = vcovHC(model_oil_1, type = "HC1"))

# -------------------------
# 2. Add main covariates
# -------------------------
model_oil_2 <- lm(
  oil_cred ~ post_oil_source + expert_trust_index + health_engagement_index,
  data = d
)
coeftest(model_oil_2, vcov = vcovHC(model_oil_2, type = "HC1"))

# -------------------------
# 3. Add demographics
# -------------------------
model_oil_3 <- lm(
  oil_cred ~ post_oil_source + expert_trust_index + health_engagement_index +
    age + gender + education,
  data = d
)
coeftest(model_oil_3, vcov = vcovHC(model_oil_3, type = "HC1"))

# -------------------------
# 4. Interaction model
# -------------------------
model_oil_4 <- lm(
  oil_cred ~ post_oil_source * expert_trust_index + health_engagement_index,
  data = d
)
coeftest(model_oil_4, vcov = vcovHC(model_oil_4, type = "HC1"))

# -------------------------
# 5. Fully interacted covariates
# -------------------------
model_oil_5 <- lm(
  oil_cred ~ post_oil_source * (expert_trust_index + health_engagement_index),
  data = d
)
coeftest(model_oil_5, vcov = vcovHC(model_oil_5, type = "HC1"))

#Meat credibility model
model_meat <- lm(meat_cred ~ post_meat_source + expert_trust_index + age, data = d)
robust_se <- sqrt(diag(vcovHC(model_meat, type = "HC1")))
coeftest(model_meat, vcov = vcovHC(model_meat))

# -------------------------
# 1. Baseline model
# -------------------------
model_meat_1 <- lm(meat_cred ~ post_meat_source, data = d)
coeftest(model_meat_1, vcov = vcovHC(model_meat_1, type = "HC1"))

# -------------------------
# 2. Add main covariates
# -------------------------
model_meat_2 <- lm(
  meat_cred ~ post_meat_source + expert_trust_index + health_engagement_index,
  data = d
)
coeftest(model_meat_2, vcov = vcovHC(model_meat_2, type = "HC1"))

# -------------------------
# 3. Add demographics
# -------------------------
model_meat_3 <- lm(
  meat_cred ~ post_meat_source + expert_trust_index + health_engagement_index +
    age + gender + education,
  data = d
)
coeftest(model_meat_3, vcov = vcovHC(model_meat_3, type = "HC1"))

# -------------------------
# 4. Interaction model
# -------------------------
model_meat_4 <- lm(
  meat_cred ~ post_meat_source * expert_trust_index + health_engagement_index,
  data = d
)
coeftest(model_meat_4, vcov = vcovHC(model_meat_4, type = "HC1"))

# -------------------------
# 5. Fully interacted covariates
# -------------------------
model_meat_5 <- lm(
  meat_cred ~ post_meat_source * (expert_trust_index + health_engagement_index),
  data = d
)
coeftest(model_meat_5, vcov = vcovHC(model_meat_5, type = "HC1"))

library(stargazer)

stargazer(
  model_meat_1, model_meat_2, model_meat_3, model_meat_4, model_meat_5,
  model_oil_1, model_oil_2, model_oil_3, model_oil_4, model_oil_5,
  type = "latex",   # change to "text" if not using LaTeX
  title = "Regression Results: Meat and Oil Credibility Models",
  column.labels = c(
    "Meat 1","Meat 2","Meat 3","Meat 4","Meat 5",
    "Oil 1","Oil 2","Oil 3","Oil 4","Oil 5"
  ),
  dep.var.labels = c("Credibility"),
  covariate.labels = c(
    "Post Source (Expert=1)",
    "Expert Trust Index",
    "Health Engagement Index",
    "Age",
    "Gender",
    "Education"
  ),
  omit.stat = c("f","ser"),
  no.space = TRUE
)



# =========================
# ATTRITION ANALYSIS
# =========================

library(data.table)

# -------------------------
# 1. Overall attrition rate
# -------------------------
table(d$complete)
mean(d$complete == 1, na.rm = TRUE)

# -------------------------
# 2. Attrition by treatment (Meat)
# -------------------------
# Counts
table(d$post_meat_source, d$complete)

# Row proportions (completion rates within each group)
prop.table(table(d$post_meat_source, d$complete), 1)

# Statistical test
t.test(complete ~ post_meat_source, data = d)

# Regression check
lm(complete ~ post_meat_source, data = d)

# -------------------------
# 3. Attrition by treatment (Oil)
# -------------------------
# Counts
table(d$post_oil_source, d$complete)

# Row proportions
prop.table(table(d$post_oil_source, d$complete), 1)

# Statistical test
t.test(complete ~ post_oil_source, data = d)

# Regression check
lm(complete ~ post_oil_source, data = d)

# -------------------------
# 4. Attrition with controls (optional)
# -------------------------
lm(complete ~ post_meat_source + age + gender + expert_trust_index, data = d)
lm(complete ~ post_oil_source + age + gender + expert_trust_index, data = d)

# -------------------------
# 5. Check filtering / analysis sample
# -------------------------
table(d$keep_flag)

# Attrition vs keep_flag
table(d$keep_flag, d$complete)
prop.table(table(d$keep_flag, d$complete), 1)









# STUDENT PERFORMANCE ANALYSIS
# Dataset: UCI Student Performance Dataset (Math + Portuguese)
# Goal: Predict final grade (G3) using study habits, lifestyle & prior grades

# 1. PACKAGE SETUP
# Install packages only if they are not already installed
library(tidyverse)   # Data manipulation and visualization (includes ggplot2)
library(psych)       # Descriptive statistics
library(estimatr)    # Robust regression

# 2. LOAD DATA
# Two separate CSV files for Math and Portuguese courses, both semicolon-separated
# Filenames match sources: student-mat.csv and student-por.csv
data_math <- read.csv("student-mat.csv", sep = ";")
data_port <- read.csv("student-por.csv", sep = ";")

# Combine both datasets into one (they share the same 33-column structure) 
data <- rbind(data_math, data_port)

# 3. DATA OVERVIEW
# Quick inspection of structure, types, and summary statistics
head(data)       # First 6 rows
str(data)        # Column types and structure
summary(data)    # Min, max, mean, and quartiles for each column

# 4. FEATURE ENGINEERING
# Create two new variables to enrich the analysis:
#   - avg_grade: average of first and second period grades (G1, G2)
#   - study_per_failure: study time relative to number of failures (avoids division by 0)
data <- data %>%
  mutate(
    avg_grade = (G1 + G2) / 2,
    study_per_failure = studytime / (failures + 1))

# 5. CONVERT CATEGORICAL VARIABLES TO FACTORS
# R regression and plotting functions handle factors correctly
factor_vars <- c("sex", "school", "address", "famsize", "Pstatus",
                 "Mjob", "Fjob", "reason", "guardian", "schoolsup",
                 "famsup", "paid", "activities", "nursery", "higher",
                 "internet", "romantic")

data[factor_vars] <- lapply(data[factor_vars], as.factor)

# 6. FILTER DATA
# Focus on students with studytime > 2 (moderate-to-high study effort)
# This removes low-engagement students to reduce noise in the regression model
student <- data %>%
  filter(studytime > 2)

# 7. DESCRIPTIVE STATISTICS
# Summarise key numeric variables for the filtered group
describe(student[, c("G3", "avg_grade", "studytime", "failures",
                     "absences", "study_per_failure")])

# 8. LINEAR REGRESSION MODEL
# Predicting final grade (G3) from academic and lifestyle variables
model <- lm(G3 ~ avg_grade + studytime + failures + absences +
              sex + freetime + goout + Dalc + Walc + health,
            data = student)

summary(model)   # Coefficients, R-squared, p-values

# 9. MODEL DIAGNOSTIC PLOTS
# Check regression assumptions: linearity, normality, and homoscedasticity
par(mfrow = c(2, 2))   # Arrange 4 plots in a 2x2 grid
plot(model)
par(mfrow = c(1, 1))   # Reset to single plot layout

# 10. VISUALISATIONS
# Explore key relationships between predictors and final grade (G3)

# Plot 1: Final Grade vs Average of G1 & G2
ggplot(student, aes(x = avg_grade, y = G3)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Final Grade vs Average Previous Grades",
    x     = "Average of G1 and G2",
    y     = "Final Grade (G3)")

# Plot 2: Final Grade vs Number of Past Failures
ggplot(student, aes(x = failures, y = G3)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Final Grade vs Number of Failures",
    x     = "Past Failures",
    y     = "Final Grade (G3)")

# Plot 3: Final Grade vs Study Time
ggplot(student, aes(x = studytime, y = G3)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Final Grade vs Study Time",
    x     = "Study Time (Level 3-4)",
    y     = "Final Grade (G3)")

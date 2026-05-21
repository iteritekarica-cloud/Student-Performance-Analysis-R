This project predicts final academic grades (G3) for secondary school students using a dataset of 1,044 records from Mathematics and Portuguese courses. The analysis focuses on identifying how academic history and social habits impact students who report moderate-to-high study efforts.
Technical Workflow

* Data Merging: Combined `student-mat.csv` and `student-por.csv` to analyze universal trends across subjects.
* Filtering: Focused on students with `studytime > 2` to isolate factors affecting those already putting in significant effort.
* Feature Engineering: Created `avg_grade` (mean of G1 and G2) and a `study_per_failure` resilience ratio.
* Modeling: Fitted a multiple linear regression model testing variables like absences, failures, and alcohol consumption (`Dalc`, `Walc`).
Key Findings
1. Model Performance
The regression model achieved a Multiple R-squared of 0.814, meaning it explains over 81% of the variance in final grades.
2. Predictors of Success

* Academic Momentum: For every 1-point increase in a student's early-semester average (`avg_grade`), the final grade is predicted to increase by 1.16 points.
* Past Failures: Historical setbacks (`failures`) have a negative impact on the final result (-0.38), even for students currently studying at high levels.
* Diminishing Returns: In this high-study group, simply adding more study hours (`studytime`) showed a slightly negative coefficient (-0.45), indicating that the quality of prior performance is a stronger driver than the quantity of time spent.
Visualizations
Prior Performance vs Final Grade
Shows the strong linear correlation between early-semester averages and the final G3 grade.
Past Failures Impact
Visualizes how a history of class failures correlates with lower final outcomes.
Social Habits and Grades
Explores the relationship between leisure time and academic results in the high-study subset.
Project Structure

* analysis.R: The full R script including data cleaning, filtering, and modeling.
* output/regression_results.txt: The raw mathematical summary of the linear model.
* output/*.png: Exported plots from the analysis.
Dataset
Data sourced from the [UCI Student Performance Dataset](https://www.google.com/url?sa=E&q=https%3A%2F%2Farchive.ics.uci.edu%2Fml%2Fdatasets%2Fstudent%2Bperformance) covering attributes such as family background, social activities, and health.

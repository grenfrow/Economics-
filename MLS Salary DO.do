/*


*/
import excel "C:\Users\grady\Desktop\Econometrics\Research Paper\MLS Salary.xls", sheet("Sheet1") firstrow

import excel "C:\Users\grady\Desktop\Econometrics\Research Paper\MLS Salary FE OriginalClubs.xlsx", sheet("Sheet1") firstrow


/* Goal Differential*/
gen GoalDiff = GoalsFor / GoalsAgainst

/*Destring and rename*/
destring Total, generate (Total_n) force
drop Total 
rename Total_n Total 
encode Position, generate(Position_n)
drop Position
rename Position_n Position
encode Club, generate(Club_n)
drop Club
rename Club_n Club

/*Remove unwanted columns */
drop Base

/*Aggregate total salary by position */ 
collapse (sum) Total, by (Season Club Position Points GoalDiff Playoff MLSCup SupportersShield SalaryCap)

order Season Club Position Total Points GoalDiff

/* Reshape for xtset */
gen GK = .
gen DEF = .
gen MID = .
gen FWD = .

replace GK = Total if Position == 5
replace DEF = Total if Position == 1
replace MID = Total if Position == 7
replace FWD = Total if Position == 3

/*Modiy salaries by $100,000*/ 
gen GK_n = GK / 100000
gen DEF_n = DEF / 100000
gen MID_n = MID / 100000
gen FWD_n = FWD / 100000
gen Total_n = Total / 100000

/*Descriptive Statistics*/
summarize GK
summarize DEF
summarize MID
summarize FWD
summarize Points
summarize GoalDiff

mean Points if Playoff == 1

/*Remove unwanted columns*/ 
drop Position 

/*Collapse to yearly club observations  */
collapse Points Total GK_n DEF_n MID_n FWD_n GoalDiff Playoff MLSCup SupportersShield SalaryCap, by (Club Season)

/* For testing using natural log*/
gen ln_GK = log(GK)
gen ln_DEF = log(DEF)
gen ln_MID = log(MID)
gen ln_FWD = log(FWD)

/* Scatter plot Points vs. Total*/
predict PredictedSalary, xb 
twoway (scatter Points Total) (line PredictedSalary Total)

/* Scatter plot Points vs Goal Differential*/ 
predict GDpred, xb
twoway (scatter Points GoalDiff) (line GDpred GoalDiff)

/*Histogram of Total*/
 histogram Total, frequency fcolor(ltblue) lcolor(ltblue) kdensity

/*Regress Points on Salary Total*/
reg Points Total_n

/*Regress Points on Salary Totals by Position*/ 
reg Points GK_n DEF_n MID_n FWD_n

/*xtset */ 
xtset Club Season, yearly

/* xt reg */
xtreg Points GK_n DEF_n MID_n FWD_n, fe cluster(Club) robust

/* xt reg with other controls */ 

xtreg Points GK_n DEF_n MID_n FWD_n GoalDiff, fe cluster(Club) robust



##
MLS_Salary <- read_excel("Desktop/Econometrics/Research Paper/MLS Salary.xlsx", 
                         +     col_types = c("numeric", "text", "text", 
                                             +         "numeric", "text", "numeric", "numeric", 
                                             +         "numeric", "numeric", "numeric", 
                                             +         "numeric", "numeric", "numeric", 
                                             +         "numeric", "numeric", "numeric", 
                                             +         "numeric"))
##
library(dplyr)

## Create the Salary share by position: 
MLS <- MLS_Salary %>% group_by(Season,Club,Position, Points, `Goals For`,`Goals Against`, Playoff, `MLS Cup`, `Supporters Shield`) %>% summarise (Pos.Total = sum(Total))

## Create Goal Diff Variable:
MLS$G.Diff <- MLS$`Goals For`/MLS$`Goals Against`

## Create the values:
G.Diff <- MLS$`Goals For`/MLS$`Goals Against`
GF <- MLS$`Goals For`
GA <- MLS$`Goals Against`


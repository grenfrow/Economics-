## Miami Marlins
Marlins <- Marlins_Park_1_mile_radius_retail
ts.Marlins <- ts(Marlins$`All Service Type Rent Overall`)
rev.ts.Marlins <- ts((rev(ts.Marlins)), start = 2006 , frequency = 4)
plot((rev.ts.Marlins), main = "Marlins Retail Prices 1 Mile Radius" , ylab = "Rent per SF")

diff.Marlins <- diff(rev.ts.Marlins)


## San Diego Padres 
Padres <- Petco_Park_1_mile_retail_radius
ts.Padres <- ts(Padres$`All Service Type Rent Overall`)
rev.ts.Padres <- ts((rev(ts.Padres)), start = 2006 , frequency = 4)
plot((rev.ts.Padres), main = "Padres Retail Prices 1 Mile Radius" , ylab = "Rent per SF")

## Minnesota Twins 
Twins <- Target_Field_1_mile_retail_radius
ts.Twins <- ts(Twins$`All Service Type Rent Overall`)
rev.ts.Twins <- ts((rev(ts.Twins)), start = 2006 , frequency = 4)
plot((rev.ts.Twins), main = "Twins Retail Prices 1 Mile Radius" , ylab = "Rent per SF")

## Atlants Braves
Braves <- Suntrust_Park_2_mile_retail_radius
ts.Braves <- ts(Braves$`All Service Type Rent Overall`)
rev.ts.Braves <- ts((rev(ts.Braves)), start = 2000 , frequency = 4)
plot((rev.ts.Braves), main = "Braves Retail Prices 1 Mile Radius" , ylab = "Rent per SF")


##The Nationals 
Nats_Park_1_mile_radius_retail_history <- read_excel("Desktop/GWU/Applied Economics/Time Series/Research Paper/Nats Park Data Pull/Nats Park 1 mile radius retail history.xls")
View(Nats_Park_1_mile_radius_retail_history)
Nationals <-  Nats_Park_1_mile_radius_retail_history
ts.Nationals <- ts(Nationals$`All Service Type Rent Overall`)
rev.ts.Nationals <- ts((rev(ts.Nationals)),start = 2006 , frequency = 4) 
plot((rev.ts.Nationals), main = "Nationals Retail Prices 1-Mile Radius" , ylab = "Rent per SF")

diff.Nationals <- diff(rev.ts.Nationals)
plot((diff.Nationals), main = "Differenced Nationals 1-Mile Retail")
acf(diff.Nationals)

Fit111 <- arima(rev.ts.Nationals, order = c(1,1,1))
Fit118 <- arima(rev.ts.Nationals, order = c(1,1,8))
Fit811 <- arima(rev.ts.Nationals, order = c(8,1,1))
Fit818 <- arima(rev.ts.Nationals, order = c(8,1,8))

AIC(Fit111) ; AIC(Fit118) ;AIC(Fit811) ;AIC(Fit818)

Fit <- arima(rev.ts.Nationals, order = c(8,1,1))
ar.mod <-  predict(Fit, n.ahead = 20)
ar.mod.ts <- ts(ar.mod$pred, start = 2018, frequency = 4)
plot(ar.mod.ts)

ts.plot(rev.ts.Nationals, ar.mod.ts, lty = 1:3, col = c("black", 'red'), lwd=c(2,2),main = "Original Nationals and Forecasted")


## Marlins Testing 
MarlinsR <-  Marlins_Park_1_mile_radius_retail
MarlinsO <- Marlins_Park_1_mile_radius_office
ts.Office <- ts(MarlinsR$`All Service Type Rent Overall`)
ts.Retail <- ts(MarlinsR$`All Service Type Rent Overall`)
ts.Office <- ts(MarlinsO$`Office Gross Rent Overall`)

ts.Office <- ts((rev(ts.Office)), start = 1999, frequency = 4)
ts.Retail <- ts((rev(ts.Retail)), start = 2006, frequency = 4)
plot((ts.Office), main = "Marlins Office 1999 - 2018")
plot((ts.Retail), main = "Marlins Retail 2006 - 2018")
diff.Office <- diff(ts.Office)
diff.Retail <- diff(ts.Retail)
plot((diff.Office), main = "Office Differenced")
plot((diff.Retail), main = "Retail Differenced")
acf(diff.Office)
acf(diff.Retail)
                                              
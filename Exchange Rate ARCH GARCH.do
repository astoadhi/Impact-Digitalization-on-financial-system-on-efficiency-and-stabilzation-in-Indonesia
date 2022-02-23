*Exchange Rate
*rasio


*ARCH Effect
regres LNER
estat archlm, lags(1 2 3 4)
*Estimating new dependent variable
arch LNER, arima (1 1 0) arch(1)garch(1) nolog 
*choosing by smallest bic score for the arima model)
predict newdep,variance

ardl newdepp KREDIT DEBIT INTRA INTER ELMON LNOIL, bic ec maxcombs(10000000) dots 
estat ectest

arch lnc_3, arima (2 1 0) arch(1) nolog 
estat ic

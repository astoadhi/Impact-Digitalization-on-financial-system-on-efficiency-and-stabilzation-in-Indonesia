*Payment Stability
*optimal lag
varsoc c_3 // exchange rate
varsoc v_2 // nominal transaksi kartu kredit
varsoc v_4 // nominal belanja debit
varsoc v_6 // nominal transfer intra bank debet
varsoc v_8 // nominal transfer antarbank debet
varsoc c_9 // oil price
varsoc c_8 // inflation
varsoc rue // nominal uang elektronik

//Dependent Exchange rate (firstdiff edition)
ardl c_3d lnv_2d lnv_4d lnv_6d lnv_8d c_9d lnrued, aic maxcombs(10000000) dots

ardl c_3d lnv_2d lnv_4d lnv_6d lnv_8d c_9d lnrued, aic ec dots maxcombs(10000000) 
estat ectest

cusum6 lnc_3d v_2d v_4d v_6d v_8d c_9d rue , cs(cusum) lw(lower) uw(upper)
drop cusum lower upper

*dependent Inflation
varsoc c_8 
varsoc v_2 
varsoc v_4 
varsoc v_6 
varsoc v_8 
varsoc c_9

*dependent Inflation (firstdiff edition)
varsoc c_8d 
varsoc lnv_2d 
varsoc lnv_4d 
varsoc lnv_6d 
varsoc lnv_8d 
varsoc c_9d

ardl c_8d lnv_2d lnv_4d lnv_6d lnv_8d c_9d lnrued, maxcomb(10000000) aic dots 

ardl c_8d lnv_2d lnv_4d lnv_6d lnv_8d c_9d lnrued , aic ec dots maxcomb(10000000)
estat ectest


drop cusum lower upper


*Payment Efisiensi

*pemilihan lag terbaik
varsoc ccvol 
varsoc c_1 
varsoc c_2 
varsoc c_3 
varsoc c_4 
varsoc c_5
varsoc rue

*firstdiff edition
varsoc lnccvold 
varsoc c_1d 
varsoc c_2d 
varsoc c_3d 
varsoc c_4d 
varsoc c_5d
varsoc lnrued

	
ardl c_6d c_1d c_2d c_3d c_4d , aic  dots 


ardl lnccvold lnrued c_1d c_2d c_3d c_4d c_5d, aic ec dots 
estat ectest
// rued jadi emgd
ardl ccvold emgd c_1d c_2d c_3d c_4d c_5d, aic  dots  regstore(ardl)
estimates restore ardl

cusum6 lnccvold lnv_2 lnv_4 lnv_6 lnv_8 c_9 lnrued, cs(cusum) lw(lower) uw(upper)
drop cusum lower upper

//ARCH test
regres ccvol
estat archlm, lags(1 2 3 4)

arch ccvol, arima (1 1 0) arch(2) nolog
predict variance, variance
predict residual,residual
ardl variance lnc_1 c_2 lnc_3 lnc_4 lnc_5 p5, bic  ec1 dots  regstore(ardl)
ardl variance lnrued c_1d c_2d c_3d c_4d c_5d, aic  ec dots  regstore(ardl)
estat ectest
cusum6 variance lnv_2 lnv_4 lnv_6 lnv_8 c_9 lnrued, cs(cusum) lw(lower) uw(upper)

arch lnccvold, arima (1 1 0) arch(1)  nolog
predict variance, variance
predict residual,residual
ardl variance empd c_1d c_2d c_3d c_4d c_5d, aic  dots  regstore(ardl)
ardl variance empd c_1d c_2d c_3d c_4d c_5d, aic  ec dots  regstore(ardl)
estat ectest

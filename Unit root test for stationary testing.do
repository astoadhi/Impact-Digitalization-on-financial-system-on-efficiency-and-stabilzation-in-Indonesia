gen  m_ts = order + 587
tsset m_ts, monthly

*ln
gen lnv_1 = ln(v_1)
gen lnv_2 = ln(v_2)
gen lnv_3 = ln(v_3)
gen lnv_4 = ln(v_4)
gen lnv_5 = ln(v_5)
gen lnv_6 = ln(v_6)
gen lnv_7 = ln(v_7)
gen lnv_8 = ln(v_8)
gen lnv_9 = ln(v_9)
gen lnv_15 = ln(v_15)
gen lnv_16 = ln(v_16)

*firstdiff

gen lnv_1d = d.lnv_1
gen lnv_2d = d.lnv_2
gen lnv_3d = d.lnv_3
gen lnv_4d = d.lnv_4
gen lnv_5d = d.lnv_5
gen lnv_6d = d.lnv_6
gen lnv_7d = d.lnv_7
gen lnv_8d = d.lnv_8
gen lnv_9d = d.lnv_9
gen lnv_15d = d.lnv_15
gen lnv_16d = d.lnv_16
gen c_1d = d.c_1
gen c_2d = d.c_2
gen c_3d = d.c_3
gen c_4d = d.c_4
gen c_5d = d.c_5
gen c_6d = d.c_6
gen c_7d = d.c_7
gen c_8d = d.c_8
gen c_9d = d.c_9
gen c_11d= d.c11
gen c_13d= d.c13
gen c_14d= d.c_14

*ratio 
gen lnrue  = ln(v_16/v_15) 
gen lnrued = d.lnrue
gen nom = (v_16/(v_1+v_3+v_5+v_7+v_15))

* electronic money growth
gen emp = (v_16/(v_2+v_4+v_6+v_8))
gen emg = (emp-L.emp)/L.emp
gen empd = d.emp
gen emgd = d.emg
	
* credit card tansaction to volume
gen ctv = v_2/v_1
pac ctv
gen lnctv = ln(ctv)

*lag value of ctv
gen lagctv = L.ctv
gen lnlagctv = L.lnctv

* cc volatility
gen  ccvol = (ctv-lagctv)/lagctv
gen lnccvol = (lnctv-lnlagctv)/lnlagctv
gen lnccvold = d.lnccvol

* Table 4: Statistics for ouput, input, price, tc for efficiency analysis
tabstat v_2 v_4 v_6 v_8 v_16 ccvol, s(count mean min max sd sk k ) col(stat)

tabstat c_1 c_2 c_3 c_4 c_5 c_8 c_9 rue, s(count mean min max sd sk k ) col(stat)

tabstat lnc_1 lnc_3 lnc_4 lnc_5 lnc_9, s(count mean min max sd sk k ) col(stat)



line v_1 m_ts
dfuller v_1, trend

* Credit Card Transaction
line v_2 m_ts
dfuller v_2, trend


line v_3 m_ts
dfuller v_3, trend

*Debit Card Transaction
line v_4 m_ts
dfuller v_4, trend

line v_5 m_ts
dfuller v_3, trend

*Intrabank transfer
line v_6 m_ts
dfuller v_6, trend

line v_7 m_ts
dfuller v_7, trend

*Interbank transfer
	
dfuller v_8, trend

line v_15 m_ts
dfuller v_15, trend
dfuller v_15, drift

gen volele = d.v_15
line volele m_ts
dfuller v_15d

* Electronic Payment

line v_16 m_ts
dfuller v_16, trend
dfuller v_16, drift

line CPI m_ts
line BIR m_ts
line EXRA m_ts
line IPI m_ts
line IHSG m_ts
line INFL m_ts
line OIL m_ts
gen nomele = d.v_16
line nomele m_ts
dfuller v_16d


line v_17 m_ts
dfuller v_17, trend
dfuller v_17, drift

gen v_17d = d.v_17
line v_17d m_ts
dfuller v_17d


* Credit card volatility

* credit card tansaction to volume
gen ctv = v_2/v_1
pac ctv

*lag value of ctv
gen lagctv = L.ctv


* cc volatility
gen  ccvol = (ctv-lagctv)/lagctv
dfuller ccvol

line ccvol m_ts
pac ccvol

line ctv m_ts
dfuller ctv, trend
dfuller ctv, drift

** Graph at Level

twoway line v_2 v_4 v_6 v_8 v_16 m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Intra Bank) ///
		label(4 Inter Bank) label(5 Electronic Money) size(vsmall)) ///
		legend(col(3) pos(6)) ///
		name(all, replace) 	

		
		
twoway line v_2 v_4 v_16 m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Electronic Money) size(vsmall)) ///
		legend(col(2) pos(6)) ///
		name(gb1, replace) 	
		
		
twoway line v_6 v_8 m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Intra Bank) ///
		label(2 Inter Bank) size(vsmall)) ///
		legend(col(1) pos(6)) ///
		name(gb2, replace) 	

twoway line ctv m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Credit card nominal to volume", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		name(gb3, replace) 			

		
		
graph	combine gb1 gb2 , c(2)  ///
		graphregion(color(white) lwidth(large)) ///
		name(figure1, replace)
		graph drop gb1 gb2
	
		
graph	combine figure1 gb3 , rows(2)  ///
		graphregion(color(white) lwidth(large)) ///
		name(figure2, replace)
		graph drop figure1 gb3
	
twoway line ccvol m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Credit card volatility", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		name(gb3, replace) 	

		

		
** PPerron Test**

line v_2 m_ts


line v_4 m_ts
pperron v_4, trend

line v_6 m_ts
pperron v_6, trend

line v_8 m_ts
pperron v_8, trend

line v_16 m_ts
pperron v_16, trend

gen v_16d = d.v_16
line v_16d m_ts
pperron v_16d


pperron ccvol



** DFGLS*

line v_2 m_ts
dfgls p1, maxlag(4)

gen v_2d = d.v_2
line v_2d m_ts
dfgls v_2d, maxlag(4)


line v_4 m_ts
dfgls v_4, maxlag(4)

gen v_4d = d.v_4
line v_4d m_ts
dfgls v_4d, maxlag(4)


line v_6 m_ts
dfgls v_6, maxlag(4)

gen v_6d = d.v_6
line v_6d m_ts
dfgls v_6d, maxlag(4)


line v_8 m_ts
dfgls v_8, maxlag(4)

gen v_8d = d.v_8
line v_8d m_ts
dfgls v_8d, maxlag(4)


line v_16 m_ts
dfgls v_16, maxlag(4)

gen v_16d = d.v_16
line v_16d m_ts
dfgls v_16d, maxlag(4)


** KPSS ** Test
kpss v_2d

line v_2 m_ts
kpss v_2

line v_2d m_ts
kpss v_2d


line v_4 m_ts
kpss v_4

line v_4d m_ts
kpss v_4d


line v_6 m_ts
kpss v_6

line v_6d m_ts
kpss v_6d

line v_8 m_ts
kpss v_8

line v_8d m_ts
kpss v_8d


line v_16 m_ts
kpss v_16

line v_16d m_ts
kpss v_16d

gen v_16d2 = L2.v_16

kpss ccvol

* Standard Deviasi

egen SDv2d = sd(v_2d)
egen SDv4d = sd(v_4d)
egen SDv6d = sd(v_6d)
egen SDv8d = sd(v_8d)
egen SDv16d = sd(v_16d)
egen SDcc = sd(ccvol)

list SDv2d SDv4d SDv6d SDv8d SDv16d SDcc in 1/3, table

gen SD3v2d = 3*SDv2d
gen SD3v4d = 3*SDv4d
gen SD3v6d = 3*SDv6d
gen SD3v8d = 3*SDv8d
gen SD3v16d = 3*SDv16d
gen SD3cc = 3*SDcc

list SD3v2d SD3v4d SD3v6d SD3v8d SD3v16d SD3cc in 1/1, table

** Graph at First Difference 
twoway line v_2d v_4d v_6d v_8d v_16d ccvol m_ts,  ///
		graphregion(color(white)) ///
		yline(5794438,lstyle(foreground)) ///
		yline(-5794438,lstyle(foreground)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Intra Bank) ///
		label(4 Inter Bank) label(5 Electronic Money) ///
		label(6 Credit Card Volatility) size(vsmall)) ///
		legend(col(3) pos(6)) ///
		name(all, replace) 	


		
	** Graph at First Difference 
twoway line v_2d v_4d v_6d v_8d v_16d ccvol m_ts,  ///
		graphregion(color(white)) ///
		yline(2.03e+07 ,lstyle(foreground)) ///
		yline(-2.03e+07 ,lstyle(foreground)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Intra Bank) ///
		label(4 Inter Bank) label(5 Electronic Money) ///
		label(6 Credit Card Volatility) size(vsmall)) ///
		legend(col(3) pos(6)) ///
		name(all, replace) 		
		
		
		
twoway line v_2d v_4d v_16d m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Electronic Money) size(vsmall)) ///
		legend(col(2) pos(6)) ///
		name(gbA, replace) 	
		
		
twoway line v_6d v_8d m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Intra Bank) ///
		label(2 Inter Bank) size(vsmall)) ///
		legend(col(1) pos(6)) ///
		name(gbB, replace) 	

twoway line ccvol m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Credit card nominal to volume", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		name(gbC, replace) 			

		
		
graph	combine gbA gbB , c(2)  ///
		graphregion(color(white) lwidth(large)) ///
		name(figureA, replace)
		graph drop gbA gbB
	
		
graph	combine figureA gbC , rows(2)  ///
		graphregion(color(white) lwidth(large)) ///
		name(figureB, replace)
		graph drop figureA gbC
	
twoway line ccvol m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Credit card volatility", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		name(gb3, replace) 	


		
* Log Value of variables:


gen lnv2= ln(v_2)
gen lnv4= ln(v_4)
gen lnv6= ln(v_6)
gen lnv8= ln(v_8)
gen lnv16= ln(v_16)
gen lnvcc= ln(ccvol)

** SD log
egen SDlnv2 = sd(lnv2)
egen SDlnv4 = sd(lnv4)
egen SDlnv6 = sd(lnv6)
egen SDlnv8 = sd(lnv8)
egen SDlnv16 = sd(lnv16)
egen SDlnvcc = sd(lnvcc)

list SDlnv2 SDlnv4 SDlnv6 SDlnv8 SDlnv16 SDlnvcc in 1/1, table


line lnv2 m_ts
gen lnv2d = d.lnv2
line v_2d m_ts
line lnv2d m_ts


line lnv4 m_ts
gen lnv4d = d.lnv4
line v_4d m_ts
line lnv4d m_ts


line lnv6 m_ts
gen lnv6d = d.lnv6
line v_6d m_ts
line lnv6d m_ts

line lnv8 m_ts
gen lnv8d = d.lnv8
line v_8d m_ts
line lnv8d m_ts


line lnv16 m_ts
gen lnv16d = d.lnv16
line v_16d m_ts
line lnv16d m_ts



** SD log
egen SDlnv2d = sd(lnv2d)
egen SDlnv4d = sd(lnv4d)
egen SDlnv6d = sd(lnv6d)
egen SDlnv8d = sd(lnv8d)
egen SDlnv16d = sd(lnv16d)
egen SDlnvccd = sd(lnvcc)

list SDlnv2d SDlnv4d SDlnv6d SDlnv8d SDlnv16d SDlnvccd in 1/1, table

* Tiga kali standar deviasi
* upper bound line
gen SD3 = 3* 1.081152 

drop SD3
list SD3 in 1/1

	** Graph at First Difference on Log Value
twoway line lnv2d lnv4d lnv6d lnv8d lnv16d ccvol m_ts,  ///
		graphregion(color(white)) ///
		yline( 0.5) ///
		yline(-0.5) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Intra Bank) ///
		label(4 Inter Bank) label(5 Electronic Money) ///
		label(6 Credit Card Volatility) size(vsmall)) ///
		legend(col(3) pos(6)) ///
		name(all, replace) 		
		
		
		
twoway line v_2d v_4d v_16d m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Credit Card) ///
		label(2 Debit Card) label(3 Electronic Money) size(vsmall)) ///
		legend(col(2) pos(6)) ///
		name(gbA, replace) 	
		
		
twoway line v_6d v_8d m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Electronic Transaction", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		legend(label(1 Intra Bank) ///
		label(2 Inter Bank) size(vsmall)) ///
		legend(col(1) pos(6)) ///
		name(gbB, replace) 	

twoway line ccvol m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Credit card nominal to volume", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		name(gbC, replace) 			

		
		
graph	combine gbA gbB , c(2)  ///
		graphregion(color(white) lwidth(large)) ///
		name(figureA, replace)
		graph drop gbA gbB
	
		
graph	combine figureA gbC , rows(2)  ///
		graphregion(color(white) lwidth(large)) ///
		name(figureB, replace)
		graph drop figureA gbC
	
twoway line ccvol m_ts,  ///
		graphregion(color(white)) ///
		clwidth(medium ) ///
		title("Credit card volatility", size(small)) ///
		xlabel(, labsize(vsmall)) xtitle("", size(small))   /// 	
		ylabel(, labsize(vsmall) nogrid) ytitle("", size(small))  ///
		name(gb3, replace) 	

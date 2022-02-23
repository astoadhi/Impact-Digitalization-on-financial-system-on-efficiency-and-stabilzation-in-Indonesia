gen  m_ts = tm(2012m1)+_n-1
br m_ts
format m_ts %tm
tsset m_ts
gen lnc_6 = ln(c_6)
gen lnrue = ln(rue)
gen lnc_1 = ln(c_1)
gen lnc_3 = ln(c_3)
gen lnc_4= ln(c_4)
gen lnc_5= ln(c_5)
gen lnelmon= ln(elmon)
gen dconsu = ln(CONSU)
gen dexra = ln(LNER)
ren lnc_3 LNER
ren lnc_1 LNCPI
ren c_2 BIR
ren lnc_5 LNIHSG 
ren lnc_6 CONSU
ren rue ELMON

ardl CONSU ELMON LNCPI BIR LNER LNIHSG , bic ec dots maxcombs(1000000)
estat ectest

ardl CONSU ELMON LNCPI BIR LNER LNIHSG , bic ec dots maxcombs(1000000) regstore(ardlin)
estimates restore ardlin
estat bgodfrey 

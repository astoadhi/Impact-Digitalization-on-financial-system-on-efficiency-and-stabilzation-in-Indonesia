varsoc exravol
*1
varsoc INFL
*2
varsoc ccvol
*3
// Intra Inter excluded	
regress exravol delmon ddebit dkredit dintra dinter doil dm2 djibor
hettest
bgodfrey
imtest
predict residexra , residuals 
jb residexra

regress INFL delmon ddebit dkredit dintra dinter doil 
hettest
bgodfrey
imtest
predict residinfl , residuals 
jb residinfl

regress ccvol delmon dcpi dihsg dipi dbir dexra
hettest
bgodfrey
imtest
predict residccvol , residuals 
jb residccvol

regress TICSIZE delmon dcpi dihsg dipi dbir dexra
hettest
bgodfrey
imtest

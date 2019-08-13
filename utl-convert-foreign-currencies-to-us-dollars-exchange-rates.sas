
Convert foreign currencies to us dollars                                                                 
                                                                                                         
SAS Forum                                                                                                
https://tinyurl.com/y6xz9suu                                                                             
https://communities.sas.com/t5/SAS-Programming/Currency-reading/m-p/580743                               
                                                                                                         
List of currency abreviations by countery                                                                
https://www.translationdirectory.com/glossaries/glossary123.htm                                          
                                                                                                         
I think you neeed to use the currency abreviations instead of special                                    
characters'                                                                                              
                                                                                                         
For example to convert foreign currencies to dollars use                                                 
                                                                                                         
      COUNTRY      FROTOO                                                                                
                                                                                                         
      UK           EUR/USD                                                                               
      India        INR/USD                                                                               
      Japan        JPY/USD                                                                               
      Netherlands  ANG/USD                                                                               
      Poland       PLN/USD                                                                               
      Zimbabwe     ZWD/USD                                                                               
                                                                                                         
*_                   _                                                                                   
(_)_ __  _ __  _   _| |_                                                                                 
| | '_ \| '_ \| | | | __|                                                                                
| | | | | |_) | |_| | |_                                                                                 
|_|_| |_| .__/ \__,_|\__|                                                                                
        |_|                                                                                              
;                                                                                                        
                                                                                                         
options validvarname=upcase;                                                                             
libname sd1 "d:/sd1";                                                                                    
data sd1.have ;                                                                                          
  retain date "13AUG2019"d;                                                                              
  format date date9.;                                                                                    
  informat empcode curSym amt country $16.;                                                              
  input empcode curSym amt country;                                                                      
  salary=input(compress(amt,,"kd"),best.)/100;                                                           
  froToo=cats(curSym,"/","USD");                                                                         
  rate=.;                                                                                                
put salary=;                                                                                             
drop amt curSym;                                                                                         
datalines;                                                                                               
1001 EUR £1,560.00 UK                                                                                    
1002 INR ?1,646.67 India                                                                                 
1003 JPY ¥1,733.33 Japan                                                                                 
1004 ANG ƒ1,820.00 Netherlands                                                                           
1005 PLN ?1,906.67 Poland                                                                                
1006 ZWD Z$1,993.33 Zimbabwe                                                                             
;;;;                                                                                                     
run;quit;                                                                                                
                                                                                                         
*            _               _                                                                           
  ___  _   _| |_ _ __  _   _| |_                                                                         
 / _ \| | | | __| '_ \| | | | __|                                                                        
| (_) | |_| | |_| |_) | |_| | |_                                                                         
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                        
                |_|                                                                                      
;                                                                                                        
                                                                                                         
WANT total obs=6                                                                                         
                                            Foeign                                                       
                                           Currency             SALARY_                                  
   DATE      EMPCODE  COUNTRY     FROTOO    SALARY     RATE     DOLLARS                                  
                                                                                                         
 13AUG2019    1001    UK          EUR/USD  1,560.00   1.12052    $1,748                                  
 13AUG2019    1002    India       INR/USD  1,646.67   0.01405       $23                                  
 13AUG2019    1003    Japan       JPY/USD  1,733.33   0.00949       $16                                  
 13AUG2019    1004    Netherlands ANG/USD  1,820.00   0.55866    $1,017                                  
 13AUG2019    1005    Poland      PLN/USD  1,906.67   0.25895      $494                                  
 13AUG2019    1006    Zimbabwe    ZWD/USD  1,993.33   0.00267        $5                                  
                                                                                                         
                                                                                                         
*          _       _   _                                                                                 
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                 
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                
                                                                                                         
;                                                                                                        
                                                                                                         
                                                                                                         
%utl_submit_r64('                                                                                        
library(quantmod);                                                                                       
library(haven);                                                                                          
library(SASxport);                                                                                       
have<-read_sas("d:/sd1/have.sas7bdat");                                                                  
for (i in 1:nrow(have)) {                                                                                
      res<-getSymbols(have$FROTOO[i],src="oanda",from="2019-08-12",auto.assign=FALSE);                   
      have$RATE[i]<-res[[1]];                                                                            
  };                                                                                                     
have<-as.data.frame(have);                                                                               
write.xport(have,file="d:/xpt/want.xpt");                                                                
');                                                                                                      
                                                                                                         
libname xpt xport "d:/xpt/want.xpt";                                                                     
data want ;                                                                                              
  format date date9.;                                                                                    
  set xpt.have;                                                                                          
  salary_dollars=salary*rate;                                                                            
  format salary_dollars dollar13.;                                                                       
run;quit;                                                                                                
libname xpt clear;                                                                                       
                                                                                                         
                                                                                                         

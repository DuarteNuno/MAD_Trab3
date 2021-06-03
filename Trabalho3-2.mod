set TYPE;
set OPE;

param z {TYPE} >=0;
param ope {OPE, TYPE} >= 0;
param number_of_weeks;
param price_stock;
param price_delay;
param setup_operation;
param orders {w in 1..number_of_weeks, TYPE} >= 0;

var delay {w in 0..number_of_weeks, TYPE} >= 0;
var s {w in 0..number_of_weeks, TYPE} >= 0;
var q {w in 1..number_of_weeks, TYPE} >= 0;
var p {w in 1..number_of_weeks, TYPE} >= 0;
var setupLine {w in 1..number_of_weeks, TYPE};
var pc {OPE, w in 1..number_of_weeks, TYPE} >= 0, <=1;
var productionLine {w in 1..number_of_weeks, TYPE} binary;

minimize cost:
sum {w in 1..number_of_weeks, t in TYPE} (price_stock*s[w, t] + price_delay*delay[w, t] + setup_operation*productionLine[w,t]);

subject to
S0 {t in TYPE}: s[0,t] = 0;
S52 {t in TYPE}: s[52,t] = 0;
D0 {t in TYPE}: delay[0,t] = 0;
D52 {t in TYPE}: delay[52,t] = 0;

SetupLines {w in 1..number_of_weeks}:
productionLine [w, 'R'] + productionLine [w, 'C'] + productionLine [w, 'I'] <= 2;

StoreAndDelay {w in 1..number_of_weeks,t in TYPE}:
s[w, t] + orders[w, t] + delay[w-1, t] = q[w, t] + s[w-1, t] + delay[w, t];

Prod {o in OPE, w in 1..number_of_weeks}:
sum {t in TYPE} q[w,t]/ope[o,t] <= 1;

ProdFinal {t in TYPE, w in 1..number_of_weeks}:
q[w,t] <= z[t]*productionLine[w,t];

SetupLines1 {w in 1..number_of_weeks}:
productionLine [w, 'R'] + productionLine [w, 'I'] <= 1;

SetupLines2 {w in 2..number_of_weeks}:
productionLine [w-1, 'R'] + productionLine [w, 'I'] <= 1;
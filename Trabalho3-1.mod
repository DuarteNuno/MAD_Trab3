set TYPE;
set OPE;

param z {TYPE};
param ope {OPE, TYPE};
param number_of_weeks;
param price_stock;
param price_delay;
param setup_operation;
param orders {w in 1..number_of_weeks, TYPE};

var delay {w in 0..number_of_weeks, TYPE} >= 0;
var s {w in 0..number_of_weeks, TYPE} >= 0;
var q {w in 1..number_of_weeks, TYPE} >= 0;
var setupLine {w in 1..number_of_weeks, TYPE};
var productionLine {w in 1..number_of_weeks, TYPE} binary;

minimize cost:
sum {w in 1..number_of_weeks, t in TYPE} (price_stock*s[w, t] + price_delay*delay[w, t] + setup_operation*productionLine[w,t]);

subject to
s0 {t in TYPE}: s[0,t] = 0;
s52 {t in TYPE}: s[52,t] = 0;
d0 {t in TYPE}: delay[0,t] = 0;
d52 {t in TYPE}: delay[52,t] = 0;

s1 {t in TYPE}: 
sum {w in 1..number_of_weeks} q[w,t] = sum {w in 1..number_of_weeks} orders[w,t];
#garantir que o q foi produzido é o q foi pedido

s2 {t in TYPE}: 
sum {w in 1..number_of_weeks} ((q[w,t]*z[t]) - orders[w,t]) >=0;
# garantir que a quantidade por semana é maior que o pedido 

SetupLines {w in 1..number_of_weeks}:
sum {t in TYPE} productionLine[w,t] <= 2;

StoreAndDelay {w in 1..number_of_weeks,t in TYPE}:
delay[w, t] = delay[w-1, t] + orders[w, t] + s[w, t] - s[w-1, t] - q[w,t];


Prod {o in OPE, w in 1..number_of_weeks}:
sum {t in TYPE} q[w,t]/ope[o,t] <= 1;

ProdFinal {t in TYPE, w in 1..number_of_weeks}:
q[w,t] <= z[t]*productionLine[w,t];
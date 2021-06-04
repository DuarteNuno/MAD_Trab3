from amplpy import AMPL
import json

ampl = AMPL()

# Interpret the two files
ampl.read('Trabalho3-1.mod')
ampl.readData('Trabalho3.dat')

ampl.setOption('solver','gurobi')

# Solve
ampl.solve()

q=ampl.getVariable("q")
print(q.getValues())

with open('ex1_prod.txt','w') as file:
    print(q.getValues(), file=file)

s=ampl.getVariable("s")
print(s.getValues())

with open('ex1_stock.txt','w') as file:
    print(s.getValues(),file=file)

d=ampl.getVariable('delay')
print(d.getValues())

with open('ex1_delay.txt','w') as file:
    print(d.getValues(),file=file)


# Get objective entity by AMPL name
totalcost = ampl.getObjective('cost')
# Print it
print("Objective is:", totalcost.value())
from amplpy import AMPL

ampl = AMPL()

# Interpret the two files
ampl.read('Trabalho3-1.mod')
ampl.readData('Trabalho3.dat')
# Solve
ampl.solve()

q=ampl.getVariable("q")
print(q.getValues())

pl=ampl.getVariable("productionLine")
print(pl.getValues())

# Get objective entity by AMPL name
totalcost = ampl.getObjective('cost')
# Print it
print("Objective is:", totalcost.value())
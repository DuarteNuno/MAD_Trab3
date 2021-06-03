from amplpy import AMPL

ampl = AMPL()

# Interpret the two files
ampl.read('Trabalho3-2.mod')
ampl.readData('Trabalho3.dat')

print(ampl.importGurobiSolution("Trabalho3-2.mod"))

# Solve
ampl.solve()

#q=ampl.getVariable("q")
#print(q.getValues())

#pl=ampl.getVariable("productionLine")
#print(pl.getValues())

# Get objective entity by AMPL name
totalcost = ampl.getObjective('cost')
# Print it
print("Objective is:", totalcost.value())
DATA = eil10.dzn eil11.dzn eil12.dzn eil13.dzn eil14.dzn eil16.dzn eil20.dzn eil30.dzn eil40.dzn eil51.dzn
VPATH = data

PROG ?= tsp.mzn

# Remove coin-bc since it won't work well.
# TARGETS = gecode ortools chuffed coin-bc scip
TARGETS = gecode ortools chuffed scip

.SUFFIXES: .dzn .tsp

.tsp.dzn:; ./tsp2mat.py $< > $@

ALL:

DATA: $(DATA)

RUNIT: $(DATUM)
	for i in $(TARGETS); do \
	    echo minizinc --solver $$i $(PROG) $(DATUM); \
	    timeout 1800 time minizinc --solver $$i $(PROG) $(DATUM); \
	done

RUN10:
	make PROG=$(PROG) DATUM=eil10.dzn RUNIT

RUN12:
	make PROG=$(PROG) DATUM=eil12.dzn RUNIT

RUN14:
	make PROG=$(PROG) DATUM=eil14.dzn RUNIT
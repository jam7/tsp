# Test cases for travelling salesman problem

Implement CSP for TSP and compare the way of implementations and the
effectiveness of solvers.

## Data

We uses TSPLIB95 data sets.

First, tries eil51.tsp since it is solved in 5 sec or so in gurobi
regarding to several papers.

Then, I noticed it is not solved in 24 hours on non-commercial solvers.

Therefore, I made several data sets using eil51.tsp.  I pick up first
ten, eleven, twelve, and so on cities from eil51.tsp.

Minimum cost:

 - eil10.dzn
   - 159
 - eil11.dzn
   - 167
 - eil12.dzn
   - 169
 - eil13.dzn
   - 190
 - eil14.dzn
   - 191
 - eil16.dzn
   - ?
 - eil20.dzn
 - eil30.dzn
 - eil40.dzn
 - eil51.dzn
   - 426

## Program

I prepared several CSP TSP programs.

- tspmip.mzn: simple CSP using visit[i]. 
- tsp.mzn: simple binary CSP using x[i,j] similar to visit[i].
- tsp2.mzn: similar to tsp.mzn but using (x[next(a),j]+x[prev(a),j])/2.
- tspff.mzn: CSP using edge and flow formulation (increasing).
- tspff2.mzn: CSP using edge and flow formulation (decreasing).
- tspff2l.mzn: CSP using edge and flow formulation (decreasing and add more limitation).

I ran above programs using eil14.

|solver|tspmip (s)|tsp (s)|tsp2 (s)|tspff (s)|tspff2 (s)|tspff2l (s)|
|---|---|---|---|---|---|---|
|Win Gecode 6.3.0|1456|-|-|
|Win Chuffed 0.10.4|106|-|-|
|Win COIN-BC 2.10.5/1.17.5| >30min|-|-|
|Linux Gecode 6.2.0|795.97|-|-|106.13|110.95|119.07|
|Linux OR Tools 8.1|75.285|-|-|0.47|0.86|0.80|
|Linux Chuffed 0.10.4|277.480|-|-|751.83|548.14|482.43|
|Linux COIN-OR CBC 2.10.0| >30min|-|-|0.12|0.16|0.10|
|Linux SCIP 6.0.2.0|106.077|-|-|0.12|0.20|0.14|

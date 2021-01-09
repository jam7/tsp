include "globals.mzn";

int: Nodes;

set of int: NUM = 1..Nodes;

array[NUM, NUM] of int: Dist; % Distance between a pair of city.
array[NUM] of var NUM: visit;

function int: next(int: a) = (if a == Nodes then 1 else a + 1 endif);

% Following all_different require minizinc 2.4.3.
% It won't work on 2.5 or above on Ubuntu.
constraint all_different(visit);

% Minimize cost
var int: cost = sum(i in NUM)(
    Dist[visit[i], visit[next(i)]]
);
solve minimize cost;

output ["cost: \(cost)\n"] ++
       ["\(fix(visit[i])) -> " | i in NUM];

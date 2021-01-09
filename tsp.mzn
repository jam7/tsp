int: Nodes;

set of int: NUM = 1..Nodes;

array[NUM, NUM] of var int: Dist; % Distances between places.
array[NUM, NUM] of var 0..1: x;

constraint forall (i in NUM) (
    sum(j in NUM)(x[i,j]) == 1
);
constraint forall (j in NUM) (
    sum(i in NUM)(x[i,j]) == 1
);

function int: next(int: a) = (if a == Nodes then 1 else a + 1 endif);

% Minimize cost
var int: cost = sum(a, i, j in NUM where i != j)(
    Dist[i,j] * x[a, i] * x[next(a), j]
);
solve minimize cost;

output ["cost: \(cost)\n"] ++
       [if fix(x[i,j]) == 1 then "\(j)" else "" endif ++
        if j == Nodes then " -> " else "" endif |
        i, j in NUM];

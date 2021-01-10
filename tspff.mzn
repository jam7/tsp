int: Nodes;

set of int: NUM = 1..Nodes;

array[NUM, NUM] of var int: Dist; % Distances between places.
array[NUM, NUM] of var 0..1: x;
array[NUM, NUM] of var 0..Nodes-1: y;

constraint forall (i in NUM) (
    sum(j in NUM where i != j)(x[i,j]) == 1
);
constraint forall (j in NUM) (
    sum(i in NUM where i != j)(x[i,j]) = 1
);
constraint forall (i, j in NUM where i != j)(
    y[i,j] <= (Nodes - 1) * x[i,j]
);
constraint forall (i in 2..Nodes) (
    sum(j in NUM where i != j)(y[i,j]) -
    sum(h in NUM where i != h)(y[h,i]) == 1
);
constraint (
    sum(j in NUM where 1 != j)(y[1,j]) -
    sum(h in NUM where 1 != h)(y[h,1]) == -(Nodes-1)
);
constraint (
    sum(j in 2..Nodes)(y[1,j]) == 0
);


% Minimize cost
var int: cost = sum(i, j in NUM where i != j)(
    Dist[i,j] * x[i,j]
);
solve minimize cost;

output ["cost: \(cost)\n"] ++
       [if fix(x[i,j]) == 1 then "\(j)" else "" endif ++
        if j == Nodes then " -> " else "" endif |
        i, j in NUM];

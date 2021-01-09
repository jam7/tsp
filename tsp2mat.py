#!/usr/bin/env python

from optparse import OptionParser

parser = OptionParser()
parser.add_option("-o", "--output", dest="filename",
                  help="write result to FILE", metavar="FILE")

(options, args) = parser.parse_args()
if len(args) != 1:
    parser.error("incorrect number of arguments")

import tsplib95
problem = tsplib95.load(args[0])

if problem.type != 'TSP':
    raise Exception("Found not supported type: " + str(problem.type))

if problem.edge_weight_type != 'EUC_2D':
    raise Exception("Found not supported edge_weight_type: " + str(problem.edge_weight_type))

nodes = list(problem.get_nodes())

print('Nodes = {};'.format(len(nodes)))

print('Dist = [|')
for i in nodes:
    print('    ', end='')
    for j in nodes:
        print('{}, '.format(problem.get_weight(i, j)), end='')
    print('|')
print('|];')

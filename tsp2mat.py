#!/usr/bin/env python

import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("inputs", metavar='INPUTS', type=str,
                    nargs=1, help="input files using TSPLIB95 format")
parser.add_argument("-o", "--output", dest="filename",
                    help="write result to FILE", metavar="FILE")
args = parser.parse_args()

import tsplib95
problem = tsplib95.load(args.inputs[0])

if problem.type != 'TSP':
    raise Exception("Found not supported type: " + str(problem.type))

if problem.edge_weight_type != 'EUC_2D':
    raise Exception("Found not supported edge_weight_type: "
                    + str(problem.edge_weight_type))

nodes = list(problem.get_nodes())

if args.filename is not None:
  sys.stdout = open(args.filename, 'w')

print('Nodes = {};'.format(len(nodes)))

print('Dist = [|')
for i in nodes:
    print('    ', end='')
    for j in nodes:
        print('{}, '.format(problem.get_weight(i, j)), end='')
    print('|')
print('|];')

#!/bin/bash

patsopt --constraint-export -tc -d parsing/TEST/test01.dats | ./solving/Z3/solve-z3

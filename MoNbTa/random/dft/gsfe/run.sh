#!/bin/bash

for i in `seq 0 1 40`
do
  cd ${i}
  cp ../INCAR .
  cp ../KPOINTS .
  cp ../POTCAR .
  cp ../vasp.batch .
  sbatch vasp.batch
  cd ../
done

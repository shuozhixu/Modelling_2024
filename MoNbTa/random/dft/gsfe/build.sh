#!/bin/bash

for i in `seq 0 1 40`
do
  tz=`echo "scale=6;$i*0.0125"|bc`
  rm -r $i
  mkdir -p $i
  echo $i
  cd $i
  cp ../POSCAR_0 .
  cp ../bcc_gsfe_poscar.py .
  python bcc_gsfe_poscar.py 0.0 ${tz} 12.
  rm POSCAR_0
  cd ..
done

#!/bin/bash

mkdir cn

file='cn.out'

l=`echo | awk 'END{print NR}' ${file}`

i=0

for((j=4;j<=$l;j+=301))
do 
 awk '{if (NR>=1 && NR<=3) print $0}' ${file} >> cn/rdf.$i.dat
 awk '{if(NR>='$j' && NR<='$j'+300) print $0}' ${file} >> cn/rdf.$i.dat
  i=`echo "scale=1;$i+10000"| bc`
done

#!/bin/bash

rm -f gsfe
 
for i in `seq 0 1 40`
do
  cd ${i}
  k=`echo "scale=6;$i*0.025"|bc`
  E=`tail -n 2 OSZICAR | awk '{ print $3}'`
  echo $k $E >> ../gsfe_ori
  cd ../
done

awk -v c=1 'NR==1 { b=$2 } { printf( "%0.3f\t%0.6f\n", $1,( $2-b ) * c ) }' gsfe_ori > gsfe
rm gsfe_ori

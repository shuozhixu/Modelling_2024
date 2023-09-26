#!/bin/bash

aveC=0.33333333333333

echo "step a_NiNi a_NiCo a_NiCr a_CoCo a_CoCr a_CrCr" > csro.a1.dat
echo "step a_NiNi a_NiCo a_NiCr a_CoCo a_CoCr a_CrCr" > csro.a2.dat
echo "step a_NiNi a_NiCo a_NiCr a_CoCo a_CoCr a_CrCr" > csro.a3.dat

for file in rdf.*.dat
do
    s=$(echo "$file" | cut -d'.' -f2)
    echo $s
    awk -v stp=$s -v c=$aveC \
        '{
            if(FNR>4 && $2>=3.0){
                a_NiNi = ($6/$4 - c) / (1 - c);
                a_NiCo = 1 - $8/$4/c;
                a_NiCr = 1 - $10/$4/c;
                a_CoCo = ($14/$4 - c) / (1 - c);
                a_CoCr = 1 - $16/$4/c;
                a_CrCr = ($22/$4 - c) / (1 - c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_NiNi,a_NiCo,a_NiCr,a_CoCo,a_CoCr,a_CrCr,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
        }' < $file >> tmp1

    cn1=`tail -1 tmp1 | awk '{print $8}'`
    nini=`tail -1 tmp1 | awk '{print $9}'`
    nico=`tail -1 tmp1 | awk '{print $10}'`
    nicr=`tail -1 tmp1 | awk '{print $11}'`
    coco=`tail -1 tmp1 | awk '{print $12}'`
    cocr=`tail -1 tmp1 | awk '{print $13}'`
    crcr=`tail -1 tmp1 | awk '{print $14}'`
    #echo $cn1 $nini $nico $nicr $coco $cocr $crcr >test.txt

    awk -v cn_prev=$cn1 -v stp=$s -v c=$aveC \
        -v p1=$nini -v p2=$nico -v p3=$nicr -v p4=$coco -v p5=$cocr \
        -v p6=$crcr \
        '{
            if(FNR>4 && $2>=4.0){
                a_NiNi = (($6-p1)/($4-cn_prev)-c)/(1-c);
                a_NiCo = 1 - ($8-p2)/($4-cn_prev)/c;
                a_NiCr = 1 - ($10-p3)/($4-cn_prev)/c;
                a_CoCo = (($14-p4)/($4-cn_prev)-c)/(1-c);
                a_CoCr = 1 - ($16-p5)/($4-cn_prev)/c;
                a_CrCr = (($22-p6)/($4-cn_prev)-c)/(1-c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_NiNi,a_NiCo,a_NiCr,a_CoCo,a_CoCr,a_CrCr,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
         }' < $file >> tmp2

    cn2=`tail -1 tmp2 | awk '{print $8}'`
    nini=`tail -1 tmp2 | awk '{print $9}'`
    nico=`tail -1 tmp2 | awk '{print $10}'`
    nicr=`tail -1 tmp2 | awk '{print $11}'`
    coco=`tail -1 tmp2 | awk '{print $12}'`
    cocr=`tail -1 tmp2 | awk '{print $13}'`
    crcr=`tail -1 tmp2 | awk '{print $14}'`
    #echo $cn2 $nini $nico $nicr $coco $cocr $crcr

    awk -v cn_prev=$cn2 -v stp=$s -v c=$aveC \
        -v p1=$nini -v p2=$nico -v p3=$nicr -v p4=$coco -v p5=$cocr \
        -v p6=$crcr \
        '{
            if(FNR>4 && $2>=4.7){
                a_NiNi = (($6-p1)/($4-cn_prev)-c)/(1-c);
                a_NiCo = 1 - ($8-p2)/($4-cn_prev)/c;
                a_NiCr = 1 - ($10-p3)/($4-cn_prev)/c;
                a_CoCo = (($14-p4)/($4-cn_prev)-c)/(1-c);
                a_CoCr = 1 - ($16-p5)/($4-cn_prev)/c;
                a_CrCr = (($22-p6)/($4-cn_prev)-c)/(1-c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_NiNi,a_NiCo,a_NiCr,a_CoCo,a_CoCr,a_CrCr,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
         }' < $file >> tmp3
done

sort -gk1 tmp1 >> csro.a1.dat
sort -gk1 tmp2 >> csro.a2.dat
sort -gk1 tmp3 >> csro.a3.dat
rm tmp1 tmp2 tmp3

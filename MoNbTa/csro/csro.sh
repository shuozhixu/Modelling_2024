#!/bin/bash

aveC=0.33333333333333

echo "step a_MoMo a_MoNb a_MoTa a_NbNb a_NbTa a_TaTa" > csro.a1.dat
echo "step a_MoMo a_MoNb a_MoTa a_NbNb a_NbTa a_TaTa" > csro.a2.dat
echo "step a_MoMo a_MoNb a_MoTa a_NbNb a_NbTa a_TaTa" > csro.a3.dat

for file in rdf.*.dat
do
    s=$(echo "$file" | cut -d'.' -f2)
    echo $s
    awk -v stp=$s -v c=$aveC \
        '{
            if(FNR>4 && $2>=3.0){
                a_MoMo = ($6/$4 - c) / (1 - c);
                a_MoNb = 1 - $8/$4/c;
                a_MoTa = 1 - $10/$4/c;
                a_NbNb = ($14/$4 - c) / (1 - c);
                a_NbTa = 1 - $16/$4/c;
                a_TaTa = ($22/$4 - c) / (1 - c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_MoMo,a_MoNb,a_MoTa,a_NbNb,a_NbTa,a_TaTa,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
        }' < $file >> tmp1

    cn1=`tail -1 tmp1 | awk '{print $8}'`
    MoMo=`tail -1 tmp1 | awk '{print $9}'`
    MoNb=`tail -1 tmp1 | awk '{print $10}'`
    MoTa=`tail -1 tmp1 | awk '{print $11}'`
    NbNb=`tail -1 tmp1 | awk '{print $12}'`
    NbTa=`tail -1 tmp1 | awk '{print $13}'`
    TaTa=`tail -1 tmp1 | awk '{print $14}'`
    #echo $cn1 $MoMo $MoNb $MoTa $NbNb $NbTa $TaTa >test.txt

    awk -v cn_prev=$cn1 -v stp=$s -v c=$aveC \
        -v p1=$MoMo -v p2=$MoNb -v p3=$MoTa -v p4=$NbNb -v p5=$NbTa \
        -v p6=$TaTa \
        '{
            if(FNR>4 && $2>=4.0){
                a_MoMo = (($6-p1)/($4-cn_prev)-c)/(1-c);
                a_MoNb = 1 - ($8-p2)/($4-cn_prev)/c;
                a_MoTa = 1 - ($10-p3)/($4-cn_prev)/c;
                a_NbNb = (($14-p4)/($4-cn_prev)-c)/(1-c);
                a_NbTa = 1 - ($16-p5)/($4-cn_prev)/c;
                a_TaTa = (($22-p6)/($4-cn_prev)-c)/(1-c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_MoMo,a_MoNb,a_MoTa,a_NbNb,a_NbTa,a_TaTa,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
         }' < $file >> tmp2

    cn2=`tail -1 tmp2 | awk '{print $8}'`
    MoMo=`tail -1 tmp2 | awk '{print $9}'`
    MoNb=`tail -1 tmp2 | awk '{print $10}'`
    MoTa=`tail -1 tmp2 | awk '{print $11}'`
    NbNb=`tail -1 tmp2 | awk '{print $12}'`
    NbTa=`tail -1 tmp2 | awk '{print $13}'`
    TaTa=`tail -1 tmp2 | awk '{print $14}'`
    #echo $cn2 $MoMo $MoNb $MoTa $NbNb $NbTa $TaTa

    awk -v cn_prev=$cn2 -v stp=$s -v c=$aveC \
        -v p1=$MoMo -v p2=$MoNb -v p3=$MoTa -v p4=$NbNb -v p5=$NbTa \
        -v p6=$TaTa \
        '{
            if(FNR>4 && $2>=4.7){
                a_MoMo = (($6-p1)/($4-cn_prev)-c)/(1-c);
                a_MoNb = 1 - ($8-p2)/($4-cn_prev)/c;
                a_MoTa = 1 - ($10-p3)/($4-cn_prev)/c;
                a_NbNb = (($14-p4)/($4-cn_prev)-c)/(1-c);
                a_NbTa = 1 - ($16-p5)/($4-cn_prev)/c;
                a_TaTa = (($22-p6)/($4-cn_prev)-c)/(1-c);
                printf "%d %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f\n", stp,a_MoMo,a_MoNb,a_MoTa,a_NbNb,a_NbTa,a_TaTa,$4,$6,$8,$10,$14,$16,$22; 
                exit(0);
            }
         }' < $file >> tmp3
done

sort -gk1 tmp1 >> csro.a1.dat
sort -gk1 tmp2 >> csro.a2.dat
sort -gk1 tmp3 >> csro.a3.dat
rm tmp1 tmp2 tmp3

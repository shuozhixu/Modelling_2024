#!/usr/bin/bash

rm -f *.lmp data.*

a=3.243

atomsk --create bcc $a Mo orient [11-2] [111] [1-10] -duplicate 10 46 14 Mo.cfg

atomsk Mo.cfg -select random 33.33% Mo -sub Mo Nb MoNb.cfg

atomsk MoNb.cfg -select random 50% Mo -sub Mo Ta data.MoNbTa_random.cfg lmp

mv data.MoNbTa_random.lmp data.MoNbTa_random

rm -f *.cfg
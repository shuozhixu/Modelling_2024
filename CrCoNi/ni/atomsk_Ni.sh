#!/usr/bin/bash

rm -f *.lmp data.*

a=3.5564

atomsk --create fcc $a Ni orient [1-10] [11-2] [111] -duplicate 30 30 10 data.Ni.cfg lmp

mv data.Ni.lmp data.Ni

rm -f *.cfg
#!/usr/bin/bash

rm -f *.lmp data.*

a=3.52

atomsk --create fcc $a Mo orient [11-2] [111] [1-10] -duplicate 10 46 14 data.Mo lmp

mv data.Mo.lmp data.Mo

rm -f *.cfg
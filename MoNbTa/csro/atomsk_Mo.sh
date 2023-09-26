#!/usr/bin/bash

rm -f *.lmp data.*

a=3.135

atomsk --create bcc $a Mo orient [11-2] [111] [1-10] -duplicate 10 46 14 data.Mo.cfg lmp

mv data.Mo.lmp data.Mo

rm -f *.cfg

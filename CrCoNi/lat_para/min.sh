#!/bin/bash

rm -f min_aE
awk NF a_E > new_aE
awk 'NR == 1 || $2 < min {line = $0; min = $2}END{print line}' new_aE > min_aE
tail min_aE
rm -f new_aE

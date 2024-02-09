#!/bin/bash

rm -f min_aE
awk 'NR == 1 || $3 < min {line = $0; min = $3}END{print line}' new_aE > min_aE
tail min_aE
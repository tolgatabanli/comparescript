#!/bin/bash
input=$1

perl -0777 -pe 's/""".*?"""\n//gs' $input > converted_${input}

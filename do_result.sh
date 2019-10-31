#!/bin/bash
name=$1
echo $name

echo "Step1"
bash do_step1.psh $name
echo "Step2"
bash do_step2.psh $name
echo "Step3"
bash do_step3.psh $name

bash do_clean.sh


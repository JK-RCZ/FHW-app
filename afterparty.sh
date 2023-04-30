#!/usr/bin/env bash


grep -i fuck /home/ec2-user/result.txt > /home/ec2-user/count.txt
wc -l /home/ec2-user/count.txt > /home/ec2-user/count2.txt
COUNT=$(grep -Eo "[0-9]{1,4}" /home/ec2-user/count2.txt)
echo $COUNT
if [ $COUNT == 35 ]
            then
            echo -e "FUCK CHECK SUCCESSFULL!"
            exit 0

            else
            echo -e "FUCK CHECK FAILED!"
            exit 1
            fi

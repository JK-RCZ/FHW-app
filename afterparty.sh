#!/usr/bin/env bash


grep -i fuck /home/ec2-user/result.txt > /home/ec2-user/count.txt
wc -l /home/ec2-user/count.txt > /home/ec2-user/count2.txt
grep -Eo "[0-9]{1,4}" /home/ec2-user/count2.txt > /home/ec2-user/count3.txt
COUNT=$(sed 's/  */\t/g' /home/ec2-user/count2.txt | cut -f1)
if [ $COUNT == 35 ]
            then
            echo -e "FUCK CHECK: $COUNT OUT OF 35 - SUCCESSFULL!"
            exit 0

            else
            echo -e "FUCK CHECK: $COUNT OUT OF 35 - FAILED!"
            exit 1
            fi

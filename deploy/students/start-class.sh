#!/bin/bash
INPUT=signups.csv
OLDIFS=$IFS
IFS=,
port=9000
while read col1 col2
do
    ((port++))
    echo "student:$col1 port:$port"
    ansible-playbook -l 23.253.162.114 -i ../../hosts student-add.yml -e "user_name=$col1 port=$port" -u root
done < $INPUT
IFS=$OLDIFS

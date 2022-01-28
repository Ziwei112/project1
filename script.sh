#!/bin/bash

if aws ec2 describe-tags --region ap-southeast-1 --filters Name=resource-type,Values=instance Name=value,Values=Deploy | grep Deploy; then
    Id=$(aws ec2 describe-tags --region ap-southeast-1 --filters Name=key,Values=Name Name=value,Values=Deploy --query 'Tags[*].ResourceId' --output text)
    Ip=$(aws ec2 describe-instances --region ap-southeast-1 --query 'Reservations[*].Instances[*].PublicIpAddress' --instance-ids $Id --output text)
else
    ansible-playbook pb1.yaml -v
    ansible-playbook -i host pb2.yaml --private-key ~/.ssh/key.pem
fi

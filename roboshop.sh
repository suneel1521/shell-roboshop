#!/bin/bash
AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-0284b2fb39b1615a6"
INSTANCES=("frontend" "catelogue" "mongodb")

for instannce in "${INSTANCES[@]}"
do
    echo "creating $instance instance"
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type "t3.micro" \
    --security-group-ids "$SG_ID" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text)
    echo "instanceId $INSTANCE_ID" 
done
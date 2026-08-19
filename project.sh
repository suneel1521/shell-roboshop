#!/bn/bash
AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-035cf3b369ddee7f8"
INSTANCES=("frontend" "python" "mysql" "cart" "user")

for instance in "${INSTANCES[@]}"
do
  echo "cerating $instance instance"

  INSTANCE_ID=$(aws ec2 run-instances / --image-id "$AMI_ID" /--instance-type t3.micro /--security-group-ids "$SG_ID /--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}] /--query "Instances[0].InstanceId" /--output "text")
  echo "Instance Id : $INSTANCE_ID"
  if [ "$instance" != "frontend" ]
    then
        ip=$(aws ec2 describe-instances \
            --instance-ids "$INSTANCE_ID" \
            --query "Reservations[0].Instances[0].PrivateIpAddress" \
            --output text)
    else
        ip=$(aws ec2 describe-instances \
            --instance-ids "$INSTANCE_ID" \
            --query "Reservations[0].Instances[0].PublicIpAddress" \
            --output text)
    fi
done
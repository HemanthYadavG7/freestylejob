export AWS_DEFAULT_REGION='ap-south-1'
export AWS_ACCESS_KEY_ID='AKIAYKXD5DTEGV6R2QE3'
export AWS_SECRET_ACCESS_KEY='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'
export INSTANCE_TYPE='t2.micro'
export AMI_ID='ami-013168dc3850ef002'
export KEY_PAIR_NAME='project'
export SECURITY_GROUP_ID='sg-0e1c83bb5163dd04f'
export SUBNET_ID='subnet-0911b739f38bdd428'


instanceId=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_PAIR_NAME \
    --security-group-ids $SECURITY_GROUP_ID \
    --subnet-id $SUBNET_ID \
    --user-data '#!/bin/bash
                  yum update -y
                  yum install -y httpd
                  service httpd start
                  chkconfig httpd on
                  echo "<html><body><h1>Hello, World!</h1></body></html>" > /var/www/html/index.html' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyInstance}]' \
    --output json --query 'Instances[0].InstanceId' \
    | tr -d '"')

echo "EC2 instance created with ID: $instanceId"

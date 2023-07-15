#!/bin/bash

# New installation for ubuntu
TERRAFORM_CHECK=`terrafor &> /dev/null`

ERROR_CHECK=`echo $?`

if [[ $ERROR_CHECK -eq 0 ]]
then
    echo "Terraform is installed"
    # show list of command
else
    echo "Terraform is not installed"
    # Check Linux distro
    # Install Terraform
    # Copy script to location
    # Make terra command available using alias
fi





#terra workflow
ARG=$1

if [[ $ARG = "plan" || $ARG = "Plan" ]]
then
    terraform init
    terraform validate
    terraform fmt
    terraform plan
elif [[ $ARG = "apply" || $ARG = "Apply" ]]
then
    terraform apply --auto-approve
elif [[ $ARG = "destroy" || $ARG = "Destroy" ]]
then
    terraform destroy --auto-approve
else
    echo "No ARGS were passed, I'll intialize, format, validate the project directory/files"
    terraform init
    terraform fmt
    terraform validate
fi
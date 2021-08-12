pipeline {

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
        options {
                timestamps ()
                ansiColor('xterm')
            }
     stage ('Checkout') {
       git branch: 'master',
       url: 'https://github.com/manideep-personal/terraform.git'
       mvnHome = tool 'M3'
         }

     stage ('Terraform Plan') {
      sh 'terraform init'
      sh 'terraform plan -no-color -out=create.tfplan'
          }

     stage ('Terraform Apply') {
      sh 'terraform apply -no-color -auto-approve create.tfplan'
          }

     stage ('Post Run Tests') {
      echo "Insert your infrastructure test of choice and/or application validation here."
      sleep 2
      sh 'terraform show'
      sh 'cp terraform.tfstate /var/lib/jenkins/workspace/AWS-Terraform_destroy/terraform.tfstate'
          }

 
        }

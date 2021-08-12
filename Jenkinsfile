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
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/easyawslearn/Terraform-Tutorial.git"
                        }
                    }
                }
            }
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

  stage ('Notification') {
    echo "Sent mail notification"
    mail from: "jenkins@mycompany.com",
         to: "devopsteam@mycompany.com",
         subject: "Terraform build complete",
         body: "Jenkins job ${env.JOB_NAME} - build ${env.BUILD_NUMBER} complete"
        
  }
}

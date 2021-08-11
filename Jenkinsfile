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
                            git "https://github.com/manideep-personal/terraform.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd terraform/terraform ; terraform init -input=false'
                echo params.${ami_name}
                echo params.${ami_id}
                echo params.${ami_key_pair_name}
                sh 'pwd;cd terraform/terraform ; terraform workspace new ${environment}'
                sh 'pwd;cd terraform/terraform ; terraform workspace select ${environment}'
                sh "pwd;cd terraform/terraform ;terraform plan -input=false -out tfplan "
                sh 'pwd;cd terraform/terraform ;terraform show -no-color tfplan > tfplan.txt'
                
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd;cd terraform/terraform ; terraform apply -input=false tfplan"
            }
        }
    }

  }

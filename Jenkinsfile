pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-2'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/stevehudgson3/terraform-ec2.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-2') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-2') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-2') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}

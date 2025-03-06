pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-2'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/stevehudgson3/terraform-ec2.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

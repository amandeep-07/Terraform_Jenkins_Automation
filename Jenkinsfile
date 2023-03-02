pipeline {
   environment {
        AWS_CREDENTIALS = credentials('jenkins-terraform')
    }
   agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage ("Start script") {
            steps {
                echo "Shell script  --> ${workspace}"
                sh ("chmod 777 setenv.sh")
                sh ("./setenv.sh ${workspace}") 
            }
        }
        stage ("terraform init") {
            steps {
                sh ("terraform init -reconfigure") 
            }
        }

        stage ("terraform validate") {
            steps {
                sh ("terraform validate") 
            }
        }
        stage ("plan") {
            steps {
                sh ('terraform plan') 
            }
        }

        stage (" Action") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve') 
           }
        }
    }
}
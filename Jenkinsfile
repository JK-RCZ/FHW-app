pipeline {
    agent any

    stages {
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build ./ -t emikadrei/fhw:latest'
                }
            }
        }
        stage('Push Docker Image') {
            when {
                expression {
                    push == 'true'
                }
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                    sh 'docker login -u emikadrei -p ${DockerHubPassword}'
                    }
                    sh 'docker image push emikadrei/fhw'
                    
                }
            }
        }
        stage('Deploy To Staging Server') {
            when {
                expression {
                    branch == 'refs/heads/staging'
                }
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                        sshagent(['Jenkins-deploy-private-key']) {
                           sh 'ssh -t -t -o StrictHostKeyChecking=no ec2-user@3.86.43.12 "sudo docker login -u emikadrei -p ${DockerHubPassword} && sudo docker image pull emikadrei/fhw && sudo docker run emikadrei/fhw > result.txt"'
                        }
                    }    
                }
            }  
        }
        stage('Deploy To Prod Server') {
            when {
                expression {
                    branch == 'refs/heads/production'
                }
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                        sshagent(['jenkins-deploy-to-prod-key']) {
                           sh 'ssh -t -t -o StrictHostKeyChecking=no ec2-user@3.88.40.126 "sudo docker login -u emikadrei -p ${DockerHubPassword} && sudo docker image pull emikadrei/fhw && sudo docker run emikadrei/fhw > result.txt"'
                        }
                    }    
                }
            }  
        }
    }
}
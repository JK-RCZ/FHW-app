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
                           sh 'ssh -t -t -o StrictHostKeyChecking=no ec2-user@54.236.138.151 "sudo docker login -u emikadrei -p ${DockerHubPassword} && sudo docker image pull emikadrei/fhw && sudo docker run emikadrei/fhw > result.txt"'
                           sh 'scp ec2-user@54.236.138.151:/home/ec2-user/result.txt result.txt'
                           
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
                           sh 'ssh -t -t -o StrictHostKeyChecking=no ec2-user@44.211.139.73 "sudo docker login -u emikadrei -p ${DockerHubPassword} && sudo docker image pull emikadrei/fhw && sudo docker run emikadrei/fhw > result.txt"'
                        }
                    }    
                }
            }  
        }
    }
    post {
        always {
           
            archiveArtifacts artifacts: 'result.txt', onlyIfSuccessful: true
        }
    }
}
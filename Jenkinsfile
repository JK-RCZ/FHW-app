pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scmGit(branches: [[name: '*/staging']], extensions: [], userRemoteConfigs: [[credentialsId: '0b33b329-d53f-49c2-8317-819a9fbb546a', url: 'https://github.com/JK-RCZ/FHW-app.git']])
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build ./ -t emikadrei/fhw:latest'
                    echo "${push}" 
                }
            }
        }
        stage('Push Docker Image') {
            when {
                (params.push == true)
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
        stage('Deploy') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                        sshagent(['Jenkins-deploy-private-key']) {
                           sh 'ssh -t -t -o StrictHostKeyChecking=no ec2-user@44.202.162.186 "sudo docker login -u emikadrei -p ${DockerHubPassword} && sudo docker image pull emikadrei/fhw && sudo docker run emikadrei/fhw"'
                        }
                    }    
                    
                }
                
            }  
            
        }
        
    }
}
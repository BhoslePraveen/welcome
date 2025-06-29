pipeline {
    agent any
    
    tools {
		// Specify the Maven tool installed on Jenkins (must match the configured tool name)
		maven "maven-3.9.9"
    }
    
    environment {
		IMAGE_NAME = "praveenvtc/springboot-welcome"
		DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    }

    stages {
        stage('Checkout') {
			steps {
				// Clone the source code from GitHub
				git 'https://github.com/BhoslePraveen/welcome.git'
            }
        }

        stage('Build') {
			steps {
			 dir('welcome') {
                    sh 'mvn clean install'
                }
            }
        }
        
         stage('Docker Build') {
			steps {
                script {
                  app = docker.build("${IMAGE_NAME}", "-f Dockerfile welcome")
                }
            }
        }
        
         stage('Docker Push') {
			steps {
                script {
					docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
						app.push()
                    }
                }
            }
         }  
            
        
    }
}

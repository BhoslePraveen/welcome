pipeline {
	// Use any available Jenkins agent
	agent any

	tools {
		// Specify the Maven tool installed on Jenkins (must match the configured tool name)
		maven "maven-3.9.9"
    }

    environment {
		// Docker image name and tag (you can append :${BUILD_NUMBER} or :latest if needed)
		IMAGE_NAME = "praveenvtc/springboot-welcome"
		 // Jenkins credentials ID for Docker Hub authentication (must be created in Jenkins -> Manage Credentials)
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
				// Build the Spring Boot project using Maven, skipping tests for speed
				sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
			steps {
                script {
					// Build the Docker image from the Dockerfile in the project root
                    // Store the resulting image object in `app` for later push
                    app = docker.build("${IMAGE_NAME}")
                }
            }
        }

         stage('Docker Push') {
			steps {
                script {
					// Push the Docker image to Docker Hub using credentials securely
                    // `docker.withRegistry` logs into the Docker registry and logs out automatically after block
					docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
						app.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
			when {
				// Only run this stage if the branch is 'main' or 'master'
				expression { return env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master' }
			}
			steps {
				// Apply Kubernetes manifests to deploy the application
                // These YAML files must exist in the k8s/ directory in your repo
				sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }

    post {
		success {
			echo "✅ Pipeline completed successfully!"
        }
        failure {
			echo "❌ Pipeline failed. Check logs."
        }
    }
}

pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "latest"
        CONTAINER_NAME = "myapp-container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ArpitaBaraskar/DockerProject'
            }
        }

        stage('Build Application') {
            steps {
                echo "Building the application..."
                bat 'npm install'  // or mvn package / pip install -r requirements.txt
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running tests..."
                bat 'npm test' // optional
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop existing container if running
                    bat """
                    docker ps -q --filter name=${CONTAINER_NAME} | grep -q . && docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME} || true
                    """

                    // Run new container
                    bat "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Application built, dockerized, and running successfully!"
        }
        failure {
            echo "Build failed. Check the logs above."
        }
    }
}

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
                sh 'npm install'  // or mvn package / pip install -r requirements.txt
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running tests..."
                sh 'npm test' // optional
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop existing container if running
                    sh """
                    docker ps -q --filter name=${CONTAINER_NAME} | grep -q . && docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME} || true
                    """

                    // Run new container
                    sh "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${IMAGE_TAG}"
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

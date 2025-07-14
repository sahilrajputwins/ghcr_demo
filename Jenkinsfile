pipeline {
    agent any

    environment {
        IMAGE_NAME = "ghcr.io/sahilrajputwins/testghcr"
        IMAGE_TAG = "latest"
        CONTAINER_NAME = "testghcr_container"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    export DOCKER_BUILDKIT=0
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Login to GHCR') {
            steps {
                withCredentials([string(credentialsId: 'ghcr_PAT', variable: 'GHCR_PAT')]) {
                    sh 'echo $GHCR_PAT | docker login ghcr.io -u sahilrajputwins --password-stdin'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop and remove if already running
                    sh """
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} -p 9090:80 ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout ghcr.io'
        }
    }
}

pipeline {
    agent any

    environment {
        IMAGE_NAME = "demo-app"
        CONTAINER_NAME = "mon-demo"
        PORT_HOST = "8081"
        PORT_CONTAINER = "8081"  // Spring Boot par défaut
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/souleymanedeveloppeur/jenkins-demon.git',
                        credentialsId: 'github-token'  // ID que tu as défini dans Jenkins
                    ]]
                ])
            }
        }

        stage('Build') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Docker Clean Image') {
            steps {
                sh """
                    if docker images | grep -q ${IMAGE_NAME}; then
                        docker rmi -f ${IMAGE_NAME}
                    fi
                """
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Docker Stop & Remove') {
            steps {
                sh """
                    if [ \$(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                        docker stop ${CONTAINER_NAME}
                        docker rm ${CONTAINER_NAME}
                    fi
                """
            }
        }

        stage('Docker Run') {
            steps {
               sh """
                        echo "Running container ${CONTAINER_NAME} on port ${PORT_HOST}:${PORT_CONTAINER}"
                        docker run -d -p ${PORT_HOST}:${PORT_CONTAINER} --name ${CONTAINER_NAME} ${IMAGE_NAME}
                    """
            }
        }
    }
}

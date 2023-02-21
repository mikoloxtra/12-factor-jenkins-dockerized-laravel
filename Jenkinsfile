pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Linting') {
            steps {
                sh 'npm install --silent'
                sh 'npm run lint'
            }
        }
    }
}

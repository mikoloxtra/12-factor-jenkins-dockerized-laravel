pipeline {
    agent any
    
    stages {
        stage('Lint') {
            steps {
                sh 'npm run lint'
            }
        }
        
        stage('Build and Test') {
            parallel {
                stage('Build') {
                    steps {
                        sh 'composer install'
                    }
                }
                
                stage('Test') {
                    steps {
                        sh 'php artisan test'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'composer install'
            }
        }
        
        stage('Dockerize') {
            steps {
                sh 'docker build -t app .'
            }
        }
    }
}

pipeline {
    agent any
    stages {
        
        stage('Linting') {
            steps {
                sh 'composer install --no-interaction --no-progress --prefer-dist'
                sh 'php vendor/bin/phpcs --standard=PSR2 app'
                sh 'php vendor/bin/phpmd app text phpunit.xml'
            }
        }
        stage('Test') {
            environment {
                COMPOSE_PROJECT_NAME = 'app'
            }
            steps {
                sh 'docker compose down'
                sh 'docker compose up -d'
                sh 'docker compose run --rm app php artisan test'
                sh 'docker compose down'
            }
        }
        stage('Build') {
           steps {
                sh 'docker compose down'
                sh 'docker build -t 12factor/app .'
           }
        }
        stage('Deploy') {
            steps {
                sh 'docker compose up -d'
            }
        }
    }
}

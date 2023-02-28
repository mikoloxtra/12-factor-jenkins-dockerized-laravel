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
        parallel{
            stages ('Test'){         
                environment {
                    COMPOSE_PROJECT_NAME = 'app'
                }
                steps {
                    sh 'docker stop 12factor-app-1 '
                    sh 'docker compose up -d'
                    sh 'docker compose run --rm app php artisan test'
                    sh 'docker compose down'
                }
            }
            stage('Build') {
            steps {
                    sh 'docker stop 12factor-app-1'
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
}
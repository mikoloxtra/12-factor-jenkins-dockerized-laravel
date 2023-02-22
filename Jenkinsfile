pipeline {
    agent any

    stages {
        stage('Lint & Test') {
            // Run linting and testing stages in parallel
            parallel {
                stage('Linting') {
                    steps {
                        // Install dependencies and run code sniffer
                        sh 'composer install --no-interaction --no-progress --prefer-dist'
                        sh 'php vendor/bin/phpcs --standard=PSR2 app tests'
                        sh 'php vendor/bin/phpmd app text phpunit.xml'
                    }
                }
                stage('Testing') {
                    environment {
                        // Set the Docker Compose project name to 'app'
                        COMPOSE_PROJECT_NAME = 'app'
                    }
                    steps {
                        // Bring up the Docker environment
                        sh 'docker compose down --volumes --remove-orphans'
                        sh 'docker compose up -d'

                        // Run the Laravel test suite
                        sh 'docker compose run --rm app php artisan test'

                        // Tear down the Docker environment
                        sh 'docker compose down'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                // Build the Docker image
                sh 'docker build -t 12factor/app .'
            }
        }
    }
}

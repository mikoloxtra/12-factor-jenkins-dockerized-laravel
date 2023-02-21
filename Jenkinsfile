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
                sh 'composer install --no-interaction --no-progress --prefer-dist'
                sh 'composer require --dev squizlabs/php_codesniffer'
                sh 'php vendor/bin/phpcs --standard=PSR2 app'
                sh 'php vendor/bin/phpmd app text phpunit.xml'
            }
        }
    }
}

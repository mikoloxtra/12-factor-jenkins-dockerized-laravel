pipeline {
  agent any
  
  stages {
    stage('Test') {
      parallel {
        stage('Test Pipeline step 1') {
          steps {
            sh 'echo "Linting..."'
          }
      }
    }
    
}

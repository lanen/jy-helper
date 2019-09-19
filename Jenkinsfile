pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker { 
            image 'gradle:5.2.1-jdk11' 
            args '-v /root/.gradle:/root/.gradle -v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'gradle clean :application:jy-codemacro-api-spring-boot-app:build -x test'
      }
    }
  }
}

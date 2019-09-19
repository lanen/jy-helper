pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker { 
            image 'gradle:5.2.1-jdk11' 
            args '-v /home/gradle/.gradle:/home/gradle/.gradle -v /home/gradle/.m2:/home/gradle/.m2'
        }
      }
      steps {
        sh './gradlew install'
      }
    }
  }
}

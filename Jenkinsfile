#!groovy

pipeline {
  agent any
  options {
    timestamps()
    ansiColor("xterm")
    buildDiscarder(logRotator(numToKeepStr: "100"))
    timeout(time: 2, unit: "HOURS")
  }
  environment {
      GITHUB_API_URL = "https://api.github.com/repos/cakcuk/librenms-docker/"
  }
    stages {
      stage("Publish commit status") {
        steps {
            sh 'printenv | sort'
            withCredentials([string(credentialsId: 'bde8f904-5da4-459b-b8c6-844281315ff7', variable: 'GITHUB_TOKEN')]) {
              sh 'bash scripts/inprogress.sh'
            }
        }
      }
      stage('Build Docker') {
        steps {
          sh 'docker build -t udienz/librenms:latest .'
        }
      }
      stage('Push Docker Images') {
        steps {
          withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
            sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
            sh 'docker push udienz/librenms:latest'
          }
        }
      } // EOL Docker images
    }
  post {
    success {
        withCredentials([string(credentialsId: 'bde8f904-5da4-459b-b8c6-844281315ff7', variable: 'GITHUB_TOKEN')]) {
              sh 'bash scripts/success.sh'
        }
    }
    unsuccessful {
        withCredentials([string(credentialsId: 'bde8f904-5da4-459b-b8c6-844281315ff7', variable: 'GITHUB_TOKEN')]) {
              sh 'bash scripts/failure.sh'
        }
    }
    //always {
    //    deleteDir()
    //}

  } // eol post
}

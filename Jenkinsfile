// Author: Sebastian Warnholz
pipeline {
    agent { label 'limit-m' }
    options { disableConcurrentBuilds() }
    triggers {
        cron('H 0 * * *')
    }
    environment {
        LABEL = sh(script: '''
        if [ $BRANCH_NAME = "master" ]; then
            echo "latest"
        else
            echo $BRANCH_NAME
        fi
        ''', , returnStdout: true).trim()
    }
    stages {

        stage('Pull Current Versions') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker pull inwt/r-base:$LABEL || echo "not available"
                docker pull inwt/r-batch:$LABEL || echo "not available"
                docker pull inwt/r-shiny:$LABEL || echo "not available"
                docker pull inwt/r-model:$LABEL || echo "not available"
                '''
                }
            }
        }
        stage('r-base') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build --cache-from inwt/r-base:$LABEL -t inwt/r-base:$LABEL r-base
                docker push inwt/r-base:$LABEL
                '''
                }
            }
        }
        stage('r-batch') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build --cache-from inwt/r-batch:$LABEL -t inwt/r-batch:$LABEL r-batch
                docker push inwt/r-batch:$LABEL
                '''
                }
            }
        }
        stage('r-shiny') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build --cache-from inwt/r-shiny:$LABEL -t inwt/r-shiny:$LABEL r-shiny
                docker push inwt/r-shiny:$LABEL
                '''
                }
            }
        }
        stage('r-model') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build --cache-from inwt/r-model:$LABEL -t inwt/r-model:$LABEL r-model
                docker push inwt/r-model:$LABEL
                '''
                }
            }
        }
    }
}

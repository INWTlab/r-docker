// Author: Sebastian Warnholz
pipeline {
    agent { label 'limit-s' }
    options { disableConcurrentBuilds() }
    triggers {
        cron('H 0 * * 0')
    }
    environment {
        LABEL = sh(script: '''
        if [ $BRANCH_NAME = "master" ]; then
            echo "latest"
        else
            echo $BRANCH_NAME
        fi
        ''', , returnStdout: true).trim()
        NWORKERS = 2
        MEMORY = "10g"
    }
    stages {
        stage('r-base') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build -t inwt/r-base:$LABEL r-base
                docker push inwt/r-base:$LABEL
                '''
                }
            }
        }
        stage('r-batch') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build -t inwt/r-batch:$LABEL r-batch
                docker push inwt/r-batch:$LABEL
                '''
                }
            }
        }
        stage('r-shiny') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build -t inwt/r-shiny:$LABEL r-shiny
                docker push inwt/r-shiny:$LABEL
                '''
                }
            }
        }
        stage('r-model') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build -t inwt/r-model:$LABEL r-model
                docker push inwt/r-model:$LABEL
                '''
                }
            }
        }
        stage('r-geos') {
            steps {
                withDockerRegistry([ credentialsId: "jenkins-docker-hub", url: "" ]) {
                sh '''
                docker build -t inwt/r-geos:$LABEL r-geos
                docker push inwt/r-geos:$LABEL
                '''
                }
            }
        }
    }
}

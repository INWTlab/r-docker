// Author: Sebastian Warnholz
pipeline {
    options { disableConcurrentBuilds() }
    stages {

        stage('R Version with Ubuntu') {
            steps {
                sh '''
                docker build --pull -t inwt/r-ver-ubuntu:${env.BRANCH_NAME} r-ver-ubuntu
                docker push inwt/r-ver-ubuntu:${env.BRANCH_NAME}
                '''
            }
        }

    }
}

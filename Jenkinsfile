// Author: Sebastian Warnholz
pipeline {
    agent { label 'eh2' }
    options { disableConcurrentBuilds() }
    stages {

        stage('R Version with Ubuntu') {
            steps {
                sh '''
                if [ $BRANCH_NAME = "master" ]; then
                    LABEL="latest"
                else
                    LABEL=$BRANCH_NAME
                fi
                docker build --pull -t inwt/r-ver-ubuntu:$LABEL r-ver-ubuntu
                docker push inwt/r-ver-ubuntu:$LABEL
                '''
            }
        }

    }
}

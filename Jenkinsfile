pipeline {
    agent any

    parameters {
        choice(name: 'DEPLOY_TARGET',
               choices: ['dev', 'staging', 'prod'],
               description: 'Deployment environment')

        booleanParam(name: 'RUN_HEALTH_CHECK',
                     defaultValue: true,
                     description: 'Run health check')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/RicardsTest/demo-test.git'
            }
        }

        stage('Parallel Validation') {
            parallel {
                stage('Shell Syntax') {
                    steps {
                        sh 'bash -n health-check.sh'
                    }
                }

                stage('File Check') {
                    steps {
                        sh 'test -f health-check.sh'
                    }
                }
            }
        }

        stage('Health Check') {
            when {
                expression { params.RUN_HEALTH_CHECK }
            }
            steps {
                sh 'bash health-check.sh'
            }
        }

        stage('Production Approval') {
            when {
                expression { params.DEPLOY_TARGET == 'prod' }
            }
            steps {
                input message: 'Approve production deployment?'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying to ${params.DEPLOY_TARGET}"
                sh 'mkdir -p deployed'
                sh 'cp health-check.sh deployed/'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'health-check.sh,deployed/**',
                             allowEmptyArchive: true
        }
    }
}

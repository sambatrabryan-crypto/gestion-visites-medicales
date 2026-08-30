pipeline {
    agent any

    stages {

        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/sambatrabryan-crypto/gestion-visites-medicales.git'
            }
        }

        stage('Build') {
            steps {
                bat "mvn clean compile"
            }
        }

        stage('Test') {
            steps {
                bat "mvn test"
            }
        }

        stage('Package') {
            steps {
                bat "mvn package"
            }
        }
    }

    post {
        always {
            junit testResults: 'target/surefire-reports/*.xml', allowEmptyResults: true
            archiveArtifacts artifacts: 'target/*.war', allowEmptyArchive: true
        }
        failure {
            echo "Build en échec — voir la console Jenkins pour les détails."
        }
        success {
            echo "Build réussi 🎉"
        }
    }
}
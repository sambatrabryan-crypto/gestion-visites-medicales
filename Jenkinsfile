pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

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

        stage('Sonar Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    bat "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.10.0.2594:sonar"
                }
            }
        }

             stage('Deploy') {
    steps {
        bat "curl -u deployer:DeployPass123! -T target\\GestionVisites.war \"http://localhost:8082/manager/text/deploy?path=/GestionVisites&update=true\""
    }
}
        stage('Deploy to Nexus') {
            steps {
                bat "mvn deploy -DskipTests"
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
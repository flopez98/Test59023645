pipeline {
    agent any

    stages {
        stage('Master Branch Deployment') {
            when {
                branch 'master'
            }
            steps {
                script {
                    def pomExists = fileExists('pom.xml')
                    def dockerfileExists = fileExists('Dockerfile')
                    
                    if (pomExists) {
                        echo "POM.xml found in workspace. Cleaning, compiling, and packaging..."
                        sh 'mvn clean compile package'
                    } else {
                        error "POM.xml file not found"
                    }

                    if (dockerfileExists) {
                        echo "Dockerfile found in workspace. Building 'webapp-img' Docker image..."
                        sh 'docker build -t webapp-img .'
                        echo "Running a container named 'webapp-container' on port 8064..."
                        sh 'docker run -d -p 8064:8080 --name webapp-container webapp-img'
                    } else {
                        echo "Dockerfile not found"
                    }
                }
            }
        }

        stage('Feature Branch Deployment') {
            when {
                branch 'feature1'
            }
            steps {
                script {
                    echo "Building and packaging the app with the new feature..."
                    sh 'mvn clean compile package'
                    
                    echo "Building 'webapp-img-v1' Docker image..."
                    sh 'docker build -t webapp-img-v1 .'
                    
                    echo "Running a container named 'webapp-container-v1' on port 8076..."
                    sh 'docker run -d -p 8076:8080 --name webapp-container-v1 webapp-img-v1'
                }
            }
        }
    }
}

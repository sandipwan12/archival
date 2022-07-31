pipeline {
    agent any
    tools {
        jdk 'oracle jdk'
    }
    stages {
        stage('Build') {
            steps{
                script{
                    properties([
                        parameters
                            ([
                                    choice(choices: ['nonprod', 'prod'],
                                    description: 'Used to set the environment',
                                    name: 'EnvironmentName')
                            ])
                        ])
                    }
            withMaven(
                 maven: 'maven',
                 mavenLocalRepo: '.localRepo',
                 mavenSettingsFilePath: 'maven_settings.xml')
                 {
                        sh "mvn clean package"
                 }
            }
        }
 
        stage('Upload in s3'){
            steps{
                withAWS(region:'ap-south-1',credentials:'wach-jenkins-cred') {
                  sh 'echo "Uploading content with AWS creds"'
                      s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'target/hello-lambda-function.jar', bucket:'hellotrupti')
                  }
            }
        }
    }
}

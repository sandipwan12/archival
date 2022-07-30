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
                withEnv(["ENV_NAME=${params.EnvironmentName}"]){
                    sh "makefile upload-jar"
                }
            }
        }
    }
}

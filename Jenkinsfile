pipeline {
    agent any
    tools {
        jdk 'OpenJDK-1.8.0'
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
                 maven: 'Default Maven',
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
                     sh "make upload-jar"
                }
            }
        }
    }
}

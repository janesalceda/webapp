pipeline{
    agent any //where to execute
    stages{
        stage("build"){
            steps{
                sh 'npm install'
                sh 'npm build'
                echo 'building the appplication'
            }
        }
        stage("test"){
            steps{
                echo 'testing the appplication'
            }
        }
        stage("deploy"){
            steps{
                echo 'deploying the appplication'
            }
        }
    }
    
}
node{
        //groovy script
}

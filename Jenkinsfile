pipeline {
    agent any
//     parameters {
//   credentials credentialType: 'com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl', defaultValue: '3bc3c0e2-3081-41ef-92ad-09195816a3f7', name: 'AWS_CREDS', required: false
// }
    environment {
        PATH = "${PATH}:${getTerraformPath()}:${getPackerPath()}"
    }
    stages{

         stage('Initial AMI Deployment Approval') {
              steps {
                script {
                def userInput = input(id: 'confirm', message: 'Start Pipeline?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Start Pipeline', name: 'confirm'] ])
             }
           }
        }

        //  stage('packer init'){
        //      steps {
        //          sh "packer.io init "
                 
        //  }
        //  }
         stage('Packer AMI Build'){
             steps {
                 sh """
                 cd images
                 packer init .
                 packer build -force .
                 """
             }
         }
      
    }
}

 def getTerraformPath(){
        def tfHome= tool name: 'terraform-14', type: 'terraform'
        return tfHome
    }

//  def getAnsiblePath(){
//         def AnsibleHome= tool name: 'Ansible', type: 'org.jenkinsci.plugins.ansible.AnsibleInstallation'
//         return AnsibleHome
//     }

def getPackerPath(){
       def PackerHome= tool name: 'Packer', type: 'biz.neustar.jenkins.plugins.packer.PackerInstallation'
}
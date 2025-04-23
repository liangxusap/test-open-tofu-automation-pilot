podTemplate(cloud: 'kubenetes-internal', name: 'test-open-tofu-github-pipeline-feature-branch',
            label: 'test-open-tofu-github-pipeline-feature-branch-label', serviceAccount: 'jenkins-pipeline-sa-by-liangxu', 
            containers: [containerTemplate(name:'jnlp', image:'jenkins/inbound-agent')]) {
    node('test-open-tofu-github-pipeline-feature-branch-label') {
        stage('Init'){
            cleanWs()
            checkout scm
        }
        stage('install open tofu') {
            sh """
                pwd
                ls -ltra
                cat /etc/os-release
                terraform -version
            """
        }
        stage('tofu-plan') {
            sh """
                cd entitlement_subscription
                terraform init
            """
        }
    }
}
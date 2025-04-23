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
                curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
                chmod +x install-opentofu.sh
                ./install-opentofu.sh --install-method deb
                rm -f install-opentofu.sh
                tofu -version
            """
        }
        stage('tofu-plan') {
            sh """
                cd entitlement_subscription
                tofu init
            """
        }
    }
}
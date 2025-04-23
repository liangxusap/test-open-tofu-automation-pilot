podTemplate(cloud: 'kubenetes-internal', name: 'test-open-tofu-github-pipeline-feature-branch',
            label: 'test-open-tofu-github-pipeline-feature-branch-label', serviceAccount: 'jenkins-pipeline-sa-by-liangxu', 
            containers: [containerTemplate(name:'jnlp', image:'jenkins/inbound-agent')
                         containerTemplate(name:'opentofu', image: 'ghcr.io/opentofu/opentofu:latest')]) {
    node('test-open-tofu-github-pipeline-feature-branch-label') {
        stage('Init'){
            cleanWs()
            checkout scm
        }
        stage('tofu actions') {
            container('opentofu'){
                sh """
                    pwd
                    ls -ltra
                    cat /etc/os-release
                    tofu -version
                """
            }

        }
        // stage('tofu-plan') {
        //     sh """
        //         cd entitlement_subscription
        //         terraform init
        //     """
        // }
    }
}
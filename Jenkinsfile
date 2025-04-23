podTemplate(cloud: 'kubenetes-internal', name: 'test-open-tofu-github-pipeline-feature-branch',
            label: 'test-open-tofu-github-pipeline-feature-branch-label', serviceAccount: 'jenkins-pipeline-sa-by-liangxu', 
            agentContainer: 'jnlp',
            agentInjection: true,
            containers: [containerTemplate(name:'jnlp', image:'jenkins/inbound-agent'),
                         containerTemplate(name:'dind', image:'docker')]) {
    node('test-open-tofu-github-pipeline-feature-branch-label') {
        stage('Init'){
            cleanWs()
            checkout scm
        }
        stage('tofu actions') {
            container('dind') {
                docker.image('ghcr.io/opentofu/opentofu:latest').inside('-v $WORKSPACE:./entitlement_subscription -w ./entitlement_subscription') {
                    sh 'version'
                }
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
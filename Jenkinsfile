podTemplate(cloud: 'kubenetes-internal', name: 'test-open-tofu-github-pipeline-feature-branch',
            label: 'test-open-tofu-github-pipeline-feature-branch-label', serviceAccount: 'jenkins-pipeline-sa-by-liangxu', 
            agentContainer: 'dind',
            agentInjection: true,
            containers: [containerTemplate(name:'dind', image:'docker:dind')]) {
    node('test-open-tofu-github-pipeline-feature-branch-label') {
        stage('Init'){
            cleanWs()
            checkout scm
        }
        stage('tofu actions') {
            docker.image('ghcr.io/opentofu/opentofu:latest').inside('-v $WORKSPACE:./entitlement_subscription -w ./entitlement_subscription') {
                sh 'version'
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
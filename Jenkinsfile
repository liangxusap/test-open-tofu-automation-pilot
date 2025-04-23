@Library('piper-lib-os') _
podTemplate(cloud: 'kubenetes-internal', name: 'test-open-tofu-github-pipeline-feature-branch',
            label: 'test-open-tofu-github-pipeline-feature-branch-label', serviceAccount: 'jenkins-pipeline-sa-by-liangxu', 
            containers: [containerTemplate(name:'jnlp', image:'jenkins/inbound-agent')]) {
    node('test-open-tofu-github-pipeline-feature-branch-label') {
        stage('Init'){
            cleanWs()
            checkout scm
            setupCommonPipelineEnvironment script:this
        }
        stage('open tofu actions') {
            dockerExecute(
                script: script,
                dockerImage: 'ghcr.io/opentofu/opentofu:latest',
                dockerWorkspace: './entitlement_subscription'
            ) {
                sh 'version'
            }

        }
    }
}
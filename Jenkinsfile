@Library('piper-lib-os') _
podTemplate(cloud: 'kubenetes-internal', name: 'test-open-tofu-github-pipeline-feature-branch',
            label: 'test-open-tofu-github-pipeline-feature-branch-label', serviceAccount: 'jenkins-pipeline-sa-by-liangxu', 
            containers: [containerTemplate(name:'jnlp', image:'jenkins/inbound-agent')]) {
    node('test-open-tofu-github-pipeline-feature-branch-label') {
        stage('Init'){
            cleanWs()
            scmVars = checkout scm
            prSha = scmVars.GIT_COMMIT
            echo "Pull Request SHA: ${prSha}"
            setupCommonPipelineEnvironment script:this
        }
        stage('open tofu actions') {
            withCredentials([usernamePassword(credentialsId: 'jenkins-secret-for-open-tofu', usernameVariable: 'CREDENTIAL_USER', passwordVariable: 'CREDENTIAL_PASS'),
                             usernamePassword(credentialsId: 'azure_storage_service_principal_open_tofu_backend', usernameVariable: 'servicePrincipalId', passwordVariable: 'servicePrincipalKey'),
                             string(credentialsId: 'azure_storage_account_client_id_open_tofu_backend', variable: 'tenantId'),
                             string(credentialsId: 'azure_storage_account_sub_id_open_tofu_backend', variable: 'Sub_ID')]) {
                env.BTP_USERNAME = CREDENTIAL_USER
                env.BTP_PASSWORD = CREDENTIAL_PASS
                // echo "Username: ${env.BTP_USERNAME}"
                // echo "Password: ${env.BTP_PASSWORD}"
                env.ARM_CLIENT_ID = servicePrincipalId
                env.ARM_CLIENT_SECRET = servicePrincipalKey
                env.ARM_TENANT_ID = tenantId
                env.ARM_SUBSCRIPTION_ID = Sub_ID
                TOFU_PLAN_EXITCODE = ''
                dockerExecute(
                    script: this,
                    dockerImage: 'ghcr.io/opentofu/opentofu:latest',
                    dockerName: 'open-tofu-docker') {
                        sh """
                            pwd
                            ls -ltra
                            cd entitlement_subscription
                            cat main.tf
                            ls -ltra
                            echo ${env.GIT_COMMIT}
                            echo ${env.BUILD_URL}
                            tofu init
                        """
                        TOFU_PLAN_EXITCODE = sh(script: """
                            cd ./entitlement_subscription
                            tofu plan -detailed-exitcode""",
                            returnStatus: true)      
                        }
                        // GIT_SHA = sh(script: """
                        //     git rev-parse HEAD)              
                        //     """)      
                        // echo GIT_SHA
                if (TOFU_PLAN_EXITCODE == 0) {
                    sh """
                        echo "TOFU_PLAN find no change, change in pull request is allowed to be applied to the infrastructure"
                    """
                    githubNotify (status: 'SUCCESS',
                                  repo: 'test-open-tofu-automation-pilot',
                                  credentialsId: 'jenkins-githubnotify-credential', //credential in jenkins
                                  account: 'liangxusap',
                                  sha: '4e38f37bc5e51d125db19817bec6ff3f65a66115',
                                  context: 'jenkins/pipeline')

                } else if (TOFU_PLAN_EXITCODE == 2) {
                    sh """
                        echo "TOFU PLAN identified changes on the infrastructure. First please review pipeline log to check differences"
                    """
                    githubNotify (status: 'PENDING',
                                  repo: 'test-open-tofu-automation-pilot',
                                  credentialsId: 'jenkins-githubnotify-credential', //credential in jenkins
                                  account: 'liangxusap',
                                  sha: '4e38f37bc5e51d125db19817bec6ff3f65a66115',
                                  context: 'jenkins/pipeline')
                } else {
                    sh """
                        echo "TOFU PLAN running into error, please double check the terraform *.tf files, or report to support team"
                    """
                    githubNotify (status: 'FAILURE',
                                  repo: 'test-open-tofu-automation-pilot',
                                  credentialsId: 'jenkins-githubnotify-credential', //credential in jenkins
                                  account: 'liangxusap',
                                  sha: '4e38f37bc5e51d125db19817bec6ff3f65a66115',
                                  context: 'jenkins/pipeline')
                        
                }
            }
            // echo "tofu plan exitcode is : ${TOFU_PLAN_EXITCODE}"
            echo "Username: ${env.BTP_USERNAME}"
            echo "Password: ${env.BTP_PASSWORD}"            
        }
    }
}

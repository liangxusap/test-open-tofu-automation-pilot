# assign a entitlement on subaccount level
resource "btp_subaccount_entitlement" "AUTOMATION_PILOT_TRIAL" {
  subaccount_id = var.subaccount_id
  service_name  = "automationpilot"
  plan_name     = "free"
}
# assign a subscription on subaccount level
resource "btp_subaccount_subscription" "AUTOMATION_PILOT_TRIAL_SUBSCRIPTION" {
  subaccount_id = var.subaccount_id
  app_name      = "automationpilot"
  plan_name     = "free"
  depends_on    = [btp_subaccount_entitlement.AUTOMATION_PILOT_TRIAL]
}
# assign a single user to a role collection on subaccount level
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_ADMIN" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Admin"
  user_name            = var.user_name
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_ADMIN_WITH_GENAI" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Admin_With_GenAI"
  user_name            = var.user_name
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_DEVELOPER" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Developer"
  user_name            = var.user_name
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_DEVELOPER_WITH_GENAI" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Developer_With_GenAI"
  user_name            = var.user_name
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cxp-shared"                               # Description: The Name of the Resource Group in which the Storage Account exists. (string)
    storage_account_name = "stacxpshared6vh6qk6onyi8"                    # Description: The Name of the Storage Account in which the Blob container is residing. (string)
    subscription_id      = "86b0d4f8-1c81-4fd2-bbb1-75b952e7f48a"        # Description: The Azure subscription ID. (string)
    key                  = "test-state-file-by-liangxu.tfstate"                             # Description: The name of the Blob used to retrieve/store Terraform's State file inside the Storage Container. (string)
    container_name       = "terraform-state-test-by-liangxu"             # Action required. Description: The Name of the Storage Container within the Storage Account in which the Terraform state file will be stored. (string)
    access_key           = "Dummy_value"
  }
}
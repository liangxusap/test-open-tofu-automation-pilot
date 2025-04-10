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
  user_name            = "liang.xu04@sap.com"
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_ADMIN_WITH_GENAI" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Admin_With_GenAI"
  user_name            = "liang.xu04@sap.com"
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_DEVELOPER" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Developer"
  user_name            = "liang.xu04@sap.com"
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
resource "btp_subaccount_role_collection_assignment" "AUTOMATION_PILOT_DEVELOPER_WITH_GENAI" {
  subaccount_id        = var.subaccount_id
  role_collection_name = "AutomationPilot_Developer_With_GenAI"
  user_name            = "liang.xu04@sap.com"
  origin               = "sap.default"
  depends_on    = [btp_subaccount_subscription.AUTOMATION_PILOT_TRIAL_SUBSCRIPTION]
}
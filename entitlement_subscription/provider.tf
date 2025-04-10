terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "1.11.0"
    }
  }
}
provider "btp" {
  globalaccount = "ZZZ"
}
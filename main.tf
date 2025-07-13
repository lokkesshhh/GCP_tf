#     # The configuration for the `remote` backend.
terraform {
  backend "remote" {
    #         # The name of your Terraform Cloud organization.
    organization = "GCP_lokesh"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "GCP_tf"
    }
  }
}

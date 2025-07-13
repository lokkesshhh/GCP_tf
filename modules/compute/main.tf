provider "google" {
  project = "phonic-presence-310804"
  region  = var.region
  zone    = var.zone
}

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

resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = var.instance
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["dev", "test"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = var.my_label
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    env = "dev"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

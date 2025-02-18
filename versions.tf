terraform {
  required_version = ">= 1.9"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.8.0, < 7"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4"
    }
  }
}

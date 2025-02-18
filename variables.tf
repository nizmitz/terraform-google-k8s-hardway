variable "project_id" {
  type        = string
  description = "Project id of the project that holds the network."
}

variable "region" {
  type        = string
  default     = "asia-southeast1"
  description = "Region of the project that is hosted."
}

variable "zone" {
  type        = string
  default     = "a"
  description = "Zone of the project that is hosted."
}

variable "ip_cidr_range" {
  type        = list(string)
  default     = ["10.0.0.0/24"]
  description = "ip range that will be used for the vpc"
}

variable "network_tier" {
  type        = string
  default     = "STANDARD"
  description = "Network tier for rest of the instances"
}

variable "os_project" {
  type        = string
  default     = "debian-cloud"
  description = "OS public project names for the instances"
}

variable "os_family" {
  type        = string
  default     = "debian-12"
  description = "OS family for the instances"
}

variable "ssh_user" {
  type        = string
  default     = "terraform"
  description = "SSH user that will be used for all the instances"
}

variable "jumphost_instance" {
  type = object({
    name         = string
    machine_type = string
    description  = string
    network_tags = list(string)
    disk_size    = number
  })

  default = {
    name         = "jumphost"
    machine_type = "e2-micro"
    description  = "jumphost instance"
    network_tags = ["jumphost", "kubernetes"]
    disk_size    = 10
  }
  description = "Specification that will be used for jumphost instance"
}

variable "control_plane_instance" {

  type = object({
    name         = string
    machine_type = string
    description  = string
    network_tags = list(string)
    disk_size    = number
  })

  default = {
    name         = "control-plane"
    machine_type = "e2-small"
    description  = "worker instance"
    network_tags = ["master", "kubernetes"]
    disk_size    = 20
  }
  description = "Specification that will be used for control plane instance"
}

variable "worker_instance" {

  type = object({
    name         = string
    machine_type = string
    description  = string
    network_tags = list(string)
    disk_size    = number
  })

  default = {
    name         = "worker"
    machine_type = "e2-small"
    description  = "worker instance"
    network_tags = ["worker", "kubernetes"]
    disk_size    = 20
  }
  description = "Specification that will be used for worker instance"
}

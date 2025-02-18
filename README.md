## Terraform Google k8s hardway

This module is created due to my frustration on creating new infrastructure whenever i wanted to try to create my own cluster for learning Kubernetes the Hardway by Kelsey Hightower. 

This module all the necessary resources for the project, although there is one big catch and this is assuming you are like me using a free tier of GCP.
The catch being that this will use amd64 architecture instead of the latest which use arm. you can change the instance type and os type but the GCP free tier doesn't have the quota for arm 


to use the module you can use as follow
Example
```
module "k8s-hardway" {
  source  = "nizmitz/k8s-hardway/google"
  version = "1.0.0"
  project_id = "agnes-learning-project-3"
}
```

References:
https://github.com/kelseyhightower/kubernetes-the-hard-way

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.8.0, < 7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.8.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.this_jumphost](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.this_all_internal](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.this_ssh_external](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.this_control_plane](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance.this_jumphost](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance.this_worker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [google_compute_image.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane_instance"></a> [control\_plane\_instance](#input\_control\_plane\_instance) | Specification that will be used for control plane instance | <pre>object({<br/>    name         = string<br/>    machine_type = string<br/>    description  = string<br/>    network_tags = list(string)<br/>    disk_size    = number<br/>  })</pre> | <pre>{<br/>  "description": "worker instance",<br/>  "disk_size": 20,<br/>  "machine_type": "e2-small",<br/>  "name": "control-plane",<br/>  "network_tags": [<br/>    "master",<br/>    "kubernetes"<br/>  ]<br/>}</pre> | no |
| <a name="input_ip_cidr_range"></a> [ip\_cidr\_range](#input\_ip\_cidr\_range) | ip range that will be used for the vpc | `list(string)` | <pre>[<br/>  "10.0.0.0/24"<br/>]</pre> | no |
| <a name="input_jumphost_instance"></a> [jumphost\_instance](#input\_jumphost\_instance) | Specification that will be used for jumphost instance | <pre>object({<br/>    name         = string<br/>    machine_type = string<br/>    description  = string<br/>    network_tags = list(string)<br/>    disk_size    = number<br/>  })</pre> | <pre>{<br/>  "description": "jumphost instance",<br/>  "disk_size": 10,<br/>  "machine_type": "e2-micro",<br/>  "name": "jumphost",<br/>  "network_tags": [<br/>    "jumphost",<br/>    "kubernetes"<br/>  ]<br/>}</pre> | no |
| <a name="input_network_tier"></a> [network\_tier](#input\_network\_tier) | Network tier for rest of the instances | `string` | `"STANDARD"` | no |
| <a name="input_os_family"></a> [os\_family](#input\_os\_family) | OS family for the instances | `string` | `"debian-12"` | no |
| <a name="input_os_project"></a> [os\_project](#input\_os\_project) | OS public project names for the instances | `string` | `"debian-cloud"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id of the project that holds the network. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region of the project that is hosted. | `string` | `"asia-southeast1"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | SSH user that will be used for all the instances | `string` | `"terraform"` | no |
| <a name="input_worker_instance"></a> [worker\_instance](#input\_worker\_instance) | Specification that will be used for worker instance | <pre>object({<br/>    name         = string<br/>    machine_type = string<br/>    description  = string<br/>    network_tags = list(string)<br/>    disk_size    = number<br/>  })</pre> | <pre>{<br/>  "description": "worker instance",<br/>  "disk_size": 20,<br/>  "machine_type": "e2-small",<br/>  "name": "worker",<br/>  "network_tags": [<br/>    "worker",<br/>    "kubernetes"<br/>  ]<br/>}</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone of the project that is hosted. | `string` | `"a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_ssh_private_key"></a> [ssh\_private\_key](#output\_ssh\_private\_key) | n/a |
| <a name="output_ssh_user"></a> [ssh\_user](#output\_ssh\_user) | n/a |
| <a name="output_zone"></a> [zone](#output\_zone) | n/a |
<!-- END_TF_DOCS -->
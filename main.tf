locals {
  ibm_powervs_zone_region_map = {
    "syd04"    = "syd"
    "syd05"    = "syd"
    "sao01"    = "sao"
    "sao04"    = "sao"
    "tor01"    = "tor"
    "mon01"    = "mon"
    "eu-de-1"  = "eu-de"
    "eu-de-2"  = "eu-de"
    "mad02"    = "mad"
    "mad04"    = "mad"
    "lon04"    = "lon"
    "lon06"    = "lon"
    "osa21"    = "osa"
    "tok04"    = "tok"
    "us-south" = "us-south"
    "dal10"    = "us-south"
    "dal12"    = "us-south"
    "us-east"  = "us-east"
    "wdc06"    = "us-east"
    "wdc07"    = "us-east"
  }

  ibm_powervs_zone_cloud_region_map = {
    "syd04"    = "au-syd"
    "syd05"    = "au-syd"
    "sao01"    = "br-sao"
    "sao04"    = "br-sao"
    "tor01"    = "ca-tor"
    "mon01"    = "ca-tor"
    "eu-de-1"  = "eu-de"
    "eu-de-2"  = "eu-de"
    "mad02"    = "eu-es"
    "mad04"    = "eu-es"
    "lon04"    = "eu-gb"
    "lon06"    = "eu-gb"
    "osa21"    = "jp-osa"
    "tok04"    = "jp-tok"
    "us-south" = "us-south"
    "dal10"    = "us-south"
    "dal12"    = "us-south"
    "us-east"  = "us-east"
    "wdc06"    = "us-east"
    "wdc07"    = "us-east"
  }
}

# There are discrepancies between the region inputs on the powervs terraform resource, and the vpc ("is") resources
provider "ibm" {
  region           = lookup(local.ibm_powervs_zone_region_map, var.pi_zone, null)
  zone             = var.pi_zone
  ibmcloud_api_key = var.ibmcloud_api_key != null ? var.ibmcloud_api_key : null
}

locals {
  service_type = "power-iaas"
  plan         = "power-virtual-server-group"
}

data "ibm_resource_group" "resource_group_ds" {
  name = "Automation"
}

resource "ibm_resource_instance" "pi_workspace" {
  name              = var.pi_workspace_name
  service           = local.service_type
  plan              = local.plan
  location          = var.pi_zone
  resource_group_id = data.ibm_resource_group.resource_group_ds.id
  tags              = (var.pi_tags != null ? var.pi_tags : [])

  timeouts {
    create = "6m"
    update = "5m"
    delete = "10m"
  }
}

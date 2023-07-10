exisiting_resource_group_name = "goodaction-dev-RG"
adgroup                       = ["infra"]
vnet = {
  "vnet-a" = {
    name          = "vnet-a"
    is_source     = true
    address_space = ["10.10.0.0/16"]
    subnets = [
      {
        name   = "subnet-a"
        prefix = "10.10.0.0/24"
      },
      {
        name   = "subnet-b"
        prefix = "10.10.1.0/24"
      }
    ],
  }
  "vnet-b" = {
    name          = "vnet-a"
    is_source     = false
    address_space = ["10.11.0.0/16"]
    subnets = [
      {
        name   = "subnet-a"
        prefix = "10.11.0.0/24"
      },
      {
        name   = "subnet-b"
        prefix = "10.11.1.0/24"
      }
    ],
  }
}
nat_gateway_name = "nat"
computer_name    = "natvm"
admin_username   = "vmnat"

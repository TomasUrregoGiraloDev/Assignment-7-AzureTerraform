variable "resource_group_name" {
  default = "rg-terraform-webapp"
}

variable "location" {
  default = "East US"
}

variable "app_service_plan_name" {
  default = "asp-terraform-webapp"
}

variable "app_name" {
  default = "myterraformwebapp123" # debe ser único globalmente
}

locals {
    date_of_creation = formatdate("YYYY-MM-DD", timestamp())
    default_tags = { 
        Environment = var.environment
        CreatedBy   = "Terraform"
        CreatedOn   = local.date_of_creation
        Product_Name = var.product_name
    }
}

# provider "aws" {
#     region = var.aws_region
#     #You need to create / add profile settings on Terraform Cloud (Environment Variables)
#     #profile = "terraform-codebase"       
# }

resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy
    enable_dns_support = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = merge(
                var.vpc_tags, 
                local.default_tags, 
                {
                    "Name" = "vpc-${var.product_name}-${var.environment}"
                }
    )
}

locals {
    date_of_creation = formatdate("YYYY-MM-DD", timestamp())
    default_tags = { 
        Environment = var.environment
        CreatedBy   = "Terraform"
        CreatedOn   = local.date_of_creation
        Product_Name = var.product_name
    }
}


resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy
    enable_dns_support = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = "${merge(
                var.vpc_tags, 
                local.default_tags, 
                map(
                    "Name", "vpc-${var.var.product_name}-${var.environment}")
                )
            }"
}

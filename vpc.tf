// Define the AWS provider and specify the region for resource deployment.
provider "aws" {
    region = "eu-west-2"
}

// Declare variables for CIDR blocks of the VPC and subnets.
variable vpc_cidr_block {}
variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}

// Retrieve available availability zones for the region.
data "aws_availability_zones" "available" {}

// Configure the VPC module with appropriate CIDR blocks and subnets.
module "myapp-vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.64.0"

    name = "myapp-vpc"
    cidr = var.vpc_cidr_block

    // Define private and public subnets using variables for flexibility and reusability.
    private_subnets = var.private_subnet_cidr_blocks
    public_subnets = var.public_subnet_cidr_blocks

    // Use all available availability zones for high availability and fault tolerance.
    azs = data.aws_availability_zones.available.names 
    
    // Enable NAT Gateway to allow private subnet instances to access the internet securely.
    enable_nat_gateway = true
    single_nat_gateway = true // Using a single NAT Gateway for cost efficiency.

    // Enable DNS hostnames for easy access and management of resources within the VPC.
    enable_dns_hostnames = true

    // Tag subnets for Kubernetes to recognize and manage load balancers appropriately.
    tags = {
        "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    }

    // Public subnet tags for external load balancer.
    public_subnet_tags = {
        "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
        "kubernetes.io/role/elb" = 1 
    }

    // Private subnet tags for internal load balancer.
    private_subnet_tags = {
        "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb" = 1 
    }
}
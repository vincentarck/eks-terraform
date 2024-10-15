// Define the AWS provider configuration, specifying the region where resources will be deployed.
// The chosen region, "eu-west-2", corresponds to the AWS Europe (London) region.
provider "aws" {
    region = "eu-west-2"
}

// Declare variables for the CIDR blocks of the VPC and subnets.
// These variables allow flexibility in specifying network ranges during deployment.
variable vpc_cidr_block {}
variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}

// Retrieve the list of available availability zones within the specified region.
// This data source is used to ensure that resources are distributed across multiple zones for redundancy.
data "aws_availability_zones" "available" {}

// Configure the VPC module using the official Terraform AWS VPC module.
// This module abstracts the complexity of creating and managing a VPC and its associated components.
module "myapp-vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.64.0" // Specifies the module version to ensure compatibility and consistency.

    // Define the name of the VPC for identification purposes.
    name = "myapp-vpc"
    
    // Set the CIDR block for the VPC, which defines the IP address range for the network.
    cidr = var.vpc_cidr_block

    // Define the private subnets using provided CIDR blocks.
    // Private subnets are used for resources that do not require direct access to the internet.
    private_subnets = var.private_subnet_cidr_blocks

    // Define the public subnets using provided CIDR blocks.
    // Public subnets are used for resources that need to be accessible from the internet, such as load balancers.
    public_subnets = var.public_subnet_cidr_blocks

    // Distribute resources across all available availability zones for high availability and fault tolerance.
    azs = data.aws_availability_zones.available.names 
    
    // Enable a NAT Gateway to allow instances in private subnets to access the internet securely.
    // This is necessary for tasks such as downloading updates or accessing external APIs.
    enable_nat_gateway = true
    single_nat_gateway = true // Use a single NAT Gateway for cost efficiency while maintaining functionality.

    // Enable DNS hostnames within the VPC, facilitating the resolution of domain names to IP addresses.
    enable_dns_hostnames = true

    // Apply tags to the VPC and subnets for Kubernetes integration.
    // These tags help Kubernetes identify which subnets to use for specific purposes, such as load balancing.
    tags = {
        "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    }

    // Apply specific tags to public subnets for external load balancers.
    // The "elb" role indicates that these subnets can host resources accessible from the internet.
    public_subnet_tags = {
        "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
        "kubernetes.io/role/elb" = 1 
    }

    // Apply specific tags to private subnets for internal load balancers.
    // The "internal-elb" role indicates that these subnets are used for internal communication within the cluster.
    private_subnet_tags = {
        "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb" = 1 
    }
}
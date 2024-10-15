module "eks" {
  // Source module for creating an EKS cluster using the official Terraform AWS EKS module.
  // This module simplifies the provisioning of EKS resources and associated components.
  source  = "terraform-aws-modules/eks/aws"
  version = "18.21.0" // Specifies the version of the module to ensure compatibility and stability.

  // Name of the EKS cluster. This name is used for identifying the cluster in the AWS console and CLI.
  cluster_name = "myapp-eks-cluster"
  
  // Kubernetes version for the EKS cluster. It is important to choose a version that is supported by AWS
  // and aligns with your application's compatibility requirements.
  cluster_version = "1.22"

  // Specifies the private subnets within the VPC where the EKS cluster will be deployed.
  // Using private subnets enhances security by restricting direct access to the internet.
  subnet_ids = module.myapp-vpc.private_subnets
  
  // The VPC ID where the EKS cluster will be provisioned. This ensures that the cluster is deployed
  // within the defined network boundaries and can communicate with other resources in the VPC.
  vpc_id = module.myapp-vpc.vpc_id

  // Tags applied to the EKS cluster for identification and management purposes.
  // These tags can be used for cost allocation, organization, and automation.
  tags = {
    environment = "development" // Indicates the environment type, useful for separating resources by stage.
    application = "myapp"       // Identifies the application associated with the cluster.
  }

  // Configuration for EKS managed node groups, which are groups of worker nodes managed by AWS.
  // Managed node groups simplify node management by automating updates and scaling.
  eks_managed_node_groups = {
    dev = {
      // Minimum number of nodes in the node group. Ensures that there is always at least one node running.
      min_size     = 1
      // Maximum number of nodes to which the node group can scale. Provides flexibility for handling increased load.
      max_size     = 3
      // Desired number of nodes in the node group. This is the target number of nodes for normal operation.
      desired_size = 3

      // Specifies the instance types for the nodes in the group. Selecting the appropriate instance type
      // is crucial for balancing cost and performance.
      instance_types = ["t2.small"] // t2.small is a cost-effective choice for development environments.
    }
  }
}
# Automate Provisioning EKS Cluster with Terraform

This project demonstrates how to automate the provisioning of an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform. This approach offers several advantages, including:

* **Consistency:** Ensuring all resources are provisioned in a predictable and consistent manner.
* **Speed:** Rapidly deploying infrastructure by automating the entire provisioning process.
* **Repeatability:** Easily recreating the EKS cluster with the same configuration.
* **Version Control:** Managing configuration changes through Git, allowing for trackable updates and rollbacks.


## Project Setup

1. **Prerequisites:**
   - AWS Account with appropriate permissions.
   - Terraform installed and configured.
   - AWS CLI installed and configured.

2. **Configure AWS Credentials:**
   - Set up your AWS credentials using the AWS CLI or environment variables.

3. **Install Terraform:**
   - Install Terraform on your system.

4. **Initialize Terraform:**
   - Navigate to the project directory.
   - Run `terraform init` to download the required providers.

5. **Configure Variables:**
   - Set up variables in `variables.tf` to customize the EKS cluster. For example, the desired number of nodes, instance type, and cluster name.

6. **Apply Terraform:**
   - Run `terraform apply` to provision the EKS cluster.

7. **Verify Deployment:**
   - After successful application, check the AWS console for the provisioned resources.

## Key Concepts

* **EKS Cluster:** The core component of the deployment, providing a managed Kubernetes environment.
* **Control Plane:** Manages and controls the cluster, including nodes, services, and deployments.
* **Worker Nodes:** Virtual machines running in an availability zone, where containerized applications are deployed.
* **Availability Zones:** Isolated physical locations within a region, ensuring high availability.
* **Terraform:** A tool for defining infrastructure as code, enabling automated provisioning and configuration management.

## Code Breakdown

The `vpc.ts` and `eks-cluster.tf` file contains the core Terraform configuration, which is divided into several sections:

* **VPC Module:** Configures the VPC, dependencies for data usage i.e list of AZ's, including subnets, availability zones, and NAT gateways.
* **EKS Cluster:** Creates the EKS cluster, specifying the control plane and worker nodes.
* **Node Group:** Defines the worker node group, including instance type, count, and availability zones.

## Benefits

This project offers several benefits, including:

* **Streamlined Provisioning:** Automates the entire provisioning process, reducing manual effort and potential errors.
* **Consistency:** Ensures consistent infrastructure deployment across environments.
* **Version Control:** Allows for trackable changes and rollbacks, ensuring infrastructure configuration is always up-to-date.

## Conclusion

This project demonstrates the power of automating EKS cluster provisioning using Terraform. By leveraging infrastructure as code, you can efficiently manage and maintain your Kubernetes environment, ensuring consistency, speed, and repeatability.

![EKS Cluster Architecture](https://github.com/vincentarck/automate-provisioning-eks-cluster-with-terraform/blob/main/eks-cluster-architecture.png)

> Note: Replace `your-username` with your actual GitHub username.

This README provides a comprehensive overview of the project, including setup and key concepts. It also highlights the benefits of automating EKS cluster provisioning with Terraform.

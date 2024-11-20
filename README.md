# **AWS Infrastructure Automation with Terraform**

This project demonstrates how to automate the creation and management of AWS infrastructure using Terraform. It includes provisioning key AWS resources such as EC2 instances, S3 buckets, and DynamoDB tables, while utilizing Terraform modules for modular and reusable configurations.

## **Overview**

Before Terraform, setting up infrastructure involved manual, error-prone processes. Terraform solves these issues by using **Infrastructure as Code (IaC)** to:
- Automate resource creation and updates.
- Ensure consistent environments.
- Manage infrastructure across multiple cloud providers.
- Simplify scaling and collaboration.

---

## **Why Terraform?**

### **Challenges Before Terraform**:
1. **Manual Setup**: Time-consuming and inconsistent configurations.
2. **Inconsistent Environments**: Subtle differences between environments caused bugs.
3. **Complex Scaling**: Difficult to update or scale resources manually.
4. **Collaboration Issues**: Lack of version control for infrastructure changes.

### **How Terraform Helps**:
- **Automation**: Write infrastructure as code for automatic deployment.
- **Consistency**: Ensure identical environments for development, staging, and production.
- **Multi-Cloud**: Manage resources across different providers with a single tool.
- **Scalability**: Easily scale or update infrastructure by changing code.
- **Collaboration**: Share and track changes with version control.

---

## **Comparison: Terraform vs Ansible**

| Feature                    | Terraform                             | Ansible                              |
|----------------------------|---------------------------------------|--------------------------------------|
| **Purpose**                | Infrastructure provisioning           | Configuration management             |
| **State Management**       | Maintains a state file                | Stateless                            |
| **Approach**               | Declarative (desired state)           | Procedural (task-based)              |
| **Best Use Case**          | Multi-cloud infrastructure orchestration | Server configuration and application setup |

Many teams use both tools together: Terraform provisions infrastructure, and Ansible configures it.

---

## **Project Setup**

### **Prerequisites**
- **Install Terraform**: [Install Terraform](https://developer.hashicorp.com/terraform/install)
- **Install AWS CLI**: Configure your AWS credentials with IAM access keys.

### **Steps to Set Up the Project**
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Connect Terraform to AWS**:
   - Create an IAM user and configure access keys in AWS CLI.
   ```bash
   aws configure
   ```
3. **Create an SSH Key Pair**:
   To create a key pair for the EC2 instance, use the following command:
   ```bash
   ssh-keygen
   ```
   This will generate:
   - A public key file: `<key-name>.pub`
   - A private key file: `<key-name>`

   Use the public key to configure the AWS key pair resource in Terraform.

4. **Provision Resources**:
   - **Plan**: View the changes Terraform will make.
     ```bash
     terraform plan
     ```
   - **Apply**: Apply the changes to provision resources.
     ```bash
     terraform apply
     ```

### **Resources Created**
- **EC2 Instance**: A virtual machine with custom configurations.
  - VPC, security group, and key pair setup included.
- **S3 Bucket**: For object storage.
- **DynamoDB Table**: For key-value data storage.

---

## **Working with Modules**

Modules are reusable components for managing resources efficiently. In this project:
- The `aws_infra` module includes:
  - **my_bucket.tf**: Defines S3 bucket.
  - **my_instance.tf**: Defines EC2 instance.
  - **my_table.tf**: Defines DynamoDB table.
  - **variables.tf**: Parameterizes configurations for reusability.

### **Using Modules**
- Define environments like `dev`, `staging`, and `production`.
- Adjust instance count for scaling in production environments.

Example:
```hcl
module "dev-app" {
  source        = "./aws_infra"
  environment   = "dev"
  instance_type = "t2.micro"
}

module "prod-app" {
  source        = "./aws_infra"
  environment   = "production"
  instance_type = "t2.medium"
  instance_count = 3
}
```

---

## **Managing Infrastructure**

### **Common Commands**
- **View Current State**:
  ```bash
  terraform state list
  ```
- **Destroy Specific Resource**:
  ```bash
  terraform destroy -target=<resource>
  ```
- **Destroy All Resources**:
  ```bash
  terraform destroy
  ```

### **Troubleshooting**
If you encounter errors, ensure:
1. Default VPC has a valid subnet.
2. Use the `terraform apply -target` command for incremental resource application:
   ```bash
   terraform apply -target=aws_subnet.default_subnet
   terraform apply -target=aws_security_group.my_security_group
   ```

---

## **Connecting to EC2**
Once the EC2 instance is created, connect using SSH:
```bash
ssh -i "<key-name>.pem" ubuntu@<instance-public-ip>
```

---

## **Future Enhancements**
- Add more resources and environments using modules.
- Automate configuration management with tools like Ansible.
- Integrate Terraform state storage in a remote backend (e.g., S3 bucket).

---

## **Conclusion**
This project showcases how Terraform simplifies AWS infrastructure management. By using modules and IaC principles, it provides a scalable, reusable, and maintainable solution for provisioning resources in multi-environment setups.
```

This README now includes the `ssh-keygen` step under **Steps to Set Up the Project**. Save it as `README.md` in your project directory. Let me know if you need further assistance!

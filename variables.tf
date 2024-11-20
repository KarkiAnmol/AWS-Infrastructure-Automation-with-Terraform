variable "dynamodb_table_name" {
    type = string 
    default = "GameScores"
    description = "This is table name for dynamo db"
}
# variable "subnet_id" {
#   description = "The ID of the subnet to launch the instance in"
#   type        = string

# }
# variable "security_group_ids" {
#   description = "List of security group IDs to assign to the instance"
#   type        = list(string)
# }

variable "ami_id" {
    description = "AMI ID for the EC2 ubuntu instance"
    default = "ami-0dee22c13ea7a9a67"
}
variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "ap-south-1"
}
variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}
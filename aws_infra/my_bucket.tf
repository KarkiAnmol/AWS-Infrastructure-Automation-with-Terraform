#s3 bucket
resource "aws_s3_bucket" "my-bucket" {
    bucket = "${var.my-env}-trial-bucket-anmol"
    force_destroy = true
    tags = {
        Name = "${var.my-env}-trial-bucket-anmol" 
        environment = var.my-env
    }
}
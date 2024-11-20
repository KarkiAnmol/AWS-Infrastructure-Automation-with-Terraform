# Create an S3 bucket
resource "aws_s3_bucket" "my-bucket" {
    bucket = "trial-bucket-anmol"
    force_destroy = true
    tags = {
        Name = "trial-bucket-anmol" 
    }
}
output "bucket_name" {
  value = aws_s3_bucket.my-bucket.bucket
}

output "instance_ids" {
  value = aws_instance.my-ec2-instance.*.id
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "resume-bucket" {
  bucket = "saffat-resume-bucket"
  acl = "private"
}

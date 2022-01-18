
provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
}
terraform {
  backend "s3" {
    bucket = "[my-remote-bucket-2022]"
    key    = "[my-remote-bucket-2022]"
    region = "eu-central-1"
  }
}
resource "aws_s3_bucket" "s3Bucket" {
  bucket = "[my-remote-bucket-2022]"
  acl    = "public-read"

  policy = <<EOF
{
  "Id": "MakePublic",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::[my-remote-bucket-2022]/*",
      "Principal": "*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }
}

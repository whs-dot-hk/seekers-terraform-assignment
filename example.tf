provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "greeting.whs.hk"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
  }
}

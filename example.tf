provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "greeting" {
  bucket = "greeting.whs.hk"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
  }
}

resource "aws_route53_zone" "greeting" {
  name = "greeting.whs.hk"
}

resource "aws_route53_record" "greeting" {
  zone_id = "${aws_route53_zone.greeting.zone_id}"
  name    = "greeting.whs.hk"
  type    = "A"

  alias {
    name = "${aws_s3_bucket.greeting.website_domain}"
    zone_id = "${aws_s3_bucket.greeting.hosted_zone_id}"
    evaluate_target_health = true
  }
}

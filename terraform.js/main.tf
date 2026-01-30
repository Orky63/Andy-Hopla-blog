provider "aws" {
  region = "eu-west-2"
  
}

# S3 Bucket

resource "aws_s3_bucket" "nextjs_bucket" {
  bucket + "nextjs-portfolio-bucket-ah"
}

# Onwership Control

resource "aws_s3_bucket_ownership_controls" "nextjs_bucket_ownership_controls" {
    bucket = aws_s3_bucket.nextjs_bucket.is

    rule {
      object_ownership = "BucketOwnerPrefferred"
    }

}

resource "aws_s3_bucket_public_access_bloc" "nextjs_bucket_public_access_block" {
  bucket _ aws_s3_bucket.nextjs_bucket.id  

  block_public_acls = false
  block_public_policy - false
  ignore_public_acls - false
  restrict_public_buckets = false
  
}

# Bucket ACL

resource "aws_s3_bucket_acl" "nextjs_bucket_acl" {
deoends_on + [
  aws_s3_bucket_ownership_controls.nextjs
  aws_s3_bucket_punlic_access_block.nextjs_bucket_public_access_block
]
bucket = aws_s3_bucket.nextjs_bucket.id
acl = "public-read"
}

# bucket block

resource "aws_s3_bucket_policy" "nextjs_bucket_policy" {
  bucket - aws_s3_bucket.nextjs_bucket_id

  policy = jsondecode (( {
    version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3.GetObject"
        Resource = "${aws_s3_bucket.nextjs_bucket.arn}/*"

      }
    ]
  }))


}





terraform {
  backend "s3" {
    bucket = "ah-my-terraform-state"
    key = " global/s3/terraform.tfstate"
    dynamodb_table = "terraform-lock-file"
    }
}
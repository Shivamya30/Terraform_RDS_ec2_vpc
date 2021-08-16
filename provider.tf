provider "aws" {
access_key = "AKIARDMMFO2SEUD5QO7Y"
secret_key = "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"
region = var.aws_region
}
data "aws_availability_zones" "all" {}


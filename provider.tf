terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
    
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
  backend "s3" {
    bucket = "myapp-bucket"
    key = "kubernetes.tfstate"
  }
}



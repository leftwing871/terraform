terraform {
    backend "s3" { 
      bucket         = "terraform-s3-bucket-demo" # s3 bucket 이름(Bucket Versioning: Enable)
      key            = "terraform/own-your-path/terraform.tfstate" # s3 내에서 저장되는 경로를 의미합니다.
      region         = "ap-northeast-2"  
      encrypt        = false
      dynamodb_table = "terraform-demo-lock" ##DDB table 이름(Column: LockID)
    }
}
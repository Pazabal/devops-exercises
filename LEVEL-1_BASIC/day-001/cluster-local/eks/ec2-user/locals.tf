locals {
  name = "DevOps-Exam"
  env = "exam"
  region = "us-west-2"
  vpc_id = "vpc-68368b0e"
  subnet_ids = ["subnet-12b37c74", "subnet-caf61782"]

  istio_chart_url     = "https://istio-release.storage.googleapis.com/charts"
  istio_chart_version = "1.20.2"
  
}

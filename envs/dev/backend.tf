terraform {
  backend "gcs" {
    bucket = "vizru-tfstate"
    prefix = "terraform/dev/state"
  }
}
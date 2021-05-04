variable "s3_bucket_objects" {
  description = "S3 Bucket Objects names"
  type        = list(string)
  default     = ["temp/", "uploads/", "stats/", "downloads/"]
}

variable "iam_user_name" {
  description = "User name"
  type        = string
  default     = ""
}

variable "s3_bucket_bucket" {
  description = "S3 Bucket name"
  type        = string
  default     = ""
}

variable "user-terraform" {
  type        = string
  description = ""
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-09d56f8956ab235b3"
}
variable "rds_password" {
  type        = string
  description = "password for RDS"
  default     = "12345678"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"
}

variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}


variable "rds_username" {
  type        = string
  description = "username for RDS"
  default     = "root"
}

variable "rds_database" {
  type        = string
  description = "database name for RDS"
  default     = "rds_database"
}

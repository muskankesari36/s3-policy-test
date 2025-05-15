variable "aws_region" {
  description = "name of aws_region. Eg. 'eu-west-1'"
  type        = string
}

variable "vpc_log_bucket_name" {
  type = string
}
variable "vpc_details" {
  type = object({
    vpc_name   = string
    cidr_block = string
    enable_dns_hostnames = bool
  })

  description = "cidr ranges that libryo environment will use"
}

variable "tags" {
  type = map(string)

  description = "mandatory tags need to be supplied"

  default = {}
}

variable "vpc_flow_log_config_defaults" {
  type = object({
    log_destination_type = string

  })

  default = {
    log_destination_type = "s3"
  }
}

variable "vpc_flow_log_config" {
  type = object({
    enable_vpc_flow_log  = bool
    vpc_flow_log_name    = string
    log_destination_type = optional(string)
    traffic_type         = string
  })
}
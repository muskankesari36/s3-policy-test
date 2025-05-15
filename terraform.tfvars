aws_region = "eu-west-1"

vpc_log_bucket_name = "test-vpc-flow-log234"

vpc_details = {
  vpc_name   = "my-vpc"
  cidr_block = "10.82.64.0/22"
  enable_dns_hostnames = true
}

vpc_flow_log_config = {
  enable_vpc_flow_log = true
  vpc_flow_log_name   = "test-vpc-flow-log234"
  traffic_type        = "REJECT"
}
resource "aws_cloudtrail" "security" {
  name                          = local.trail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    exclude_management_event_sources = [
      "kms.amazonaws.com",
      "rdsdata.amazonaws.com"
    ]
  }

  depends_on = [
    aws_s3_bucket_policy.cloudtrail_logs,
    aws_s3_bucket_public_access_block.cloudtrail_logs,
    aws_s3_bucket_server_side_encryption_configuration.cloudtrail_logs,
    aws_s3_bucket_versioning.cloudtrail_logs
  ]
}

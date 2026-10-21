# Security findings and limitations

Checkov 3.3.30: 55 passed, 8 failed, 0 skipped.
The scan assessed the Terraform configuration after the live resources
had been destroyed. Findings remain visible and are not suppressed.

| Check | Gap | Implication and production improvement |
|---|---|---|
| CKV_AWS_252 | No CloudTrail SNS topic | No delivery notifications through SNS. Add a topic and verified subscribers where required. |
| CKV_AWS_35 | No customer-managed KMS key for CloudTrail | Logs use S3 AES256 encryption. Add KMS for separate key policy and key-use auditing. |
| CKV_AWS_18 | No S3 server access logging | Bucket access is not covered by server access logs; S3 data events are also not configured. Add an appropriate access-auditing mechanism. |
| CKV2_AWS_61 | No lifecycle configuration | Retention is manual. Define retention and noncurrent-version expiration for a persistent deployment. |
| CKV_AWS_144 | No cross-region replication | No replicated recovery copy. Add replication where recovery requirements justify it. |
| CKV2_AWS_62 | No S3 event notifications | Log arrival does not trigger downstream processing. Add notifications if needed. |
| CKV2_AWS_10 | No CloudWatch Logs integration | No CloudWatch metric filters or alarms for these logs. Add integration and tested detections for operational monitoring. |
| CKV_AWS_145 | No default S3 KMS encryption | SSE-S3 AES256 was verified live. Add KMS if customer-controlled keys are required. |

## Scope and evidence limits

- This was a temporary learning deployment, not a production monitoring service.
- These gaps are documented limitations, not formally approved enterprise exceptions.
- Management events were configured across regions, excluding KMS and RDS Data API events.
- Data events and CloudTrail Insights were not configured.
- Log delivery and sample event contents were verified.
- Log-file validation was enabled and digest delivery observed; cryptographic integrity validation was not performed.
- Auditor lookup succeeded in eu-north-1 and was denied in eu-west-1.
- IAM ListRoles was denied for the auditor. Destructive write operations were not attempted.
- IAM Access Analyzer returned no findings for the auditor identity policy.
- Terraform reported no drift before cleanup.
- All eight resources were destroyed; AWS APIs confirmed the bucket, role and trail were absent.
- Budget email verification remains pending with AWS Support.

data "aws_iam_policy_document" "auditor_permissions" {
  statement {
    sid       = "ReadRegionalEventHistory"
    effect    = "Allow"
    actions   = ["cloudtrail:LookupEvents"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["eu-north-1"]
    }
  }
}

resource "aws_iam_role_policy" "auditor_permissions" {
  name   = "lab05-cloudtrail-event-history"
  role   = aws_iam_role.security_auditor.id
  policy = data.aws_iam_policy_document.auditor_permissions.json
}

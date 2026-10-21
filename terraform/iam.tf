data "aws_iam_role" "lab_operator" {
  name = "AccountFullAccessRole"
}

data "aws_iam_policy_document" "lab_role_trust" {
  statement {
    sid     = "AllowLabOperator"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_role.lab_operator.arn]
    }
  }
}

resource "aws_iam_role" "security_auditor" {
  name                 = "lab05-security-auditor"
  description          = "Lab 5 role for restricted CloudTrail auditing"
  assume_role_policy   = data.aws_iam_policy_document.lab_role_trust.json
  max_session_duration = 3600
}

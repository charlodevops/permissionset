data "aws_ssoadmin_instances" "example" {}

resource "aws_ssoadmin_permission_set" "example" {
  name             = "ExamplePermissionSet"
  instance_arn     = tolist(data.aws_ssoadmin_instances.example.arns)[0]
  session_duration = "PT1H"
}

data "aws_iam_policy_document" "example" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "example" {
  inline_policy      = data.aws_iam_policy_document.example.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.example.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.example.arn
}

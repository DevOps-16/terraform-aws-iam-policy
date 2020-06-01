# ------------------------------------------------------------------------------
# AWS Identity and Access Management (IAM)
# ------------------------------------------------------------------------------
# IAM POLICY
# ------------------------------------------------------------------------------
# You manage access in AWS by creating policies and attaching them to IAM
# identities (users, groups of users, or roles) or AWS resources.
# A policy is an object in AWS that, when associated with an identity or
# resource, defines their permissions.
#
# AWS Documentation IAM:
#   - https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
#   - https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html
#
# Terraform AWS Provider Documentation:
#   - https://www.terraform.io/docs/providers/aws/r/iam_policy.html
# ------------------------------------------------------------------------------

locals {
  create_policy = var.policy == null && length(var.policy_statements) > 0
  policy        = local.create_policy ? data.aws_iam_policy_document.policy[0].json : var.policy
}

resource "aws_iam_policy" "policy" {
  count = var.module_enabled ? 1 : 0

  name        = var.name
  name_prefix = var.name_prefix
  description = var.description
  path        = var.path

  policy = local.policy

  depends_on = [var.module_depends_on]
}

data "aws_iam_policy_document" "policy" {
  count = var.module_enabled && local.create_policy ? 1 : 0

  dynamic "statement" {
    for_each = var.policy_statements

    content {
      sid           = try(statement.value.sid, null)
      effect        = try(statement.value.effect, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

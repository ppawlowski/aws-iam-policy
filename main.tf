data "aws_iam_policy_document" "policy_document" {
  dynamic "statement" {
    for_each = [for single_statement in var.iam_policy_statements : {
      effect = lookup(single_statement, "effect", "Allow")
      actions = lookup(single_statement, "actions", null )
      resources = lookup(single_statement, "resources", null )
      condition = lookup(single_statement, "condition", [] )
    } ]
    content {
      effect = statement.value.effect
      actions = statement.value.actions
      resources = statement.value.resources

      dynamic "condition" {
        for_each = statement.value.condition
        content {
          test = condition.value.test
          variable = condition.value.variable
          values = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_policy" "policy" {
  name = var.iam_policy_name
  policy = data.aws_iam_policy_document.policy_document.json
}
Terraform module for managing [AWS IAM identity-based policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_id-based).

---
###Usage

```hcl-terraform
module "my_policy" {
  source = "../modules/iam_policy"
  iam_policy_name = "my_unique_policy"
  iam_policy_statements = [
    {
      actions = [
        "ssm:DescribeParameters"
      ]
      resources = [
        "*"
      ]
    },
    {
      actions = [
        "ssm:GetParameter*",
      ]
      resources = [
        "arn:aws:ssm:*:*:parameter/*"
      ]
      condition = [
        {
          test = "StringLike"
          variable = "aws:ResourceTag/env"
          values = [
            "dev"
          ]
        }]
    }
  ]
}
```

### Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|iam_policy_name|The name of a policy.|string|``|yes|
|iam_policy_statements|A list of maps with policy statements. Detailed configuration available below.|list|`[]`|yes|

#### iam_policy_statements attributes

| A full list of available actions, resources and conditions for each AWS service is available [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_actions-resources-contextkeys.html).   |
| --- |

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|effect|Either "Allow" or "Deny", to specify whether this statement allows or denies the given actions.|string|`Allow`|no|
|actions|A list of actions that this statement either allows or denies.|list|`null`|no|
|resources|A list of resource ARNs that this statement applies to. This is required by AWS if used for an IAM policy.|list|`null`|no|
|condition|A nested configuration block (described below) that defines a further, possibly-service-specific condition that constrains whether this statement applies.|list|`[]`|no|

#### iam_policy_statement.condition attributes
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|test|The name of the IAM condition operator to evaluate.|string|``|yes|
|variable|The name of a Context Variable to apply the condition to.|string|``|yes|
|values|The values to evaluate the condition against.|list|``|yes|

###Outputs

| Name | Description |
|------|-------------|
|policy_arn|The ARN of created policy.|

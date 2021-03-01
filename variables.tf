variable "iam_policy_name" {
  type = string
  description = "The name of a policy."
}

variable "iam_policy_statements" {
// variable type not defined due to a possibility to have a list with elements of different type
  description = "A list of maps with policy statements."
}
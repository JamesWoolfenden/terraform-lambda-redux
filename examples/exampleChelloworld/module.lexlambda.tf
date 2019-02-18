module "lexlambda" {
  source = "github.com/jameswoolfenden/terraform-aws-lex-lambda"

  lambdapermmisions = [{
    action       = "lambda:InvokeFunction"
    statementid  = "helloworld"
    functionname = "${var.name}"
    sourcearn    = "arn:aws:lex:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:intent:helloworld:*"
    principal    = "lex.amazonaws.com"
  }]

  description      = "${var.description}"
  name             = "${var.name}"
  filename         = "${path.cwd}/lambda.zip"
  policyname       = "${var.name}"
  region_name      = "${data.aws_region.current.name}"
  role_name        = "${var.role_name}"
  account_id       = "${data.aws_caller_identity.current.account_id}"
  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"
  common_tags      = "${var.common_tags}"
  passedrole       = true
}
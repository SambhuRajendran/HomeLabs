terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "athira"
}

resource "aws_instance" "test1" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "Ubuntuecccccc"
  }
}

resource "aws_instance" "test2" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "NewEC2"
  }

}

resource "aws_sns_topic" "terraform_notifications" {
  name = "ec2deploy"
}

resource "aws_sns_topic_subscription" "ec2deploy" {
  topic_arn = "arn:aws:sns:us-east-1:275141806628:ec2deploy"
  protocol  = "email"
  endpoint  = "rsambhu619@gmail.com"
}

resource "null_resource" "notify_create" {
  provisioner "local-exec" {
    command = "aws sns publish --profile athira --topic-arn 'arn:aws:sns:us-east-1:275141806628:ec2deploy' --message 'Resources Created!'"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [aws_instance.test1, aws_instance.test2]
}

resource "null_resource" "notify_destroy" {
  provisioner "local-exec" {
    when    = "destroy"
    command = "aws sns publish --profile athira --region us-east-1 --topic-arn 'arn:aws:sns:us-east-1:275141806628:ec2deploy' --message 'Resources Destroyed!'"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [aws_instance.test1, aws_instance.test2]
}
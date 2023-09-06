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
  region  = var.regiao_aws
}

resource "aws_instance" "doc_server" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = var.instancia
  key_name = var.chave
  tags = {
    Name = "Documentation Server"
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

output "IP_publico" {
  value = aws_instance.doc_server.public_ip
}
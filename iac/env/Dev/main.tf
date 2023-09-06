module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "../../../../chaves/IaC-DEV"
  grupo_de_seguranca = "acesso_geral_dev"
}

output "IP" {
  value = module.aws-dev.IP_publico
}
# Módulo RDS com Secrets Manager

## Descrição

Este módulo cria uma instância **RDS do zero** (PostgreSQL, MySQL, etc.) com:

- Credenciais **geradas automaticamente** (usuário e senha aleatórios);
- Armazenamento seguro no **AWS Secrets Manager** (`rds/<db_identifier>`);
- Configurações customizáveis de rede, armazenamento e backup;
- Totalmente gerenciado via Terraform.

---

## Recursos criados

- `aws_db_instance`
- `aws_secretsmanager_secret`
- `aws_secretsmanager_secret_version`
- `random_string`
- `random_password`

---

## Estrutura do módulo

modules/
└── rds/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md


---

## Exemplo de uso

### Criando uma instância PostgreSQL com credenciais automáticas

```
module "rds" {
  source = "../../modules/rds"

  db_identifier           = "monorepo-accounts-prod"
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.m6g.large"
  allocated_storage       = 200
  storage_type            = "gp3"
  db_subnet_group_name    = "rds-prod-subnet-group"
  vpc_security_group_ids  = ["sg-0abcd12345efgh678"]
  multi_az                = true
  publicly_accessible     = false
  deletion_protection     = true
  backup_retention_period = 7

  tags = {
    Environment = "prod"
    ManagedBy   = "Terraform"
    Team        = "DevOps"
  }
}

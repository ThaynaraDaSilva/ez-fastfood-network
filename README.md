# ez-fastfood-network

Este repositório é dedicado à configuração dos **recursos de rede** do projeto **ez-fastfood** na nuvem AWS. Todos os recursos aqui provisionados estão estritamente relacionados à infraestrutura de rede, utilizando o Terraform para garantir uma gestão eficiente e modular.


Os recursos foram organizados em módulos Terraform, com os seguintes componentes:

### 1. VPC (Virtual Private Cloud)
- **ez-fastfood-vpc-dev**: VPC principal para o ambiente de desenvolvimento.
- **ez-fastfood-public-subnet1**: sub-rede pública 1.
- **ez-fastfood-public-subnet2**: sub-rede pública 2.
- **ez-fastfood-private-subnet1**: sub-rede privada 1.
- **ez-fastfood-public-rt-subnet1**: tabela de roteamento pública associada à sub-rede 1.
- **ez-fastfood-private-rt-subnet1**: tabela de roteamento privada associada à sub-rede 1.

### 2. Security Group
- **ez-fastfood-rds-sg-dev**: security group para controle de tráfego de rede relacionado ao banco de dados RDS no ambiente de desenvolvimento.

### 3. Internet Gateway
- **ez-fastfood-igw-dev**: internet gateway para permitir a conexão da VPC com a internet.

### Pré-requisitos (execução via pipeline)
**1. Terraform**
**2. Credenciais AWS**: Configure as credenciais AWS para permitir o provisionamento de recursos.  

No pipeline configurado no GitHub Actions, as credenciais foram armazenadas como **secret variables** para evitar exposição direta no código:  
  - **AWS_ACCESS_KEY_ID**  
  - **AWS_SECRET_ACCESS_KEY**

## Links dos demais repositórios:
- APIs: https://github.com/ThaynaraDaSilva/ez-fastfood-api
- EKS:https://github.com/ThaynaraDaSilva/ez-fastfood-eks
- Lambda: https://github.com/ThaynaraDaSilva/ez-fastfood-authentication
- RDS: https://github.com/ThaynaraDaSilva/ez-fastfood-database

## Desenvolvido por:
@tchfer : RM357414<br>
@ThaynaraDaSilva : RM357418<br>
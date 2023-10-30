![Static Badge](https://img.shields.io/badge/cloud-black?style=for-the-badge) ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

![Static Badge](https://img.shields.io/badge/IaC-black?style=for-the-badge) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

# 🍔 Fast & Foodious - IaC ![Static Badge](https://img.shields.io/badge/v3.0.0-version?logo=&color=%232496ED&labelColor=white&label=fast-n-foodious)
Sistema de auto-atendimento de fast food. Projeto de conclusão da Fase 03 da pós gradução em Software Architecture.

![fast-n-foodious-aws](fast-n-foodious-aws.png)


## Módulo IaC: Storage
Repositório de criação de infraestrutura cloud AWS, responsável por criar os seguintes recursos:

```
fast-n-foodious-iac-storage
├── fnf-rds.tf                                  # Definição de recurso Cluster RDS 
├── main.tf                                     # Definição de terraform providers e backend 
├── outputs.tf                                  # Definição de terraform outputs, necessários em módulos externos
├── remote.state.tf                             # Definição de terraform remote state, necessário no módulo local
└── scripts                                     # Scripts de inicialização de banco de dados
```
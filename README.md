![Static Badge](https://img.shields.io/badge/cloud-black?style=for-the-badge) ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

![Static Badge](https://img.shields.io/badge/IaC-black?style=for-the-badge) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

# 🍔 Fast & Foodious - IaC Storage ![Github Actions](https://github.com/rodrigo-ottero/fast-n-foodious-iac-storage/actions/workflows/fnf-pipeline.yml/badge.svg?branch=main) ![Static Badge](https://img.shields.io/badge/v2.0.0-version?logo=&color=%232496ED&labelColor=white&label=fast-n-foodious-iac-storage)
Sistema de auto-atendimento de fast food. Projeto de conclusão da Fase 05 da pós gradução em Software Architecture.

![fast-n-foodious-aws](fast-n-foodious-aws.png)


## Recursos
Repositório de criação de infraestrutura cloud AWS, responsável por criar os seguintes recursos:

```
fast-n-foodious-iac-storage
├── fnf-rds.tf                                  # Definição de recurso Cluster RDS
├── fnf-documentdb.tf                           # Definição de recurso Cluster DocumentDB 
├── main.tf                                     # Definição de terraform providers e backend 
├── outputs.tf                                  # Definição de terraform outputs, necessários em módulos externos
├── remote.state.tf                             # Definição de terraform remote state, necessário no módulo local
└── scripts                                     # Scripts de inicialização de banco de dados
```

## Links Externos
### Micro Serviços
- [fast-n-foodious-ms-produto](https://github.com/rodrigo-ottero/fast-n-foodious-ms-produto)
- [fast-n-foodious-ms-pagamento](https://github.com/rodrigo-ottero/fast-n-foodious-ms-pagamento)
- [fast-n-foodious-ms-pedido](https://github.com/rodrigo-ottero/fast-n-foodious-ms-pedido)

### IaC
- [fast-n-foodious-iac-network](https://github.com/rodrigo-ottero/fast-n-foodious-iac-network)
- [fast-n-foodious-iac-storage](https://github.com/rodrigo-ottero/fast-n-foodious-iac-storage)
- [fast-n-foodious-iac-compute](https://github.com/rodrigo-ottero/fast-n-foodious-iac-compute)

### Sonar
- [fast-n-foodious-ms-produto](https://sonarcloud.io/summary/overall?id=fast-n-foodious-org_ms-produto)
- [fast-n-foodious-ms-pagamento](https://sonarcloud.io/summary/overall?id=fast-n-foodious-org_fast-n-foodious-ms-pagamento)
- [fast-n-foodious-ms-pedido](https://sonarcloud.io/summary/overall?id=fast-n-foodious-org_fast-n-foodious-ms-pedido)

### Monday
- [fast-n-foodious](https://fast-n-foodious.monday.com/workspaces/4361241)
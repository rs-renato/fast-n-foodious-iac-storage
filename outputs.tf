output "fnf-rds-cluster-produto_endpoint" {
  value = aws_rds_cluster.fnf-rds-cluster-produto.endpoint
}

output "fnf-rds-cluster-produto_master_password" {
  value = aws_rds_cluster.fnf-rds-cluster-produto.master_password
  sensitive = true
}

output "fnf-rds-cluster-pedido_endpoint" {
  value = aws_rds_cluster.fnf-rds-cluster-pedido.endpoint
}

output "fnf-rds-cluster-pedido_master_password" {
  value = aws_rds_cluster.fnf-rds-cluster-pedido.master_password
  sensitive = true
}
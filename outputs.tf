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

output "fnf-doc-cluster-pagamento_endpoint" {
  value = aws_docdb_cluster.fnf-doc-cluster-pagamento.endpoint
}

output "fnf-doc-cluster-pagamento_master_username" {
  value = aws_docdb_cluster.fnf-doc-cluster-pagamento.master_username
}

output "fnf-doc-cluster-pagamento_master_password" {
  value = aws_docdb_cluster.fnf-doc-cluster-pagamento.master_password
  sensitive = true
}
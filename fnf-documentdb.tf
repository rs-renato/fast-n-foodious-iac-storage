resource "aws_docdb_cluster" "fnf-doc-cluster-pagamento" {
  cluster_identifier = "fnf-doc-cluster-pagamento"
  engine = "docdb"
  storage_type = "standard"
  master_username      = "fnf_user"
  master_password      = random_password.fnf-random-passoword-documentdb.result
  skip_final_snapshot = true
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.fnf-doc-database-security-group_id]
  db_subnet_group_name = aws_db_subnet_group.fnf-db-subnet-group.name
  storage_encrypted = false
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.fnf-doc-cluster-parameters.name
}

resource "aws_docdb_cluster_instance" "fnf-doc-cluster-instance" {
  cluster_identifier = aws_docdb_cluster.fnf-doc-cluster-pagamento.cluster_identifier
  instance_class = "db.t3.medium"
}

resource "aws_docdb_cluster_parameter_group" "fnf-doc-cluster-parameters" {
  family = "docdb5.0"
  name = "fnf-doc-cluster-parameters"
  
  parameter {
    name = "tls"
    value = "disabled"
  }
}
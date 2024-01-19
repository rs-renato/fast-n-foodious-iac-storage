resource "aws_rds_cluster" "fnf-rds-cluster-produto" {
  cluster_identifier = "fnf-rds-cluster-produto"
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.11.3"
  engine_mode          = "serverless"
  database_name        = "FAST_N_FOODIOUS"
  master_username      = "fnf_user"
  master_password      = random_password.fnf-random-passoword.result
  enable_http_endpoint = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.fnf-database-security-group_id, data.terraform_remote_state.network.outputs.fnf-cluster-security-group_id]
  db_subnet_group_name = aws_db_subnet_group.fnf-db-subnet-group.name

  scaling_configuration {
    min_capacity = 1
    max_capacity = 1
  }
}

resource "aws_rds_cluster" "fnf-rds-cluster-pedido" {
  cluster_identifier = "fnf-rds-cluster-pedido"
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.11.3"
  engine_mode          = "serverless"
  database_name        = "FAST_N_FOODIOUS"
  master_username      = "fnf_user"
  master_password      = random_password.fnf-random-passoword.result
  enable_http_endpoint = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.fnf-database-security-group_id, data.terraform_remote_state.network.outputs.fnf-cluster-security-group_id]
  db_subnet_group_name = aws_db_subnet_group.fnf-db-subnet-group.name

  scaling_configuration {
    min_capacity = 1
    max_capacity = 1
  }
}

resource "aws_db_subnet_group" "fnf-db-subnet-group" {
  name       = "fnf-db-subnet-group"
  subnet_ids = [ data.terraform_remote_state.network.outputs.fnf-subnet-private1-us-east-1a_id, data.terraform_remote_state.network.outputs.fnf-subnet-private2-us-east-1b_id]
  tags = {
    Name = "database subnet group"
  }
}

resource "aws_secretsmanager_secret" "fnf-secret-rds-produto" {
  name = "fnf-secret-rds-produto"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret" "fnf-secret-rds-pedido" {
  name = "fnf-secret-rds-pedido"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "fnf-secret-version-produto" {
  secret_id     = aws_secretsmanager_secret.fnf-secret-rds-produto.id
  secret_string = jsonencode({
    username = aws_rds_cluster.fnf-rds-cluster-produto.master_username,
    password = aws_rds_cluster.fnf-rds-cluster-produto.master_password,
    engine = "mysql",
    host = aws_rds_cluster.fnf-rds-cluster-produto.endpoint
  })
}

resource "aws_secretsmanager_secret_version" "fnf-secret-version-pedido" {
  secret_id     = aws_secretsmanager_secret.fnf-secret-rds-pedido.id
  secret_string = jsonencode({
    username = aws_rds_cluster.fnf-rds-cluster-pedido.master_username,
    password = aws_rds_cluster.fnf-rds-cluster-pedido.master_password,
    engine = "mysql",
    host = aws_rds_cluster.fnf-rds-cluster-pedido.endpoint
  })
}

resource "random_password" "fnf-random-passoword" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "fnf-random-passoword-documentdb" {
  length           = 16
  special          = false
}

resource "null_resource" "rds-produto-initialization" {
    triggers = {
      init = filesha1("${path.module}/scripts/schema/produto/1-init-produto.sql")
      populate = filesha1("${path.module}/scripts/schema/produto/2-populate-produto.sql")
    }

    provisioner "local-exec" {
      interpreter=["/bin/bash", "-c"]
      command = <<-EOF
            # iterate over all sql files
            for file in schema/produto/*.sql; do
                sql_block=""
                # iterate over each line
                while IFS='' read -r line || [[ -n "$line" ]]; do
                    # Skip lines starting with -- (comments)
                    if [[ "$line" =~ ^\s*-- ]]; then
                        continue
                    fi

                    # Concatenate the line to the sql_block variable
                    sql_block="$sql_block $line"

                    # If the line ends with a semicolon, execute the SQL block and reset the sql_block variable
                    if [[ "$line" == *";" ]]; then
                        # Output the SQL block (optional, for debugging purposes)
                        echo "$sql_block"

                        # Execute the SQL block using aws rds-data
                        aws rds-data execute-statement --resource-arn "$DB_ARN" --database "$DB_NAME" --secret-arn "$SECRET_ARN" --sql "$sql_block" --region us-east-1

                        # Reset the sql_block variable
                        sql_block=""
                    fi
                done < $file
            done
        EOF

        environment = {
            DB_ARN     = aws_rds_cluster.fnf-rds-cluster-produto.arn
            DB_NAME    = aws_rds_cluster.fnf-rds-cluster-produto.database_name
            SECRET_ARN = aws_secretsmanager_secret.fnf-secret-rds-produto.arn
        }
    
        working_dir = "${path.module}/scripts"
  }
}


resource "null_resource" "rds-pedido-initialization" {
    triggers = {
      init = filesha1("${path.module}/scripts/schema/pedido/1-init-pedido.sql")
    }

    provisioner "local-exec" {
      interpreter=["/bin/bash", "-c"]
      command = <<-EOF
            # iterate over all sql files
            for file in schema/pedido/*.sql; do
                sql_block=""
                # iterate over each line
                while IFS='' read -r line || [[ -n "$line" ]]; do
                    # Skip lines starting with -- (comments)
                    if [[ "$line" =~ ^\s*-- ]]; then
                        continue
                    fi

                    # Concatenate the line to the sql_block variable
                    sql_block="$sql_block $line"

                    # If the line ends with a semicolon, execute the SQL block and reset the sql_block variable
                    if [[ "$line" == *";" ]]; then
                        # Output the SQL block (optional, for debugging purposes)
                        echo "$sql_block"

                        # Execute the SQL block using aws rds-data
                        aws rds-data execute-statement --resource-arn "$DB_ARN" --database "$DB_NAME" --secret-arn "$SECRET_ARN" --sql "$sql_block" --region us-east-1

                        # Reset the sql_block variable
                        sql_block=""
                    fi
                done < $file
            done
        EOF

        environment = {
            DB_ARN     = aws_rds_cluster.fnf-rds-cluster-pedido.arn
            DB_NAME    = aws_rds_cluster.fnf-rds-cluster-pedido.database_name
            SECRET_ARN = aws_secretsmanager_secret.fnf-secret-rds-pedido.arn
        }
    
        working_dir = "${path.module}/scripts"
  }
}

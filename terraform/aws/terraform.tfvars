#########################################
#      3Edges Cloud Deployment          #
# These Terraform scripts deploy 3Edges #
# In the selected Cloud.                #
#                                       #
# Update the variables below with the   #
# right values for your environment.    #
#                                       #
# copyright 3edges, August 2024         #
#########################################

# The AWS region where resources will be deployed (e.g., ca-west-1)
aws_region = "your-aws-region"

# The AWS access key ID for authentication
aws_access_key_id = "your-aws-access-key-id"

# The AWS secret access key for authentication
aws_secret_access_key = "your-aws-secret-access-key"

# The Domain name for the 3Edges Deployment
hosted_zone = "your-domain"

# The name of the EKS cluster
eks_cluster = "your-eks-cluster-name"

# Name of the three edges cluster
cluster_config_config_CLUSTER = "cluster-name"

# Email address from which emails are sent
shared_config_SEND_EMAIL_FROM = "noreply@your-domain.com"

# Name displayed as the sender in emails
shared_config_SEND_EMAIL_FROM_NAME = "Your-email-Name"

# Neo4j database (eg., neo4j+s://<db>)
three_edges_DB_HOST = "your-database-host"

# Database name
three_edges_DB_NAME = "your-database-name"

# Database user
three_edges_DB_USER = "your-database-user"

# Database type (eg., neo4j)
three_edges_DB_TYPE = "your-database-type"

# Database version (eg., v5)
three_edges_DB_VERSION = "your-database-version"

# Database password
three_edges_secret_DB_PASSWORD = "your-database-password"

# Primary admin email address
shared_config_PRIM_ADMIN_EMAIL = "admin@your-domain.com"

# Primary admin password
configuration_config_secret_PRIM_ADMIN_PASS = "your-admin-password"
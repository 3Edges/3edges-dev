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

aws_region = "ca-west-1"

hosted_zone = "vanquisher.tech"

eks_cluster = "three-edges-cluster-praj"

aws_access_key_id = ""

aws_secret_access_key = ""

config_SEND_EMAIL_FROM = "noreply@abotega.ca"

config_PRIM_ADMIN_EMAIL = "3admin@abotega.ca"

config_PRIM_SERVER_HTTP_CORS_ORIGIN = "https://abotega.ca"

config_PRIM_SERVER_HTTP_CORS_DEFAULT_ORIGIN = "https://abotega.ca"

config_DB_HOST = "neo4j+s://ae61ebf7.databases.neo4j.io"

config_DB_NAME = "neo4j"

config_DB_USER = "neo4j"

config_CLUSTER_URL = "https://cluster.abotega.ca/api"

config_DEFAULT_CONTENT_SECURITY_POLICY_API_DASHBOARD = "default-src 'self' *.abotega.ca https://auth-qa.credivera.com https://vc-qa.credivera.io https://ipv4.icanhazip.com https://api.ipify.com; script-src 'self' http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' www.gstatic.com/recaptcha data:; font-src 'self' https://fonts.gstatic.com; frame-src 'self' *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com; style-src 'self' https://fonts.googleapis.com 'unsafe-inline';"

config_PRIM_SERVER_HTTP_CORS_ORIGIN_IDP = "https://idp.abotega.ca"

config_DEFAULT_CONTENT_SECURITY_POLICY = "default-src 'self' *.abotega.ca https://embeddable-sandbox.cdn.apollographql.com/ https://auth-qa.credivera.com https://vc-qa.credivera.io https://ipv4.icanhazip.com https://api.ipify.com https://apollo-server-landing-page.cdn.apollographql.com; script-src 'self' https://embeddable-sandbox.cdn.apollographql.com/ http://conoret.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://www.google.com/recaptcha/ https://apollo-server-landing-page.cdn.apollographql.com/ 'unsafe-inline' 'unsafe-eval'; img-src 'self' https://apollo-server-landing-page.cdn.apollographql.com data:; frame-src 'self' https://sandbox.embed.apollographql.com/ *.recaptcha.net recaptcha.net https://www.google.com/recaptcha/ https://recaptcha.google.com https://apollo-server-landing-page.cdn.apollographql.com; style-src 'self' https://fonts.googleapis.com https://apollo-server-landing-page.cdn.apollographql.com 'unsafe-inline'; font-src 'self' https://fonts.gstatic.com https://apollo-server-landing-page.cdn.apollographql.com;"

config_UI_URL = "https://abotega.ca"

config_OIDC_URL = "https://idp.abotega.ca/oidc"

config_secret_NEO4J_PASSWORD_TEST = ""

config_secret_DB_PASSWORD = ""

config_secret_PRIM_ADMIN_PASS = ""

config_secret_OIDC_CLIENT_PWD = ""


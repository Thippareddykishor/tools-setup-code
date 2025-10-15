terraform {
  backend "s3" {
    bucket = "terraform-b87"
    key = "vault-secrets/state"
    region = "us-east-1"
  }
}

provider "vault" {
  address = "http://vault-internal.kommanuthala.store:8200"
  # address = "http://172.31.21.40:8200"
  token= var.vault_token
}

variable "vault_token" {}

resource "vault_mount" "ssh" {
  path = "infra"
  type = "kv"
  options = {version = "2"}
  description = "infra secrets"
}

resource "vault_generic_secret" "ssh" {
  path = "${vault_mount.ssh.path}/ssh"

  data_json = <<EOT
  {
  "username" : "ec2-user",
  "paasword" : "DevOps321"
  }
  EOT
}

resource "vault_generic_secret" "elasticsearch" {
  path = "${vault_mount.ssh.path}/elasticsearch"

  data_json = <<EOT
  {
  "username" : "elastic",
  "password" : "SCBuNFkr5Gz-TvaR_p53"
  }
  EOT
}

resource "vault_generic_secret" "github-runner" {
  path = "${vault_mount.ssh.path}/github-runner"
  data_json = <<EOT
  {
  "RUNNER_TOKEN": "xx"
  }
  EOT
}



resource "vault_mount" "roboshop-dev" {
  path = "roboshop-dev"
  type = "kv"
  options = {version= "2"}
  description = "Robo shop dev secrets"
}

resource "vault_generic_secret" "roboshop-dev-cart" {
  path = "${vault_mount.roboshop-dev.path}/cart"
  data_json = <<EOT
  {
  "REDIS_HOST": "redis-dev.kommanuthala.store",
  "CATALOGUE_HOST": "catalogue-dev.kommanuthala.store",
  "CATALOGUE_PORT": "8080"
  }
  EOT
}

resource "vault_generic_secret" "roboshop-dev-catalogue" {
  path = "${vault_mount.roboshop-dev.path}/catalogue"
  data_json = <<EOT
  {
  "MONGO" : "true",
  "MONGO_URL" : "mongodb://mongodb-dev.kommanuthala.store:27017/catalogue"
  }
  EOT
}

resource "vault_generic_secret" "roboshop-dev-frontend" {
  path = "${vault_mount.roboshop-dev.path}/frontend"
  data_json = <<EOT
  {
  "catalogue" : "http://catalogue-dev.kommanuthala.store:8080/",
  "user"      : "http://user-dev.kommanuthala.store:8080/",
  "cart"      :  "http://cart-dev.kommanuthala.store:8080/",
  "shipping"  :  "http://shipping-dev.kommanuthala.store:8080/",
  "payment"   :  "http://payment-dev.kommanuthala.store:8080/"
  }
  EOT
}

resource "vault_generic_secret" "roboshop-dev-payment" {
  path = "${vault_mount.roboshop-dev.path}/payment"
  data_json = <<EOT
  {
  "CART_HOST" : "cart-dev.kommanuthala.store",
  "CART_PORT" : "8080",
  "USER_HOST" : "user-dev.kommanuthala.store",
  "USER_PORT" : "8080",
  "AMQP_HOST" : "rabbitmq-dev.kommanuthala.store",
  "AMQP_USER" : "roboshop",
  "AMQP_PASS" : "roboshop123"
  }
  EOT
}

resource "vault_generic_secret" "roboshop-dev-shipping" {
  path = "${vault_mount.roboshop-dev.path}/shipping"
  data_json = <<EOT
  {
  "CART_ENDPOINT": "cart-dev.kommanuthala.store:8080",
  "DB_HOST" : "mysql-dev.kommanuthala.store"
  }
  EOT
}

resource "vault_generic_secret" "roboshop-dev-user" {
  path = "${vault_mount.roboshop-dev.path}/user"
  data_json = <<EOT
  {
  "MONGO":"true",
  "REDIS_URL": "redis://redis-dev.kommanuthala.store:6379",
  "MONGO_URL": "mongodb://mongodb-dev.kommanuthala.store:27017/users"
  }
  EOT
}
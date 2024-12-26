data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "redis-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]

  public_subnets = [["10.10.0.0/24"]]

  create_vpc         = true
}

module "redis" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-redis.git?ref=main"

  name               = "redis"
  folder_id          = data.yandex_client_config.client.folder_id
  network_id         = module.network.vpc_id
  password           = "secretpassword"
  maxmemory_policy   = "ALLKEYS_LRU"
  resource_preset_id = "hm3-c8-m128"
  disk_size          = 256
  assign_public_ip   = true
  tls_enabled        = true

  hosts = {
    host1 = {
      zone      = "ru-central1-a"
      subnet_id = module.network.public_subnets_ids[0]
    }
  }

}

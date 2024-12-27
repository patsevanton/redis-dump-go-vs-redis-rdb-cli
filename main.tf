data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "redis-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]
  private_subnets = [["10.10.0.0/24"]]
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
      subnet_id = module.network.private_subnets_ids[0]
    }
  }

}

module "yandex_compute_instance" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-instance.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  name         = "my-instance"
  description  = "Test instance"
  image_family = "ubuntu-2204-lts"

  zone                      = "ru-central1-a"
  subnet_id                 = module.network.private_subnets_ids[0]
  enable_nat                = true
  create_pip                = true

  cores         = 4
  memory        = 8

  hostname                  = "my-instance"
  allow_stopping_for_update = true
  generate_ssh_key          = false
  ssh_user                  = "ubuntu"
  ssh_pubkey                = "~/.ssh/id_rsa.pub"

  boot_disk = {
    auto_delete = true
    device_name = "boot-disk"
    mode        = "READ_WRITE"
  }

  boot_disk_initialize_params = {
    size       = 65
    block_size = 4096
    type       = "network-ssd"
  }
}

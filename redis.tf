module "redis" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-redis.git?ref=v1.0.0"

  name       = "sentry"
  folder_id  = local.folder_id
  network_id = yandex_vpc_network.sentry.id
  redis_version = 7.2

  password         = "secretpassword"
  maxmemory_policy = "ALLKEYS_LRU"

  hosts = {
    host1 = {
      zone      = yandex_vpc_subnet.sentry-a.zone
      subnet_id = yandex_vpc_subnet.sentry-a.id
    },
    host2 = {
      zone      = yandex_vpc_subnet.sentry-b.zone
      subnet_id = yandex_vpc_subnet.sentry-b.id
    },
    host3 = {
      zone      = yandex_vpc_subnet.sentry-d.zone
      subnet_id = yandex_vpc_subnet.sentry-d.id
    }

  }
}

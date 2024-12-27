output "fqdn_redis" {
  description = "The fully qualified domain name of the cluster"
  value       = module.redis.fqdn
}

output "instance_public_ip" {
  value = module.yandex_compute_instance.instance_public_ip
}

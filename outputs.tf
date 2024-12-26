output "fqdn" {
  description = "The fully qualified domain name of the cluster"
  value       = module.redis.fqdn
}

output "id" {
  description = "ID of the Redis cluster"
  value       = module.redis.id
}

output "name" {
  description = "Name of the Redis cluster"
  value       = module.redis.name
}

output "environment" {
  description = "Deployment environment of the Redis cluster"
  value       = module.redis.environment
}

output "network_id" {
  description = "ID of the network to which the Redis cluster belongs"
  value       = module.redis.network_id
}

output "description" {
  description = "Description of the Redis cluster"
  value       = module.redis.description
}

output "folder_id" {
  description = "ID of the folder that the resource belongs to"
  value       = module.redis.folder_id
}

output "labels" {
  description = "A set of key/value label pairs to assign to the Redis cluster"
  value       = module.redis.labels
}

output "sharded" {
  description = "Redis Cluster mode enabled/disabled"
  value       = module.redis.sharded
}

output "tls_enabled" {
  description = "TLS support mode enabled/disabled"
  value       = module.redis.tls_enabled
}

output "persistence_mode" {
  description = "Persistence mode of the Redis cluster"
  value       = module.redis.persistence_mode
}

output "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  value       = module.redis.security_group_ids
}

output "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  value       = module.redis.deletion_protection
}

output "config" {
  description = "Configuration of the Redis cluster"
  value       = module.redis.config
  sensitive   = true
}

output "resources" {
  description = "Resources allocated to hosts of the Redis cluster"
  value       = module.redis.resources
}

output "hosts" {
  description = "A list of hosts in the Redis cluster"
  value       = module.redis.hosts
}

output "maintenance_window" {
  description = "Maintenance policy of the Redis cluster"
  value       = module.redis.maintenance_window
}

output "health" {
  description = "Aggregated health of the cluster"
  value       = module.redis.health
}

output "created_at" {
  description = "Creation timestamp of the cluster"
  value       = module.redis.created_at
}

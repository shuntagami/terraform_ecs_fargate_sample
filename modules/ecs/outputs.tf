output "repository_url" {
  value = aws_ecr_repository.rails_postgres_app.repository_url
}

output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "service_name" {
  value = aws_ecs_service.web.name
}

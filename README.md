# rdocumentation-elasticsearch

Host configuration and ingestion pipelines for [rdocumentation.org](http://www.rdocumentation.org).

## Legacy ECS ingestion

The production ingestion service is still the rdoc-logstash ECS service in
the datacamp-services cluster. This repository builds its image from
logstash/Dockerfile; the legacy CircleCI workflow builds to staging ECR,
deploys staging, copies the image to the production ECR account, and deploys
production. The deploy jobs are intentionally restricted to master.

The ECS service resource is declared in
datacamp-engineering/RDocumentation-elasticsearch-infra. This repository
owns the image and the ecs.json release payload consumed by the ECS deploy
system, so the service Terraform does not need to change for this image
recovery.

The rdoc-logstash, rdoc-logstash-versions, and rdoc-logstash-topics
infrastructure repositories describe the later EKS migration. They are not
the production deployment path for this service.

Each ECS container reads its database credentials from the environment
populated by aws-env. The JDBC URLs use Connector/J 5.1.49 with TLS 1.2,
certificate verification, and an image-local truststore generated from the
AWS RDS us-west-1 CA bundle. No database credentials are stored in this
repository.

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).

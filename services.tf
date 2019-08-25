module "service_whois" {
    source          = "./modules/service"
    vpc_id          = "${module.vpc.vpc_id}"
    region          = "${var.aws_region}"

    is_public       = true

    # Service name
    service_name        = "service-whois"
    service_base_path   = "/whois*"
    service_priority    = 400

    container_port  = 8080

    # Cluster to deploy your service - see in clusters.tf
    cluster_name    = "${var.cluster_name}"
    cluster_id          = "${module.cluster_example.cluster_id}"
    cluster_listener    = "${module.cluster_example.listener}"

    # Auto Scale Limits
    desired_tasks   = 2
    min_tasks       = 2
    max_tasks       = 10

    # Tasks CPU / Memory limits
    desired_task_cpu        = 256
    desired_task_mem        = 512

    # CPU metrics for Auto Scale
    cpu_to_scale_up         = 80
    cpu_to_scale_down       = 20
    cpu_verification_period = 60

    # Pipeline Configuration
    build_image         = "aws/codebuild/docker:17.09.0"

    git_repository_owner    = "msfidelis"
    git_repository_name     = "microservice-nadave-whois"
    git_repository_branch   = "master"

    # AZ's
    availability_zones  = [
        "${module.vpc.public_subnet_1a}",
        "${module.vpc.public_subnet_1b}"
    ]
}
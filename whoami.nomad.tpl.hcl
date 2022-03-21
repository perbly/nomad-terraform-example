job "whoami" {
  datacenters = ["dc1"]
  type = "service"

  group "whoami" {
    count = 1
    task "whoami" {
      driver = "docker"
        env {
          ENVIRONMENT="local",
          WHOAMI_NAME="whoami"
      }
      config {
        port_map = {
          http = 80
        }
        labels {
          service = "whoami"
          environment = "local"
          owner = "tooling"
        }
        image = "containous/whoami"
        network_mode = "dev_default"
      }
      resources {
        cpu    = 100
        memory = 128
        network {
          port "http" {}
          mbits = 50
        }
      }
      service {
        name = "whoami"
        tags = [
          "ingress"
        ]
        port = "http"
      }
    }
    update {
      max_parallel = 1
      health_check = "manual"
      stagger = "30s"
      healthy_deadline = "2m"
      min_healthy_time = "60s"
    }
  }
}

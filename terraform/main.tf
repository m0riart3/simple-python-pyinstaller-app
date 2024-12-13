terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Red Docker
resource "docker_network" "jenkins_network" {
  name = "jenkins"
}

resource "docker_volume" "jenkins_data"{
  name = "jenkins_data"
}

resource "docker_volume" "jenkins_docker_certs"{
  name = "jenkins_docker_certs"
}



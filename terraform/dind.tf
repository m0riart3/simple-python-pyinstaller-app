# Contenedor Docker-in-Docker (DinD)
resource "docker_container" "jenkins_docker" {
  name       = "jenkins-docker"
  image      = "docker:dind"
  privileged = true

  # Variables de entorno
  env = [
    "DOCKER_TLS_CERTDIR=/certs"
  ]

  # Volúmenes compartidos
  volumes {
    volume_name    = docker_volume.jenkins_docker_certs.name
    container_path = "/certs/client"
  }
  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }

networks_advanced {
    name    = docker_network.jenkins_network.name
    aliases = ["docker"]
  }


  # Puertos
  ports {
    internal = 2376
    external = 2376
  }
}

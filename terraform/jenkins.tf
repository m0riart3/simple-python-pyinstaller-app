# Recurso para construir la imagen personalizada de Jenkins
resource "null_resource" "build_jenkins_image" {
  provisioner "local-exec" {
    command = "sudo docker build -t jenkins3:2.479.2-jdk17 ."
  }
}

# Contenedor Jenkins
resource "docker_container" "jenkins_blueocean" {
  image = "jenkins3:2.479.2-jdk17" 
  name  = "jenkins-blueocean"
  

  # Usuario de ejecución
  user = "root"

  # Variables de entorno
  env = [
    "DOCKER_HOST=tcp://docker:2376",
    "DOCKER_CERT_PATH=/certs/client",
    "DOCKER_TLS_VERIFY=1",
  ]

  # Volúmenes
  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }
  volumes {
    volume_name    = docker_volume.jenkins_docker_certs.name
    container_path = "/certs/client"
  }

  # Red Docker
  network_mode = docker_network.jenkins_network.name

  # Puertos
  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 50000
    external = 50000
  }
}

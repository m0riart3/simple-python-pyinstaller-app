# Práctica 3

Este documento explica la configuración y despliegue de los recursos necesarios para levantar un docker in docker y un jenkins, así como ejecutar un jenkinsfile con una pipeline desde un repositorio de github.

## Ejecución del terraform

Lo primero será ejecutar los comandos de terraform, para ello usaremos los archivos con extensión ```.tf```. No hace falta construir la imagen de jenkins debido a que se hará con el terraform apply, es una de las soluciones que he encontrado para poder automatizar todo de una manera más eficiente.

```terraform init```

Este comando **inicializa** el entorno de trabajo de Terraform. Descarga los proveedores necesarios y configura el directorio para poder trabajar con Terraform.

```terraform plan```

Este comando te permite **ver qué cambios realizará Terraform** en tu infraestructura antes de aplicarlos. Muestra un plan detallado de las acciones que se tomarán.

```terraform apply```

Este comando aplica los cambios definidos en tu configuración de Terraform y **crea o actualiza los recursos** (en este caso, contenedores Docker y redes).

Dentro del archivo jenkins.tf tal y como se ha mostrado en el video, se encuentra un recurso nulo que construye la imagen del docker de jenkins usando el comando ```docker build -t jenkins3:2.479.2-jdk17 .```. Se puede hacer manualmente si uno considera, aunque se va a ejecutar automáticamente, es por eso que no se especifica en el documento.

## Configuración del jenkins

Una vez levantado los dockers, comprobamos que todos se encuentran levantados usando el comando ```docker ps```. Para confirmar que tenemos los dos dockers levantados.

Lo siguiente que haremos será o bien ```docker logs 'nombre del docker' ``` o bien ```docker exec -it 'nombre del docker' /bin/bash``` y posteriormente ```cat /var/jenkins_home/secrets/initialAdminPassword``` . Tal y como se muestra en el video, si miramos los logs del docker, veremos la contraseña necesaria para poder acceder a jenkins, o bien podemos ver el archivo donde se almacena.

Lo siguiente será configurar jenkins, añadimos el usuario en el registro que se nos muestra y le decimos que instale los plugins necesarios. 

Dado que esto se muestra en las diapositivas, no voy a poner capturas ni dedicarle más tiempo a ello.

### Ejecución del Jenkinsfile

Por último nos mostrará la opcion de ```new item```. 

Una vez se ha entrado en ese apartado, se indicará que es de tipo pipeline, y se le pondrá un nombre.

Cuando se abra la venta de configuración se añade una descripción y se baja a la parte donde se debería añadir el código del Jenkinsfile, en la pestaña de ```Definition```. Se cambia a ```Pipeline script from SCM```. Y en repository URL se pone la url del repositorio, en mi caso, ```https://github.com/m0riart3/simple-python-pyinstaller-app```. Se selecciona la opción ```Git``` en ```SCM```. En el apartado de ```branch specifier```. En mi caso se deja ```/master```. Y por último en ```Script Path```. Se deja ```Jenkinsfile```. 

Se le da a la opción de guardar y automáticamente se vuelve a la pantalla anterior, se le da al boton de ```Build now``` y se espera a que se termine de ejecutar todo.

En el video se muestra los logs de dicho proceso, pero en caso de querer ejecutar el binario resultante, simplemente en la pantalla de ```Status```. Pinchamos en el nombre del archivo y se nos descargará.

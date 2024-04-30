# Proyecto de Gestión de Tareas

## Aplicación Web

Este proyecto es una aplicación web de gestión de tareas desarrollada como parte de un reto de desarrollo para el cargo de "Técnico de Desarrollo", La aplicación permite a los usuarios registrarse, iniciar sesión, crear, editar y eliminar tareas, asignar tareas a otros usuarios, establecer fechas límite y prioridades para las tareas, y ver un resumen de las tareas pendientes y completadas.

**Contenido**

* Objetivo
* Tecnologías
* Instalación
* Configuración
* Uso de la Aplicación
  

**Objetivo**

Desarrollar una aplicación web utilizando Java como lenguaje de programación, PostgreSQL como base de datos y Payara como servidor de aplicaciones web.

**Tecnologías**

Las tecnologias utilizadas son: 
* Java
* PostgreSQL 16
* HTML
* CSS
* Bootstrap 5
* Jakarta 10 Framework (Opcional)
* Payara Server 6.2024.4
* Maven


**Instalación**

La siguiente guía está considerada de manera ordenada.
	 
* 1.- Descargar e instalar jdk-17.0.10 ya que servirá para desplegar la aplicación en Payara Server.
  Enlace: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
* 2.- Descargar e instalar Apache NetBeans IDE 21 - Será el entorno de Desarrollo el cual se realizará las respectivas configuraciones.
  Enlace: https://netbeans.apache.org/front/main/download/
* 3.- Descargar y Descomprimir el archivo .rar de Payara Server 6.2024.4, tener lista la carpeta ya que la utilzaremos en las configuraciones.
  Enlace: https://www.payara.fish/downloads/payara-platform-community-edition/
* 4.- Descargar e instalar PostgreSQL, será la base de datos el cual nos vamos a conectar.
  Enlace: https://www.postgresql.org/download/
* 5.- Descargar los archivos del repositorio actual "AplicacionWeb y DataBase"

**Configuración**

Luego de haber hecho las respectivas instalaciones vamos a proceder con la configuración.

NETBEANS
* 1.- Abrir Apache NetBeans IDE 21
* 2.- Ir al apartado de servicios y agregar un nuevo servidor, seleccionar payara server, ahora necesitaremos especificar la ruta de la carpeta de payara que se habia mencionado anteriormente
* 3.- Dejar por defecto la instalación del dominio
* 4.- Comprobar que payara ejecute con normalidad

PostgreSQL
* 1.- Al iniciar por primera vez se debe specificar la contraseña "1234" y el usuario "postgres" y posteriormente crear una base de datos llamada App
* 2.- Crear las tablas en un Query el cual estará en el archivo DataBase
* 3.- Tener abierto PostgreSQL

APLICACION WEB
* 1.- En NetBeans, abrir el proyecto Aplicación Web
* 2.- Ejecutar la aplicación (IMPORTANTE: tener conexión a internet la primera vez debido a que se descargarán todas las dependencias necesarias para que todo funcione correctamente, en especial la dependencia de postgresql)
* 3.- Si se siguió los pasos anteriores correctamente, la aplicación debió ejecutarse sin ningun problema utilizando como Server Payara, para comprobar que esté funcionando puede dirigirse a la url:  http://localhost:8080/AplicacionWeb 


**Uso de la Aplicación**

* 1.- Los usuarios podrán podrán registrarse y automáticamente se guardarán los registros en la base de datos, tambíen habrá un login para aquellos que ya se hayan registrado.
* 2.- Una vez Logueado podrá crear, visualizar, editar y asignar tareas a otros usuarios.
* 3.- DIFRUTAR DE LA APLICACIÓN!!

**Visualización de la Aplicación**
![image](https://github.com/DilanBedoya/Gesti-n_de_Tareas/assets/133397877/e536ba37-d732-4145-a5b6-e42b5a5eafda)
![image](https://github.com/DilanBedoya/Gesti-n_de_Tareas/assets/133397877/b955cbaf-6370-4667-b6c7-2e42c3f33b4e)
![image](https://github.com/DilanBedoya/Gesti-n_de_Tareas/assets/133397877/cc4fe88f-3b24-4998-a32e-df6bdc364a27)





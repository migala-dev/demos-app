# demos_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Convencion para nombrar archivos
*file-name*.*file-identifier*.dart

## Estructura de archivos
### General
/lib
&nbsp;&nbsp; /core
&nbsp;&nbsp;&nbsp; /api
&nbsp;&nbsp;&nbsp;&nbsp; user.api.dart
&nbsp;&nbsp; /modules
&nbsp;&nbsp;&nbsp;&nbsp;/*module-name* (spaces)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/models
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*entity-name*_view.model.dart
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*entity-name*_reponse.model.dart
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/widgets
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/services
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/pages
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*page-name* (spaces)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*page-name*.service.dart
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*page-name*.page.dart (spaces.page.dart)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/widgets
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/models
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/services
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/screens
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*screen-name* (empty_spaces)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/models
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/widgets
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/services
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*screen-name*.screen.dart (empty_spaces.screen.dart)

### Core

#### Api (NEW)
Esta capa conecta el servidor y los servicios (Aqui se mapea la respuesta)
#### Models
Modelos de la aplicacion en general

#### Services
Servicios de la aplicacion en general

#### Enums
Enumerables del proyecto en general

#### Repositories
Los repositorios son archivos que contienen las conexiones a tablas de la base de datos local

Tecnologias:
SQLite Flutter
#### Bloc (New)

#### Listeners
Archivos que manejan las respuestas del cache

---

### Modules
Un modulo es una unidad contenedora de mas pantallas o paginas
Todas las carpetas dentro de la seccion de module empiezan con el nombre del modulo correspondiente.

#### *module-name*

Subcarpetas:
* widgets
* models
* services
* pages
Se describe en la siguiente seccion

 ##### Pages
Archivos base:
*page-name*.page.dart (spaces.page.dart)

Subcarpetas:
* widgets
* models
* services
* screens
Se describe en la siguiente seccion

##### Screens
*screen-name*.page.dart (empty_spaces.page.dart)
Subcarpetas:
* widgets
* models
* services
---

### Tipos de modelos
* *entity-name*_view.model.ts
Son entidades que solo se usan en los widgets
* *entity-name*_reponse.model.ts
Respuestas de backend
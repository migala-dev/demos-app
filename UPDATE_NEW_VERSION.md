 # Documentacion para subir la version


## Actualizar la icono de la applicacion
 Utilizar herramienta  [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

### Paso 1:
    Actualizar imagen que se espesifica en el pubspec.yaml 
    flutter_icons: image_path

### Paso 2:
    Correr el comando `flutter pub run flutter_launcher_icons:main`

# ANDROID

## Subir version en la pruebas

### Paso 1:
- Subir el numero de la version version
⋅⋅* `android/app/build.gradle`
Actualizar `flutterVersionCode` y `flutterVersionName`

⋅⋅* `pubspec.yaml`
Actualizar solo `version`

### Paso 2:
Correr el comando `flutter build appbundle`

### Paso 3:
Ir a la carpeta `build/app/outputs/bundle/release`
Y copiar el archivo `app-release.aab`

### Paso 4:
Abrir la [consola](https://play.google.com/console/) 
Crear una nueva version y subir este archivo.

# IOS 

### Paso 1:
- Subir el numero de la version version
⋅⋅*  Entrar a XCode a Runner/General
Actualizar `Version` y `Build`

* Nota: Si se actualiza solo el build no se corre todas las pruebas *

⋅⋅* `pubspec.yaml`
Actualizar solo `version`

### Paso 2:
Dentro de XCode NatBar Product/Archive
* Nota: Tiene que estar el IPhone conectado o 'Any IOS Device (arm64)' seleccionado *
### Paso 3:
- Esperar build y por ultimo Dirstribuir

### Paso 4:
Abrir [dashboard](https://appstoreconnect.apple.com/login)

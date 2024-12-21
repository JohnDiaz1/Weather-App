# Weather_App

App hecha en Flutter que consume el api del website https://openweathermap.org,

## Requisitos previos

- Flutter SDK v3.24.5
- Dart SDK
- Un editor de código (VS Code, Android Studio, etc.)
- Git
- Cuenta en el website: https://openweathermap.org/ para obtener el API_KEY

## Configuración del entorno

1. Clona el repositorio:
```bash
git clone [URL_DEL_REPOSITORIO]
cd [NOMBRE_DEL_PROYECTO]
```

2. Configura los archivos de entorno:

   El proyecto cuenta con dos archivos `.env` para su funcionamiento:
    - Uno en la raíz del proyecto (`/`)
    - Otro en la carpeta de pruebas (`/test`)


   Reemplaza los valores de las API keys en ambos archivos con tus propias credenciales:

   ```plaintext
   # Contenido ejemplo de .env
   API_KEY=tu_api_key_aqui
   API_URL=tu_url_aqui
   # ... otras variables de entorno
   ```

3. Instala las dependencias:
```bash
flutter pub get
```

## Ejecutar la aplicación

### Modo desarrollo

```bash
flutter run
```

### Modo release

```bash
flutter run --release
```

## Ejecutar pruebas

```bash
flutter test
```

## Solución de problemas comunes

1. Error de variables de entorno no encontradas:
    - Verifica que hayas remmplazado las varibles en los archivos `.env` en las ubicaciones correctas
    - Asegúrate de que los nombres de las variables coincidan con los esperados por la aplicación

2. Error de versión de Flutter:
   ```bash
   flutter --version
   ```
    - Si no tienes la versión correcta, puedes cambiarla usando:
   ```bash
   flutter version 3.24.5
   ```


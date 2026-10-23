# Datos Abiertos de Colombia

## Descripción
Aplicación móvil desarrollada con Flutter que consulta información de Colombia mediante la API Colombia. Permite explorar departamentos, regiones, presidentes y atractivos turísticos.

## Funcionalidades
- Consulta y visualización de departamentos.
- Detalle de cada departamento.
- Consulta de regiones de Colombia.
- Listado de presidentes.
- Listado de atractivos turísticos.
- Navegación entre las secciones y regreso al menú principal.
- Manejo de estados de carga y errores en las consultas implementadas.

## Tecnologías utilizadas
- Flutter
- Dart
- API Colombia
- HTTP para las solicitudes a la API
- GoRouter para la navegación
- Flutter Dotenv para la configuración de la URL base

## Requisitos
- Flutter instalado.
- Dart instalado.
- Android Studio o Visual Studio Code.
- Un emulador Android o un dispositivo compatible.
- Conexión a Internet para consultar la API.

## Instalación y ejecución
1. Clonar el repositorio.
2. Abrir la carpeta del proyecto.
3. Instalar las dependencias:

   ```bash
   flutter pub get
   ```

4. Verificar que el archivo `.env` contenga la URL base de la API:

   ```text
   API_BASE_URL=https://api-colombia.com/api/v1
   ```

5. Ejecutar la aplicación:

   ```bash
   flutter run
   ```

## Pruebas y análisis
Para ejecutar las pruebas automáticas:

```bash
flutter test
```

Para analizar el código:

```bash
flutter analyze
```

## Autor
Proyecto académico desarrollado como parte del taller de Flutter sobre consulta de datos abiertos de Colombia.


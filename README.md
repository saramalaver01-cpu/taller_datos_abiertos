# Datos Abiertos de Colombia 🇨🇴

Aplicación móvil desarrollada con **Flutter y Dart** que consume información de la API pública de Colombia. Permite consultar departamentos, regiones, presidentes y atractivos turísticos mediante una interfaz organizada y una navegación entre pantallas.

## 1. Objetivo del proyecto

Desarrollar una aplicación que consuma al menos cuatro endpoints de la API de Colombia, presente los resultados en listados y permita navegar entre las diferentes pantallas utilizando `go_router`.

El proyecto aplica solicitudes HTTP, programación asíncrona, modelos de datos, separación de responsabilidades y manejo de estados de carga, éxito y error.

## 2. API utilizada

- **Nombre:** API Colombia.
- **URL base:** https://api-colombia.com/api/v1
- **Documentación y recursos:** [API Colombia](https://api-colombia.com/)

La aplicación utiliza solicitudes HTTP GET para consultar información pública del país.

### Endpoints implementados

| Recurso | Endpoint | Funcionalidad |
|---|---|---|
| Departamentos | `/Department` | Consulta y muestra los departamentos de Colombia. |
| Regiones | `/Region` | Consulta y muestra las regiones del país. |
| Presidentes | `/President` | Consulta y muestra información de los presidentes de Colombia. |
| Atractivos turísticos | `/TouristicAttraction` | Consulta y muestra atractivos turísticos. |

Las direcciones completas se construyen utilizando la URL base y la ruta correspondiente.

## 3. Tecnologías y paquetes

| Tecnología o paquete | Uso |
|---|---|
| Flutter | Desarrollo de la interfaz de usuario. |
| Dart | Lenguaje de programación. |
| `http` | Realización de solicitudes HTTP a la API. |
| `go_router` | Navegación y definición de rutas entre pantallas. |
| `flutter_dotenv` | Lectura de variables de configuración desde el archivo `.env`. |
| `FutureBuilder` | Representación de estados asociados a operaciones asíncronas. |
| `ListView.builder` | Construcción eficiente de los listados de resultados. |

## 4. Arquitectura y organización del proyecto

El proyecto separa la interfaz, los modelos de datos y las operaciones de consulta a la API para facilitar la lectura y el mantenimiento del código.

```text
taller_datos_abiertos/
├── assets/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── department.dart
│   ├── services/
│   │   └── api_service.dart
│   └── views/
│       ├── home_page.dart
│       ├── departments_page.dart
│       ├── department_detail_page.dart
│       ├── regions_page.dart
│       ├── presidents_page.dart
│       └── tourism_page.dart
├── test/
├── .env
├── .gitignore
├── pubspec.yaml
└── README.md
```

**Responsabilidades principales:**

- **`main.dart`:** inicializa la aplicación, carga la configuración y define las rutas de navegación.
- **`models/department.dart`:** representa los datos de un departamento mediante un modelo de Dart.
- **`services/api_service.dart`:** centraliza las solicitudes a la API y la obtención de información.
- **`views/`:** contiene las pantallas del Dashboard, los listados y el detalle de los departamentos.
- **`.env`:** contiene la configuración de la URL base de la API.
- **`.gitignore`:** evita incluir archivos de configuración privados en el repositorio.

## 5. Funcionamiento de la aplicación

### 5.1 Dashboard

La pantalla principal permite acceder a las funcionalidades de consulta de departamentos, regiones, presidentes y atractivos turísticos.

**Captura del Dashboard:**

![Dashboard de Datos Abiertos de Colombia](screenshots/dashboard.png)

### 5.2 Listados de información

Cada sección realiza una consulta a la API y presenta los resultados mediante componentes de Flutter. En el listado de departamentos se muestra información como el nombre, la capital y el número de municipios.

**Captura del listado de departamentos:**

![Listado de departamentos](screenshots/departamentos.png)

**Captura de otro listado, como regiones, presidentes o turismo:**

![Listado de información de la API](screenshots/listados.png)

### 5.3 Detalle de un departamento

Al seleccionar un departamento, la aplicación abre una pantalla de detalle que presenta información del elemento seleccionado, como su nombre, capital y otros datos disponibles en el modelo.

La navegación se realiza con `go_router`, pasando el ID en la ruta y el objeto del departamento mediante `extra`.

**Captura del detalle de un departamento:**

![Detalle de un departamento](screenshots/detalle_departamento.png)

### 5.4 Manejo de estados

La aplicación contempla diferentes estados durante las consultas a la API:

- **Carga:** muestra un indicador de progreso y un mensaje mientras se espera la respuesta.
- **Éxito:** presenta los datos obtenidos cuando la consulta finaliza correctamente.
- **Error:** muestra un mensaje cuando la solicitud falla y ofrece la posibilidad de intentar nuevamente en las pantallas que implementan esta opción.
- **Sin resultados:** informa cuando no hay elementos disponibles para mostrar.

**Captura del estado de carga:**

![Estado de carga](screenshots/estado_carga.png)

**Captura del estado de error:**

![Estado de error](screenshots/estado_error.png)

> Las imágenes anteriores son referencias a archivos que deben agregarse a la carpeta `screenshots/`. Para que se visualicen en GitHub, guarda allí las capturas reales con los nombres indicados.

## 6. Navegación con go_router

La aplicación utiliza `MaterialApp.router` y `GoRouter` para definir las rutas y controlar la navegación entre pantallas.

| Ruta | Pantalla | Descripción |
|---|---|---|
| `/` | `HomePage` | Dashboard principal. |
| `/departamentos` | `DepartmentsPage` | Listado de departamentos. |
| `/regiones` | `RegionsPage` | Listado de regiones. |
| `/presidentes` | `PresidentsPage` | Listado de presidentes. |
| `/turismo` | `TourismPage` | Listado de atractivos turísticos. |
| `/departamentos/:id` | `DepartmentDetailPage` | Detalle del departamento seleccionado. |

### Paso de parámetros al detalle

Al seleccionar un elemento de la lista de departamentos, se utiliza una navegación equivalente a:

```dart
context.push(
  '/departamentos/${department.id}',
  extra: department,
);
```

El parámetro `:id` identifica al departamento en la URL, mientras que `extra` permite enviar el objeto seleccionado a la pantalla de detalle.

## 7. Ejemplo de respuesta JSON

La API devuelve objetos JSON con los datos de cada recurso. Por ejemplo, una respuesta individual del endpoint de departamentos puede contener una estructura como la siguiente:

```json
{
  "id": 31,
  "name": "Valle del Cauca",
  "description": "Departamento de Colombia",
  "cityCapitalId": 1093,
  "municipalities": 42,
  "surface": 22140,
  "population": 4589278,
  "phonePrefix": "2",
  "countryId": 1
}
```

Este ejemplo es ilustrativo y contiene algunos de los campos del recurso. Los valores y campos exactos dependen de la respuesta de la API.

La información obtenida se procesa mediante el servicio correspondiente y se representa en la interfaz de Flutter.

## 8. Configuración y ejecución

### Requisitos previos

- Flutter instalado y configurado.
- Dart incluido con Flutter.
- Un emulador, dispositivo Android o entorno compatible.
- Conexión a Internet para consultar la API.

### Pasos para ejecutar el proyecto

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/saramalaver01-cpu/taller_datos_abiertos.git
   ```

2. Entrar en la carpeta del proyecto:

   ```bash
   cd taller_datos_abiertos
   ```

3. Instalar las dependencias:

   ```bash
   flutter pub get
   ```

4. Crear el archivo `.env` en la raíz del proyecto con la variable de configuración:

   ```env
   API_BASE_URL=https://api-colombia.com/api/v1
   ```

5. Ejecutar la aplicación:

   ```bash
   flutter run
   ```

**Importante:** el archivo `.env` está excluido del repositorio mediante `.gitignore`. Debe crearse localmente cuando sea necesario y no debe subirse a GitHub.

## 9. Repositorio y flujo de trabajo Git

Repositorio público: [taller_datos_abiertos en GitHub](https://github.com/saramalaver01-cpu/taller_datos_abiertos)

El desarrollo se organizó utilizando ramas para separar la versión estable, la integración y el trabajo de la funcionalidad.

| Rama | Propósito |
|---|---|
| `main` | Versión estable del proyecto. |
| `dev` | Integración de cambios antes de incorporarlos a la versión estable. |
| `feature/taller_api_colombia` | Desarrollo de la funcionalidad de consulta de datos de Colombia. |

El flujo de trabajo utilizado fue:

1. Desarrollar la funcionalidad en `feature/taller_api_colombia`.
2. Crear un Pull Request hacia `dev`.
3. Revisar e integrar los cambios en `dev`.
4. Integrar los cambios de `dev` en `main`.
5. Verificar que el repositorio quedara actualizado y sin cambios pendientes.

## 10. Pruebas y verificación

Durante la verificación del proyecto se ejecutaron los siguientes comandos:

```bash
flutter analyze
flutter test
```

Los resultados registrados fueron:

- `flutter analyze`: sin problemas reportados.
- `flutter test`: todas las pruebas ejecutadas finalizaron correctamente.

## 11. Conclusión

El proyecto permitió desarrollar una aplicación Flutter conectada a una API pública, consultar cuatro recursos relacionados con Colombia y presentar la información en distintas pantallas. También permitió aplicar solicitudes HTTP, modelos de datos, operaciones asíncronas, navegación con `go_router` y manejo de estados.

La organización del código y el uso de ramas y Pull Requests contribuyen a mantener un proyecto comprensible y un flujo de desarrollo ordenado.

---

**Proyecto académico:** Datos Abiertos de Colombia  
**Repositorio:** [https://github.com/saramalaver01-cpu/taller_datos_abiertos](https://github.com/saramalaver01-cpu/taller_datos_abiertos)

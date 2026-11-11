RetailPro - Proyecto de Análisis de Ventas

1. Descripción del proyecto y objetivo

Este repositorio contiene el proyecto final del curso de Data Analytics de Coderhouse enfocado en RetailPro, una distribuidora de tecnología. El objetivo principal del proyecto es estructurar, modelar y analizar los datos transaccionales de ventas de la compañía utilizando SQL Server y SQL Server Management Studio (SSMS) para la gestión de bases de datos, y Power BI (Power Query y DAX) para la visualización y generación de reportes de negocio.

2. Estructura del repositorio

La organización de los archivos y carpetas en el repositorio es la siguiente:

├── modulo-3/
│   └── ventas_tech_db.sql        # Script de creación de la base de datos Ventas_Tech_DB (DROP, CREATE, INSERT, VALIDACIÓN)
├── modulo-4/
│   └── m4_consultas_negocio.sql    # 4 consultas de negocio (resumen mensual, ranking de productos, clientes recurrentes, meses por encima/debajo del promedio)
└── modulo-5/
    └── m5_consultas_joins.sql      # Vista base con INNER JOIN, análisis de clientes/productos sin ventas (LEFT JOIN) y consolidado por período (UNION ALL)



3. Herramientas usadas

Base de datos y Consultas: SQL Server y SQL Server Management Studio (SSMS).

Modelado y Visualización: Power BI (Power Query y DAX).

Control de Versiones y Repositorio: GitHub.

4. Modelo de datos (tablas y relaciones)

La base de datos Ventas_Tech_DB está compuesta por 4 tablas principales y sus respectivas relaciones:

categorias: Contiene la información de las categorías de productos (id_categoria como Clave Primaria).

clientes: Almacena los datos de los clientes de la distribuidora (id_cliente como Clave Primaria).

productos: Catálogo de productos comercializados por RetailPro (id_producto como Clave Primaria y id_categoria como Clave Foránea vinculada a la tabla categorias).

ventas: Registro transaccional de las operaciones de venta (id_venta como Clave Primaria, con Claves Foráneas hacia clientes y productos).

5. Cómo ejecutar los scripts SQL paso a paso en SQL Server

Para levantar y configurar correctamente la base de datos y sus consultas en tu entorno local, seguí estos pasos en orden:

Requisitos previos:

Tener instalado SQL Server y SQL Server Management Studio (SSMS).

Contar con permisos para crear bases de datos en el servidor local.

Paso 1 (Módulo 3): Abrir y ejecutar el script modulo-3/ventas_tech_db.sql en SSMS. Este script incluye las secciones de eliminación (DROP), creación (CREATE), inserción de datos (INSERT) y validación de la base de datos Ventas_Tech_DB.

Paso 2 (Módulo 4): Abrir y ejecutar el script modulo-4/m4_consultas_negocio.sql conectado a la base de datos Ventas_Tech_DB para consultar los indicadores de negocio.

Paso 3 (Módulo 5): Ejecutar el script modulo-5/m5_consultas_joins.sql para generar la vista base y analizar los cruces avanzados con LEFT JOIN y UNION ALL.

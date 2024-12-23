# NBA Data Engineering
Proyecto final del Curso de Data Engineering 2024 - Cívica

<img src="https://upload.wikimedia.org/wikipedia/en/thumb/0/03/National_Basketball_Association_logo.svg/1200px-National_Basketball_Association_logo.svg.png" alt="NBA Logo" width="50"/>



## Introducción
Este proyecto de Data Engineering se centra en la gestión y análisis de datos de la NBA utilizando Snowflake y dbt (Data Build Tool). Se sigue la arquitectura **Medallion** (Bronze, Silver, Gold) para procesar, transformar y optimizar los datos, desde su ingesta hasta su presentación en Power BI.



## Arquitectura de la solución

El flujo de datos sigue estas etapas:

1. **Capa Bronze (Raw)**: Almacena los datos originales tras la ingesta. 
2. **Transformaciones con dbt**: dbt opera en dos etapas principales:  
   - Entre **Bronze y Silver**: Limpieza y preparación inicial.  
   - Entre **Silver y Gold**: Optimización y modelado avanzado.  
3. **Capa Enriched (Silver & Gold)**: Datos transformados y organizados en Snowflake. 
4. **Reporting**: Presentación de los datos en dashboards interactivos con Power BI.

![NBA_Architecture](https://github.com/user-attachments/assets/8f15e21a-7d48-48f5-be12-49abaec5928a)


## Capa Bronze 

### Fuentes

La ingesta de las tablas a la base de datos se ha realizado de forma manual a través de Snowflake. Cabe mencionar que, en algunas tablas, se ha realizado algún casteo en ciertos campos para agilizar el proceso.

La información se obtuvo de distintas fuentes de Kaggle a excepción de la tabla de conferencias, que ha sido generada manualmente. Todas las tablas se han insertado en formato csv.

Fuentes de Kaggle: 
- [NBA Games Dataset](https://www.kaggle.com/datasets/nathanlauga/nba-games)
- [Common Player Info](https://www.kaggle.com/datasets/wyattowalsh/basketball)



![tablas originales](https://github.com/carleondel/nba_data_engineering/assets/140411658/acbff175-c27e-4947-8ad3-289336520cd9)




## Capa Silver

### Bases

- **Renombrado** de columnas
- **Selección** de columnas
- **Transformaciones** ligeras

![sources + bases](https://github.com/carleondel/nba_data_engineering/assets/140411658/f47fb44c-be87-4cd6-b761-33f9fa2546b7)


## Stages

En esta etapa surgen nuevas entidades que se transforman en dimensiones clave. Aquí se realiza el grueso del procesamiento de datos, incluyendo las siguientes transformaciones:

- **Generación de claves primarias:** Utilizando la función *generate_surrogate_key* del paquete *dbt_utils* para asegurar la unicidad y consistencia de los registros.
- **Conversión y formateo de datos:** Aplicación de casteos y formateo de cadenas de caracteres para estandarizar los datos.
- **Eliminación de duplicados:** Identificación y eliminación de registros duplicados para mantener la integridad de los datos.
- **Categorización de partidos:** Clasificación de los partidos utilizando una macro propia, proporcionando una visión clara del tipo de cada partido.
- **Cálculo del PER (Player Efficiency Rating):** Creación de esta métrica avanzada mediante una macro propia, proporcionando una evaluación precisa del rendimiento de los jugadores.

![source-base-stg](https://github.com/carleondel/nba_data_engineering/assets/140411658/14b195fc-035d-4c90-b867-1c714891a045)


#### Macro para crear la métrica avanzada PER (Player Efficiency Rating)

Cálculo de la métrica avanzada que será clave en el posterior análisis de las actuaciones individuales.

![macro PER](https://github.com/carleondel/nba_data_engineering/assets/140411658/14510df0-7163-49d5-9165-c46eff8d4a5d)


#### Macro para clasificar el tipo de partido

A partir de la fecha en la que se juegan los partidos es clave extraer el tipo de partido del que se trata: 

- Pretemporada
- Temporada Regular
- Play-in
- Playoff

![macro game_type](https://github.com/carleondel/nba_data_engineering/assets/140411658/904a2deb-6e61-4b73-9fac-0de01f7d6261)


#### Modelo Incremental: Conferences

Este modelo es incremental, permitiendo actualizaciones eficientes sin necesidad de volver a procesar todos los datos desde cero. 

![conferences incremental](https://github.com/carleondel/nba_data_engineering/assets/140411658/08c7c9c0-0fc8-461c-9c9d-3fef3dc81729)



### Intermediate

En esta capa, algunos de los *stages* se combinan para formar la tabla de hechos final. Esta capa existe para obtener la tabla final de forma adecuada, integrando datos de diferentes fuentes y niveles de granularidad para una representación completa y precisa.

![intermediate](https://github.com/carleondel/nba_data_engineering/assets/140411658/f39834a4-32fd-4dbb-bfa6-b4e61d562b2a)



## Capa Gold

### Core y marts


En esta capa, el modelo toma su forma final. De las capas Stages e Intermediate surgen las dimensiones del modelo y las tablas de hechos finales. En el directorio **/core** de la capa Gold, se encuentran las dimensiones de uso común. Entre ellas, la de tiempo, generada mediante el paquete `dbt_date`.
 

![DAG sin marts](https://github.com/carleondel/nba_data_engineering/assets/140411658/2da71348-dca5-4259-8831-937e23d98f20)

#### Modelo Dimensional Final

![Modelo E-R final](https://github.com/carleondel/nba_data_engineering/assets/140411658/1df68c84-f570-4612-8275-e3976ba9b0c6)

## Documentación y Tests

### Tests

En cuanto a la parte de *testing*, he aplicado tests genéricos para comprobar que las claves primarias cumplen ciertos requisitos mínimos y que se cumple la integridad relacional entre las tablas de hechos y las dimensiones. No he requerido ningún test unitario. 

![Docu   tests](https://github.com/carleondel/nba_data_engineering/assets/140411658/e60f095f-0438-4d1d-a6ad-2050c9fbe14b)

### Documentación

Para documentar el proyecto, he añadido descripciones a cada uno de los campos de las tablas del modelo en los archivos de configuración (ficheros .yml).

## Casos de Uso

### Top 10 Actuaciones Individuales en Temporada Regular de la Década

Uno de los marts creados presenta las diez mejores actuaciones individuales de jugadores en la temporada regular a lo largo de la última década (2009-2019). Este mart proporciona insights sobre los jugadores más destacados y sus rendimientos en partidos específicos.

![top 10 regular season](https://github.com/carleondel/nba_data_engineering/assets/140411658/162bd2c5-f84c-4284-88f6-98266a9bb7a1)


### Ranking de Mejores Equipos en Playoffs de la Década

Otro mart analiza el rendimiento de los equipos en los playoffs a lo largo de la última década, ofreciendo un ranking de los equipos más exitosos. Este análisis es crucial para entender las dinámicas de los equipos durante la fase más competitiva de la NBA.

![playoff teams](https://github.com/carleondel/nba_data_engineering/assets/140411658/a176f4d0-1c86-4226-9e60-eb8c472c4d84)



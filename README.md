# NBA Data Engineering
Proyecto final del Curso de Data Egineering 2024 - Cívica

# Capa Bronze 

## Fuentes

La ingesta de las tablas a la base de datos se ha realizado de forma manual a través de Snowflake. Cabe mencionar que, en algunas tablas, se ha realizado algún casteo en ciertos campos para agilizar el proceso.

La información se obtuvo de distintas fuentes de Kaggle a excepción de la tabla de conferencias, que ha sido generada manualmente. Todas las tablas se han insertado en formato csv.

Fuentes de Kaggle: 
https://www.kaggle.com/datasets/nathanlauga/nba-games

common_player_info https://www.kaggle.com/datasets/wyattowalsh/basketball


![tablas originales](https://github.com/carleondel/nba_data_engineering/assets/140411658/acbff175-c27e-4947-8ad3-289336520cd9)




# Capa Silver

## Bases

- Renombrado de columnas
- Descarte de columnas
- Transformaciones puntuales concretas

![sources + bases](https://github.com/carleondel/nba_data_engineering/assets/140411658/f47fb44c-be87-4cd6-b761-33f9fa2546b7)



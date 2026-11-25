# Matriz de confusión: clasificador Naive Bayes sobre Iris (punto 7)

**Autor:** FCO. EMMANUEL DORANTES CAÑA

## Método

1. Se eligieron 20 observaciones de Iris al azar (semilla 2026, sin repetir, numeradas del 1 al 150 según la columna A de la hoja `disc_a1`).
2. Para cada una se tomaron sus 4 atributos discretizados (chico / mediano / grande) y se buscó en la tabla del clasificador NB (hoja `disc_a1`, celdas T161:AC413) la probabilidad de cada clase.
3. Se predijo la clase con mayor valor y se comparó con la clase real.

## Resultados de las 20 observaciones

| # Flor | sepall | sepalw | petall | petalw | Predicho | Real | ¿Acierto? |
|:------:|:------:|:------:|:------:|:------:|:--------:|:----:|:---------:|
| 1   | chico   | chico   | chico   | chico   | setosa     | setosa     | Sí |
| 3   | chico   | grande  | chico   | chico   | setosa     | setosa     | Sí |
| 21  | chico   | grande  | chico   | chico   | setosa     | setosa     | Sí |
| 26  | chico   | grande  | chico   | chico   | setosa     | setosa     | Sí |
| 27  | chico   | grande  | chico   | chico   | setosa     | setosa     | Sí |
| 29  | chico   | grande  | chico   | chico   | setosa     | setosa     | Sí |
| 31  | chico   | mediano | chico   | chico   | setosa     | setosa     | Sí |
| 58  | grande  | chico   | grande  | grande  | virginica  | virginica  | Sí |
| 62  | grande  | chico   | grande  | grande  | virginica  | virginica  | Sí |
| 74  | grande  | mediano | grande  | grande  | virginica  | virginica  | Sí |
| 82  | grande  | mediano | grande  | grande  | virginica  | virginica  | Sí |
| 108 | mediano | grande  | chico   | chico   | setosa     | setosa     | Sí |
| 113 | mediano | chico   | grande  | grande  | virginica  | virginica  | Sí |
| 116 | mediano | grande  | grande  | grande  | virginica  | virginica  | Sí |
| 126 | mediano | chico   | mediano | mediano | versicolor | versicolor | Sí |
| 129 | mediano | chico   | mediano | mediano | versicolor | versicolor | Sí |
| 132 | mediano | chico   | mediano | mediano | versicolor | versicolor | Sí |
| 141 | mediano | chico   | mediano | mediano | versicolor | versicolor | Sí |
| 143 | mediano | chico   | mediano | mediano | versicolor | versicolor | Sí |
| 147 | mediano | mediano | mediano | mediano | versicolor | versicolor | Sí |

## Matriz de confusión

Filas = clase que **predijo** el clasificador. Columnas = clase **real**.

|                | setosa | virginica | versicolor |
|:--------------:|:------:|:---------:|:----------:|
| **setosa**     |   8    |     0     |      0     |
| **virginica**  |   0    |     6     |      0     |
| **versicolor** |   0    |     0     |      6     |

Total de observaciones: 20. Aciertos: 20 (100%).

## Observaciones

- Las 20 observaciones se clasificaron correctamente, pero esto no significa que el clasificador sea perfecto: el modelo se calculó con las mismas 150 flores, y esta muestra es pequeña.
- Al aplicar el mismo clasificador a las 150 flores se obtienen **139 aciertos (92.7%)**, es decir, 11 errores, que se dan entre *versicolor* y *virginica*, cuyas medidas se traslapan.

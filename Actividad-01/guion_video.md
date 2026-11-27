# Guion del video: Sistemas expertos

**Autor:** FCO. EMMANUEL DORANTES CAÑA
**Duración estimada:** 7 a 8 minutos
**Liga del video en YouTube:** [PEGAR AQUÍ LA LIGA]

> Recomendaciones de grabación: de cuerpo entero al inicio y al final, ropa adecuada para licenciatura, buena luz y audio claro. Practica el texto 2 o 3 veces para no leerlo y evitar muletillas ("eh", "este", "o sea"). Haz pausas cortas en lugar de rellenar con sonidos.

---

## 1. Apertura (de cuerpo entero) | 0:00 a 0:40

Buenas tardes. Mi nombre es Francisco Emmanuel Dorantes Caña y soy estudiante de [CARRERA] en [UNIVERSIDAD / FACULTAD]. En este video presento los conceptos principales de los sistemas expertos, una rama de la inteligencia artificial.

Voy a explicar qué es el conocimiento, cómo se organiza en una base de conocimiento, cómo razona el motor de inferencia, la historia de estos sistemas y sus tipos principales.

## 2. Qué es un sistema experto | 0:40 a 1:30 (diapositiva 1)

Un sistema experto es un programa que usa conocimiento y procedimientos de inferencia para resolver problemas lo bastante difíciles como para requerir la experiencia de un especialista humano. Esta definición se atribuye a Edward Feigenbaum.

Dicho de otra forma, es un sistema que simula la forma en que razona un experto: guarda su conocimiento, saca conclusiones, toma decisiones y puede explicar por qué las tomó. Se recomienda cuando los expertos son escasos, cuando la subjetividad humana puede llevar a errores o cuando hay un gran volumen de datos por considerar.

## 3. Conocimiento | 1:30 a 2:30 (diapositiva 2)

Para entender estos sistemas hay que distinguir tres niveles. Un dato es un valor sin contexto. La información son datos con significado. Y el conocimiento es información organizada que permite decidir y actuar.

En un sistema experto hay tres tipos de conocimiento. El declarativo, que son hechos, por ejemplo, que la fiebre es un síntoma. El procedimental, que describe cómo hacer algo, como los pasos de un diagnóstico. Y el heurístico, que son las reglas empíricas del experto, su criterio aprendido con la práctica.

Obtener este conocimiento del experto y traducirlo a un formato que la computadora pueda usar es el trabajo de la ingeniería del conocimiento.

## 4. Base de conocimiento | 2:30 a 3:40 (diapositiva 3)

La base de conocimiento es el almacén del saber del experto sobre un dominio concreto. Puede representarse con reglas de producción, marcos, redes semánticas o lógica.

La forma más común son las reglas del tipo SI, ENTONCES. Por ejemplo: si el paciente tiene fiebre y dolor de garganta, entonces se sospecha una infección bacteriana. Es un ejemplo ilustrativo.

Es importante separar la base de conocimiento de la base de hechos, que guarda los datos del caso que se está analizando. La arquitectura completa incluye además el motor de inferencia, un módulo de explicación y la interfaz de usuario.

## 5. Motor de inferencia | 3:40 a 4:50 (diapositiva 4)

El motor de inferencia es la parte que razona. Toma las reglas de la base de conocimiento y las aplica a los hechos para obtener conclusiones nuevas.

Tiene dos estrategias principales. En el encadenamiento hacia adelante, el sistema parte de los datos y avanza hasta llegar a una conclusión. En el encadenamiento hacia atrás, parte de una hipótesis y busca los hechos que la confirmen.

Cuando varias reglas se pueden aplicar al mismo tiempo, el motor resuelve el conflicto eligiendo cuál ejecutar primero. Y el módulo de explicación permite preguntarle por qué llegó a una conclusión.

## 6. Línea de tiempo | 4:50 a 6:10 (diapositiva 5)

La historia empieza en 1950, cuando Alan Turing propone su prueba para evaluar la inteligencia de una máquina. En 1956, en la conferencia de Dartmouth, nace el término inteligencia artificial.

En 1965, en la Universidad de Stanford, aparece DENDRAL, que identificaba estructuras moleculares. Se le considera el primer sistema experto. En los años setenta, también en Stanford, se desarrolla MYCIN, que diagnosticaba infecciones, y surge PROSPECTOR, para exploración minera.

Hacia 1980, el sistema XCON, creado en Carnegie Mellon para la empresa DEC, configuraba computadoras VAX y fue el primer gran éxito comercial. En los años ochenta hubo un auge, con herramientas como CLIPS, de la NASA. A finales de esa década y en los noventa llegó el llamado invierno de la inteligencia artificial, por los costos y la dificultad de obtener el conocimiento de los expertos. Hoy se usan sistemas híbridos que combinan reglas con aprendizaje automático.

## 7. Tipos de sistemas expertos | 6:10 a 7:10 (diapositiva 6)

Según la técnica, los más comunes son los basados en reglas. También existen los basados en casos, que resuelven un problema nuevo a partir de casos parecidos del pasado; los probabilísticos y los difusos, que manejan la incertidumbre; y los híbridos, que combinan varias técnicas.

Según la tarea, hay sistemas de interpretación, diagnóstico, predicción, diseño, planificación, monitoreo y control, e instrucción. Por ejemplo, MYCIN es de diagnóstico, XCON de configuración y PROSPECTOR de interpretación geológica.

## 8. Conclusión (de cuerpo entero) | 7:10 a 8:00 (diapositiva 7, luego a cámara)

Para concluir: un sistema experto simula el razonamiento de un especialista usando conocimiento explícito y reglas de inferencia. Sus piezas clave son la base de conocimiento, el motor de inferencia y la explicación de sus decisiones.

Funcionan bien en problemas acotados, cuando los expertos son escasos o hay muchos datos. Su principal límite es obtener y mantener el conocimiento del experto, y por eso hoy se combinan con aprendizaje automático.

[CONCLUSIÓN PERSONAL: una o dos frases con tu opinión, por ejemplo qué te pareció más interesante o dónde crees que se usarían hoy.]

Gracias por su atención.

# Actividad 3: servidor SWI-Prolog para asignar profesores (FCI, UNACAR)

**Autor:** FCO. EMMANUEL DORANTES CAÑA

## Cómo ejecutarlo

1. Instala SWI-Prolog desde https://www.swi-prolog.org/Download.html
2. En una terminal, dentro de esta carpeta: `swipl server.pl`
3. Verás `Servidor listo en http://localhost:8080`. Abre esa dirección en el navegador.

## Endpoints

| Opción del problema | Endpoint |
|:--|:--|
| 1. Asignar profesores a academias | `GET /api/asignar/academia?id=ac1` |
| 2. Asignar profesores a cuerpos académicos | `GET /api/asignar/cuerpo_academico?id=ca1` |
| 3. Asignar profesores a proyectos | `GET /api/asignar/proyecto?id=p1` |
| 4. Asignar el mejor profesor a un curso | `GET /api/asignar/curso?id=c101` |
| 5. Asignar profesores a cursos de capacitación | `GET /api/asignar/capacitacion?id=cap2` |
| 6. Buscar un profesor y sus asignaciones | `GET /api/buscar?nombre=ana` o `GET /api/buscar?num=1001` |
| Extras | `GET /api/profesores`, `GET /api/asignaciones`, `GET /api/reiniciar` |

IDs de ejemplo: academias `ac1` a `ac4`, cuerpos `ca1` y `ca2`, proyectos `p1` a `p3`, cursos `c101` a `c107`, capacitación `cap1` a `cap4`.

Ejemplo: abre `http://localhost:8080/api/asignar/academia?id=ac1` y después `http://localhost:8080/api/buscar?num=1001` para ver la asignación guardada.

## Cómo decide el sistema (reglas)

El perfil de un profesor se compara con las áreas que pide cada entidad:

| Concepto | Puntos |
|:--|:-:|
| Su especialidad coincide con el área | 5 |
| Estudios en el área: licenciatura / maestría / doctorado | 2 / 3 / 4 |
| Cada capacitación tomada en el área | 1 |
| Cada acreditación en el área | 1 |
| Academias: cada materia de la academia que domina | 3 |
| Capacitación: cada curso del área que imparte | 3 |

- Academias, cuerpos académicos y proyectos: se asignan todos los profesores con **5 puntos o más**.
- Cursos de capacitación: se asignan los profesores con **3 puntos o más** que imparten cursos de esa área y **aún no la han tomado**.
- Curso: se asigna **un solo profesor**, el que tenga ese curso más arriba en su lista de dominio (el de más puntaje si hay empate).

## Supuestos

- Los datos son de ejemplo. Cámbialos en la sección de hechos de `server.pl`.
- El enunciado no indica qué área requiere cada academia, cuerpo, proyecto, curso o capacitación, así que se agregó `perfil_requerido/3` para poder comparar perfiles.
- Las asignaciones se guardan en memoria; se pierden al reiniciar el servidor.

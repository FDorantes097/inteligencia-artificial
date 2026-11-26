% =====================================================================
% Servidor SWI-Prolog: asignación de profesores (FCI, UNACAR)
% Ejecutar:  swipl server.pl      (queda corriendo en http://localhost:8080)
% =====================================================================
:- encoding(utf8).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(lists)).

% asignacion(Tipo, IdEntidad, NumEmpleado): las asignaciones hechas
:- dynamic asignacion/3.

% =====================================================================
% 1. BASE DE HECHOS
% =====================================================================

% profesor(Num, Nombre, Grado, Especialidad, CursosQueDomina)
%   CursosQueDomina va de mayor a menor dominio.
profesor(1001, 'Dra. Ana López Martínez',   doctorado,    inteligencia_artificial, [c101, c102, c104]).
profesor(1002, 'Dr. Carlos Ramírez Soto',   doctorado,    bases_de_datos,         [c103, c104]).
profesor(1003, 'M.C. Laura Hernández Pérez',maestria,     redes,                  [c105, c103]).
profesor(1004, 'M.C. Jorge Pérez Díaz',     maestria,     ingenieria_de_software, [c106, c107]).
profesor(1005, 'Dr. Luis Torres Vega',      doctorado,    inteligencia_artificial,[c102, c101]).
profesor(1006, 'Lic. Marta Gómez Ruiz',     licenciatura, web,                    [c107, c106]).
profesor(1007, 'M.C. Pedro Castillo Núñez', maestria,     bases_de_datos,         [c104, c103, c101]).
profesor(1008, 'Dra. Sofía Méndez Arias',   doctorado,    seguridad,              [c105]).

% estudio(Num, Nivel, Titulo, Area)
estudio(1001, licenciatura, 'Ing. en Sistemas Computacionales', programacion).
estudio(1001, maestria,     'Maestría en Ciencias Computacionales', inteligencia_artificial).
estudio(1001, doctorado,    'Doctorado en Inteligencia Artificial', inteligencia_artificial).
estudio(1002, licenciatura, 'Lic. en Informática', bases_de_datos).
estudio(1002, maestria,     'Maestría en Bases de Datos', bases_de_datos).
estudio(1002, doctorado,    'Doctorado en Ciencias de la Computación', bases_de_datos).
estudio(1003, licenciatura, 'Ing. en Telemática', redes).
estudio(1003, maestria,     'Maestría en Redes', redes).
estudio(1004, licenciatura, 'Lic. en Sistemas', ingenieria_de_software).
estudio(1004, maestria,     'Maestría en Ingeniería de Software', ingenieria_de_software).
estudio(1005, licenciatura, 'Ing. en Computación', programacion).
estudio(1005, maestria,     'Maestría en Inteligencia Artificial', inteligencia_artificial).
estudio(1005, doctorado,    'Doctorado en Inteligencia Artificial', inteligencia_artificial).
estudio(1006, licenciatura, 'Lic. en Sistemas de Información', web).
estudio(1007, licenciatura, 'Lic. en Informática', bases_de_datos).
estudio(1007, maestria,     'Maestría en Minería de Datos', bases_de_datos).
estudio(1008, licenciatura, 'Ing. en Seguridad Informática', seguridad).
estudio(1008, maestria,     'Maestría en Ciberseguridad', seguridad).
estudio(1008, doctorado,    'Doctorado en Seguridad de la Información', seguridad).

% acreditacion(Num, Nombre, Area)
acreditacion(1002, 'Oracle Certified Professional', bases_de_datos).
acreditacion(1003, 'CCNA',                          redes).
acreditacion(1004, 'Scrum Master',                  ingenieria_de_software).
acreditacion(1008, 'CISSP',                         seguridad).

% capacitacion_tomada(Num, IdCursoCapacitacion)
capacitacion_tomada(1001, cap1).
capacitacion_tomada(1005, cap1).
capacitacion_tomada(1002, cap2).
capacitacion_tomada(1007, cap2).
capacitacion_tomada(1003, cap3).
capacitacion_tomada(1008, cap3).
capacitacion_tomada(1004, cap4).

% cuerpo_academico(Id, Nombre, LineaInvestigacion, Lider, Estatus)
cuerpo_academico(ca1, 'Sistemas inteligentes y minería de datos', 'Inteligencia artificial aplicada', 1005, 'en consolidación').
cuerpo_academico(ca2, 'Tecnologías de la información', 'Ingeniería de software y web', 1004, 'consolidado').

% academia(Id, Nombre, MateriasAsignadas, Lider)
academia(ac1, 'Sistemas inteligentes',     [c101, c102], 1001).
academia(ac2, 'Datos',                     [c103, c104], 1002).
academia(ac3, 'Redes y seguridad',         [c105],       1003).
academia(ac4, 'Ingeniería de software',    [c106, c107], 1004).

% proyecto(Id, Nombre, Objetivo, Entregables, Lider, Integrantes, FechaInicio, FechaEntrega)
proyecto(p1, 'Sistema experto de diagnóstico agrícola',
         'Apoyar el diagnóstico de plagas con reglas de un experto',
         ['base de conocimiento', 'motor de inferencia', 'manual'], 1001, [1001], '2027-01-15', '2027-06-30').
proyecto(p2, 'Plataforma web de gestión escolar',
         'Controlar inscripciones y calificaciones',
         ['sistema web', 'base de datos', 'documentación'], 1004, [1004], '2027-02-01', '2027-08-31').
proyecto(p3, 'Red segura del campus',
         'Rediseñar y proteger la red de la facultad',
         ['diseño de red', 'política de seguridad'], 1003, [1003], '2027-03-01', '2027-07-15').

% curso(Id, Creditos, Nombre, Objetivo, Academia)
curso(c101, 6, 'Inteligencia artificial',  'Conocer los fundamentos de la IA',            ac1).
curso(c102, 6, 'Sistemas expertos',        'Construir sistemas basados en conocimiento',  ac1).
curso(c103, 6, 'Bases de datos',           'Diseñar y consultar bases de datos',          ac2).
curso(c104, 6, 'Minería de datos',         'Descubrir patrones en grandes volúmenes',     ac2).
curso(c105, 6, 'Redes de computadoras',    'Entender el diseño y operación de redes',     ac3).
curso(c106, 6, 'Ingeniería de software',   'Aplicar procesos de desarrollo de software',  ac4).
curso(c107, 6, 'Programación web',         'Desarrollar aplicaciones web',                ac4).

% curso_capacitacion(Id, Nombre, Objetivo, Horas, FechaInicio, FechaConclusion)
curso_capacitacion(cap1, 'Aprendizaje automático con Python', 'Actualizar a profesores en ML', 40, '2027-01-10', '2027-01-24').
curso_capacitacion(cap2, 'Bases de datos NoSQL',              'Conocer MongoDB y Redis',        30, '2027-02-07', '2027-02-18').
curso_capacitacion(cap3, 'Seguridad en redes',                'Practicar defensa de redes',     20, '2027-03-01', '2027-03-08').
curso_capacitacion(cap4, 'Metodologías ágiles',               'Aplicar Scrum en proyectos',     25, '2027-03-15', '2027-03-26').

% ---------------------------------------------------------------------
% AREAS REQUERIDAS (dato agregado: el enunciado no lo da, pero es
% necesario para comparar el perfil del profesor con cada entidad)
% perfil_requerido(Tipo, Id, ListaDeAreas)
% ---------------------------------------------------------------------
perfil_requerido(academia, ac1, [inteligencia_artificial]).
perfil_requerido(academia, ac2, [bases_de_datos]).
perfil_requerido(academia, ac3, [redes, seguridad]).
perfil_requerido(academia, ac4, [ingenieria_de_software, web]).

perfil_requerido(cuerpo_academico, ca1, [inteligencia_artificial, bases_de_datos]).
perfil_requerido(cuerpo_academico, ca2, [ingenieria_de_software, web, redes]).

perfil_requerido(proyecto, p1, [inteligencia_artificial]).
perfil_requerido(proyecto, p2, [web, ingenieria_de_software, bases_de_datos]).
perfil_requerido(proyecto, p3, [redes, seguridad]).

perfil_requerido(curso, c101, [inteligencia_artificial]).
perfil_requerido(curso, c102, [inteligencia_artificial]).
perfil_requerido(curso, c103, [bases_de_datos]).
perfil_requerido(curso, c104, [bases_de_datos, inteligencia_artificial]).
perfil_requerido(curso, c105, [redes]).
perfil_requerido(curso, c106, [ingenieria_de_software]).
perfil_requerido(curso, c107, [web, programacion]).

perfil_requerido(capacitacion, cap1, [inteligencia_artificial]).
perfil_requerido(capacitacion, cap2, [bases_de_datos]).
perfil_requerido(capacitacion, cap3, [redes, seguridad]).
perfil_requerido(capacitacion, cap4, [ingenieria_de_software]).

% =====================================================================
% 2. REGLAS DE PUNTAJE (qué tan bien encaja un profesor)
% =====================================================================
% Puntos: especialidad que coincide = 5
%         cada estudio en el área: licenciatura 2, maestría 3, doctorado 4
%         cada capacitación tomada en el área = 1
%         cada acreditación en el área = 1
%         (academias) cada materia de la academia que domina = 3
%         (capacitación) cada curso que imparte del área = 3
% Umbral: 5 puntos (academia, cuerpo académico, proyecto) y 3 puntos
% para capacitación.

umbral(capacitacion, 3) :- !.
umbral(_, 5).

pts_nivel(licenciatura, 2).
pts_nivel(maestria,     3).
pts_nivel(doctorado,    4).

puntaje(Num, Tipo, Id, Puntos, Detalle) :-
    perfil_requerido(Tipo, Id, Areas),
    profesor(Num, _, _, Esp, Cursos),
    (   memberchk(Esp, Areas) -> PEsp = 5 ; PEsp = 0 ),
    findall(P, ( estudio(Num, Nivel, _, A1), memberchk(A1, Areas),
                 pts_nivel(Nivel, P) ), Ps),
    sum_list(Ps, PEst),
    findall(Cap, ( capacitacion_tomada(Num, Cap),
                   perfil_requerido(capacitacion, Cap, CAreas),
                   member(A2, CAreas), memberchk(A2, Areas) ), Caps0),
    sort(Caps0, Caps),
    length(Caps, PCap),
    findall(Nm, ( acreditacion(Num, Nm, A3), memberchk(A3, Areas) ), Acs),
    length(Acs, PAcr),
    materias_dominadas(Tipo, Id, Cursos, PMat),
    Puntos is PEsp + PEst + PCap + PAcr + PMat,
    Detalle = _{ especialidad:PEsp, estudios:PEst, capacitaciones:PCap,
                 acreditaciones:PAcr, cursos_dominados:PMat }.

materias_dominadas(academia, Id, Cursos, P) :- !,
    academia(Id, _, Materias, _),
    findall(M, ( member(M, Materias), memberchk(M, Cursos) ), L),
    length(L, N),
    P is N * 3.
% Capacitación: se recomienda a quien imparte cursos de esa área
% (3 puntos por cada curso que domina y que es del área)
materias_dominadas(capacitacion, Id, Cursos, P) :- !,
    perfil_requerido(capacitacion, Id, Areas),
    findall(C, ( member(C, Cursos),
                 perfil_requerido(curso, C, CAreas),
                 member(A, CAreas), memberchk(A, Areas) ), L0),
    sort(L0, L),
    length(L, N),
    P is N * 3.
materias_dominadas(_, _, _, 0).

% No se manda a un curso de capacitación a quien ya lo tomó
excluido(capacitacion, Id, Num) :- capacitacion_tomada(Num, Id).

% candidatos(+Tipo, +Id, -Lista): lista Puntos-Num, de mayor a menor
candidatos(Tipo, Id, Lista) :-
    umbral(Tipo, U),
    findall(Pts-Num,
            ( profesor(Num, _, _, _, _),
              \+ excluido(Tipo, Id, Num),
              puntaje(Num, Tipo, Id, Pts, _),
              Pts >= U ),
            L0),
    sort(1, @>=, L0, Lista).

registrar(Tipo, Id, Num) :- asignacion(Tipo, Id, Num), !.
registrar(Tipo, Id, Num) :- assertz(asignacion(Tipo, Id, Num)).

% =====================================================================
% 3. ASIGNACIONES (opciones 1 a 5)
% =====================================================================

% Opción 4: UN solo profesor, el mejor. Se prefiere a quien tiene el
% curso más arriba en su lista de dominio; si hay empate, el de más puntaje.
asignar(curso, Id, Resp) :- !,
    findall(Pos-NegPts-Num,
            ( profesor(Num, _, _, _, Cursos),
              nth1(Pos, Cursos, Id),
              puntaje(Num, curso, Id, Pts, _),
              NegPts is -Pts ),
            L0),
    msort(L0, L1),
    curso(Id, _, Nombre, _, _),
    (   L1 = [Pos-NegPts-Num|_]
    ->  Pts is -NegPts,
        retractall(asignacion(curso, Id, _)),
        assertz(asignacion(curso, Id, Num)),
        prof_dict(Num, PD),
        Resp = _{ tipo:curso, id:Id, curso:Nombre, mejor_profesor:PD,
                  posicion_en_su_lista:Pos, puntaje:Pts }
    ;   Resp = _{ tipo:curso, id:Id, curso:Nombre,
                  mensaje:"ningún profesor domina este curso" }
    ).

% Opciones 1, 2, 3 y 5: todos los profesores que cumplen el umbral
asignar(Tipo, Id, Resp) :-
    candidatos(Tipo, Id, Lista),
    umbral(Tipo, U),
    findall(R,
            ( member(Pts-Num, Lista),
              registrar(Tipo, Id, Num),
              prof_dict(Num, PD),
              puntaje(Num, Tipo, Id, _, Det),
              R = _{ profesor:PD, puntaje:Pts, detalle:Det } ),
            Asignados),
    length(Asignados, N),
    nombre_entidad(Tipo, Id, Nombre),
    Resp = _{ tipo:Tipo, id:Id, nombre:Nombre, umbral_puntaje:U,
              total_asignados:N, asignados:Asignados }.

nombre_entidad(academia,         Id, N) :- academia(Id, N, _, _).
nombre_entidad(cuerpo_academico, Id, N) :- cuerpo_academico(Id, N, _, _, _).
nombre_entidad(proyecto,         Id, N) :- proyecto(Id, N, _, _, _, _, _, _).
nombre_entidad(curso,            Id, N) :- curso(Id, _, N, _, _).
nombre_entidad(capacitacion,     Id, N) :- curso_capacitacion(Id, N, _, _, _, _).

% =====================================================================
% 4. BÚSQUEDA DE PROFESOR (opción 6)
% =====================================================================
buscar_prof(Nombre, Num, N) :-
    profesor(N, NombreP, _, _, _),
    (   nonvar(Num)    -> N =:= Num
    ;   nonvar(Nombre) -> downcase_atom(NombreP, A),
                          downcase_atom(Nombre, B),
                          once(sub_atom(A, _, _, _, B))
    ;   true
    ).

prof_dict(Num, _{ num_empleado:Num, nombre:Nombre, grado:Grado,
                  especialidad:Esp, cursos_que_domina:Cursos }) :-
    profesor(Num, Nombre, Grado, Esp, Cursos).

perfil_completo(Num, _{ profesor:P, estudios:E, acreditaciones:A,
                        capacitaciones_tomadas:C, asignaciones:S }) :-
    prof_dict(Num, P),
    findall(_{nivel:Nv, titulo:T, area:Ar}, estudio(Num, Nv, T, Ar), E),
    findall(_{nombre:Nm, area:Ar}, acreditacion(Num, Nm, Ar), A),
    findall(_{id:Id, nombre:Nm},
            ( capacitacion_tomada(Num, Id),
              curso_capacitacion(Id, Nm, _, _, _, _) ), C),
    findall(_{tipo:Tp, id:Id, nombre:Nm},
            ( asignacion(Tp, Id, Num), nombre_entidad(Tp, Id, Nm) ), S).

% =====================================================================
% 5. SERVIDOR HTTP: ENDPOINTS
% =====================================================================
:- http_handler(root(.),                         h_inicio,        []).
:- http_handler(root(api/profesores),            h_profesores,    []).
:- http_handler(root(api/buscar),                h_buscar,        []).
:- http_handler(root(api/asignaciones),          h_asignaciones,  []).
:- http_handler(root(api/reiniciar),             h_reiniciar,     []).
:- http_handler(root(api/asignar/academia),         h_asignar(academia),         []).
:- http_handler(root(api/asignar/cuerpo_academico), h_asignar(cuerpo_academico), []).
:- http_handler(root(api/asignar/proyecto),         h_asignar(proyecto),         []).
:- http_handler(root(api/asignar/curso),            h_asignar(curso),            []).
:- http_handler(root(api/asignar/capacitacion),     h_asignar(capacitacion),     []).

h_inicio(_Request) :-
    reply_json_dict(_{
        servicio: "Asignación de profesores FCI-UNACAR",
        endpoints: [
          "GET /api/profesores",
          "GET /api/buscar?nombre=ana   o   /api/buscar?num=1001",
          "GET /api/asignar/academia?id=ac1",
          "GET /api/asignar/cuerpo_academico?id=ca1",
          "GET /api/asignar/proyecto?id=p1",
          "GET /api/asignar/curso?id=c101",
          "GET /api/asignar/capacitacion?id=cap2",
          "GET /api/asignaciones",
          "GET /api/reiniciar"
        ]
    }).

h_profesores(_Request) :-
    findall(D, ( profesor(N, _, _, _, _), prof_dict(N, D) ), L),
    reply_json_dict(_{ profesores:L }).

h_buscar(Request) :-
    http_parameters(Request, [ nombre(Nombre, [atom,    optional(true)]),
                               num(Num,       [integer, optional(true)]) ]),
    findall(D, ( buscar_prof(Nombre, Num, N), perfil_completo(N, D) ), L),
    (   L == []
    ->  reply_json_dict(_{ error:"no se encontró ningún profesor" }, [status(404)])
    ;   reply_json_dict(_{ resultados:L })
    ).

h_asignar(Tipo, Request) :-
    http_parameters(Request, [ id(Id, [atom]) ]),
    (   perfil_requerido(Tipo, Id, _)
    ->  asignar(Tipo, Id, Resp),
        reply_json_dict(Resp)
    ;   reply_json_dict(_{ error:"no existe esa entidad", tipo:Tipo, id:Id },
                        [status(404)])
    ).

h_asignaciones(_Request) :-
    findall(_{tipo:T, id:I, num_empleado:N}, asignacion(T, I, N), L),
    reply_json_dict(_{ asignaciones:L }).

h_reiniciar(_Request) :-
    retractall(asignacion(_, _, _)),
    reply_json_dict(_{ mensaje:"asignaciones borradas" }).

% =====================================================================
% 6. ARRANQUE
% =====================================================================
servidor :- servidor(8080).
servidor(Puerto) :-
    http_server(http_dispatch, [port(Puerto)]),
    format("Servidor listo en http://localhost:~w~n", [Puerto]).

:- initialization(servidor).

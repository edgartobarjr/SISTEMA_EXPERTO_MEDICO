
/*
INTERFAZ GRAFICA: Esta parte del sistema experto es la que se encarga de
interactuar con la persona comun, mostrar imagenes, botones, textos, etc.

INICIAR SISTEMA EXPERTO:
PARA CORRER EL PROGRAMA, ES NESESARIO CARGAR LAS 3 PARTES AL SWI PROLOG
Y LUEGO SOLO CONSULTAR TODO, AUTOMATICAMENTE SE ABRIRA LA VENTANA DEL PROGRAMA
*/
 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.

 resource(img_principal, image, image('img_principal.jpg')).
 resource(portada, image, image('portada.jpg')).

/*
Imagenes Tratamiento*/


 resource(gripe, image, image('trat_gripe.jpg')).
 resource(paperas, image, image('trat_paperas.jpg')).
 resource(varicela, image, image('trat_varicela.jpg')).
 resource(sarampion, image, image('trat_sarampion.jpg')).
 resource(anemia, image, image('trat_anemia.jpg')).
 resource(dengue, image, image('trat_dengue.jpg')).
 resource(diarrea, image, image('trat_diarrea.jpg')).
 resource(gastritis, image, image('trat_gastritis.jpg')).
 resource(lo_siento_diagnostico_desconocido, image, image('desconocido.jpg')).


/*
Sintomas*/

 resource(garganta, image, image('dolor_garganta.jpg')).
 resource(palidez, image, image('palidez.jpg')).
 resource(moqueo, image, image('moqueo.jpg')).
 resource(mareo, image, image('mareo.jpg')).
 resource(hablar, image, image('hablar.jpg')).
 resource(apetito, image, image('apetito.jpg')).
 resource(puntos_blancos, image, image('puntos_blancos.jpg')).
 resource(pecho, image, image('pecho.jpg')).
 resource(dolor_oido, image, image('dolor_oido.jpg')).
 resource(cabeza, image, image('cabeza.jpg')).
 resource(tos, image, image('tos.jpg')).
 resource(fiebre, image, image('fiebre.jpg')).
resource(rasposa, image, image('rasposa.jpg')).
resource(flema, image, image('flema.jpg')).
resource(cansancio, image, image('cansancio.jpg')).
resource(muscular, image, image('muscular.jpg')).
resource(vomitar, image, image('vomitar.jpg')).
resource(escalofrio, image, image('escalofrio.jpg')).
resource(abdominal, image, image('abdominal.jpg')).
resource(acidez, image, image('acidez.jpg')).



 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
  mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
  imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  botones:-borrado,
                send(@boton, free),
                send(@btntratamiento,free),
                mostrar_diagnostico(Enfermedad),
                send(@texto, selection('El Diagnostico a partir de los datos es:')),
                send(@resp1, selection(Enfermedad)),
                new(@boton, button('Iniciar consulta',
                message(@prolog, botones)
                )),

                new(@btntratamiento,button('Detalles y Tratamiento',
                message(@prolog, mostrar_tratamiento,Enfermedad)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btntratamiento,point(138,450)).



  mostrar_tratamiento(X):-new(@tratam, dialog('Tratamiento')),
                          send(@tratam, append, label(nombre, 'Explicacion: ')),
                          send(@tratam, display,@lblExp1,point(8,25)),
                          send(@tratam, display,@lblExp2,point(8,25)),
                          tratamiento(X),
                          send(@tratam, transient_for, @main),
                          send(@tratam, open_centered).

tratamiento(X):- send(@lblExp1,selection('De Acuerdo Al Diagnostico El Tratamiento Es:
Puede comprar la Medicina aqui:
Farmacia Batres: http://bit.ly/2TiyiBw, Farmacia Galeno: http://bit.ly/39ms1u3, Farmacia Cruz Verde: http://bit.ly/2IjNlEB')),
                 mostrar_imagen_tratamiento(@tratam,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   preguntar(Preg,Resp):-new(Di,dialog('Colsultar Datos:')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  interfaz_principal:-new(@main,dialog('Sistema Experto Diagnosticador de Enfermedades',
        size(1000,1000))),
        new(@texto, label(nombre,'El Diagnostico a partir de los datos es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),
        new(@boton, button('Iniciar consulta',message(@prolog, botones))),

        new(@btntratamiento,button('¿Tratamiento?')),

        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        send(@main, display,@texto,point(20,130)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(20,180)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  crea_interfaz_inicio:- new(@interfaz,dialog('Bienvenido al Sistema Experto Diagnosticador',
  size(1000,1000))),

  mostrar_imagen(@interfaz, portada),

  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIDA',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.

/* BASE DE CONOCIMIENTOS: Sintomas y Enfermedades, contiente ademas
el identificador de imagenes de acuerdo al  sintoma
*/

conocimiento('gripe',
['le duele la garganta', 'dificultad para hablar',
'garganta rasposa','tiene flema','tiene moqueo']).
conocimiento('paperas',
['tiene fiebre', 'tiene perdida de apetito',
'tiene dolor de oido','dificultad para hablar']).
conocimiento('sarampion',
['tiene fiebre', 'tiene tos',
'tiene moqueo','tiene puntos blancos en la boca']).
conocimiento('anemia',
['tiene dolor de cabeza', 'tiene palidez',
'tiene mareo', 'tiene dolor en el pecho']).
conocimiento('varicela',
['tiene dolor de cabeza', 'tiene cansancio',
'tiene perdida de apetito','tiene fiebre']).
conocimiento('dengue',
['tiene dolor muscular',
'tiene fiebre', 'tiene tos', 'ha vomitado', 'tiene escalofrios', 'tiene dolor de cabeza']).
conocimiento('diarrea',
['tiene perdida de apetito', 'ha vomitado',
'dolor abdominal','tiene fiebre']).
conocimiento('gastritis',
['dolor abdominal', 'ha vomitado',
'tiene perdida de apetito','tiene acidez']).



/*Gripe*/
id_imagen_preg('le duele la garganta','garganta').
id_imagen_preg('dificultad para hablar','hablar').
id_imagen_preg('garganta rasposa','rasposa').
id_imagen_preg('tiene flema','flema').

/*Paperas*/
id_imagen_preg('tiene dolor de oido','dolor_oido').
id_imagen_preg('dificultad para hablar','hablar').

/*Varicela*/
id_imagen_preg('tiene dolor de cabeza','cabeza').
id_imagen_preg('tiene cansancio','cansancio').
id_imagen_preg('tiene perdida de apetito','apetito').

/*Sarampion*/
id_imagen_preg('tiene fiebre','fiebre').
id_imagen_preg('tiene tos','tos').
id_imagen_preg('tiene moqueo','moqueo').
id_imagen_preg('tiene puntos blancos en la boca','puntos_blancos').

/*Anemia*/
id_imagen_preg('tiene mareo','mareo').
id_imagen_preg('tiene palidez','palidez').
id_imagen_preg('tiene dolor en el pecho','pecho').

/*Dengue*/
id_imagen_preg('tiene dolor muscular','muscular').
id_imagen_preg('ha vomitado','vomitar').
id_imagen_preg('tiene escalofrios','escalofrio').

/*Diarrea*/
id_imagen_preg('dolor abdominal','abdominal').

/*Gastritis*/
id_imagen_preg('tiene acidez','acidez').



 /* MOTOR DE INFERENCIA: Esta parte del sistema experto se encarga de
 inferir cual es el diagnostico a partir de las preguntas realizadas
 */
:- dynamic conocido/1.

  mostrar_diagnostico(X):-haz_diagnostico(X),clean_scratchpad.
  mostrar_diagnostico(lo_siento_diagnostico_desconocido):-clean_scratchpad .

  haz_diagnostico(Diagnosis):-
                            obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
                            prueba_presencia_de(Diagnosis, ListaDeSintomas).


obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
                            conocimiento(Diagnosis, ListaDeSintomas).


prueba_presencia_de(Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head | Tail]):- prueba_verdad_de(Diagnosis, Head),
                                              prueba_presencia_de(Diagnosis, Tail).


prueba_verdad_de(Diagnosis, Sintoma):- conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(Diagnosis, Sintoma, Reply), Reply = 'si'.


pregunta_sobre(Diagnosis, Sintoma, Reply):- preguntar(Sintoma,Respuesta),
                          process(Diagnosis, Sintoma, Respuesta, Reply).


process(Diagnosis, Sintoma, si, si):- asserta(conocido(Sintoma)).
process(Diagnosis, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))).


clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).

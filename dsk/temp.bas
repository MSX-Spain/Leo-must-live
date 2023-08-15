1 'Color caracteres, fondo, borde'
10 cls:color 15,1,1:key off
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E, inicializamos el psg &h90'
1 '&h41 y &h44 Enlazamos con las rutinas de apagar y encender la pantalla'
20 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0):defusr3=&h41:defusr4=&h44
30 screen 2,2,0

1 'Todas las variables serán enteras'
40 defint a-z

1 'Definimos un canal necesario para poder mostrar texto, habrá que poner en el print o input #1'
50 open "grp:" as #1

1 '2000 es la subrrutina para pintar un mensaje'
70 me$="^Loading sprites":gosub 2000
1 'cargamos los sprites en VRAM'
80 gosub 9000
90 me$="^Loading tileset":gosub 2000
1 'Cargamos los tiles'
100 gosub 10000

 
1 '' ******************************
1 '' Program:  SAM must live
1 '' autor:    MSX spain
1 '' ******************************
1 '***************
1 '****Variables**
1 '***************
1 'f=fase'
1 'me$=mensaje'
1 'mc=counter map, para ir pintando el mapa con los tiles'
1 'ml=limit map, el ancho del mapa'
1 'ig=in game, nos permite saber si el juego está corriendo'

1 'ts=solid tile, tile a partir que está el suelo'
1 'td=dead tile, tile que te matan'
1 't3,t5,t7=tile derecha, tile abajo y tile izquierda'

1 'x, y=player coordinates
1 'v=velocidad horizontal'
1 'o=old y position'
1 'a=player está saltando'
1 'p,p0,p1,p2,p3=sprite asignado que irá cambiando con los valores de p0 a p3'

1 'mp=mapa direction'
1 'dat=datos, usada para el restore de los datas'
1 'r, c=row and column for bucle'

1 '****************
1 '***Subrrutinas**
1 '****************
1 ' 9000 Rutina cargar sprites en VRAM con datas basic''


1 'El interval on es para mostrar el tiempo'
110 me$="":ON INTERVAL=50 GOSUB 21000
120 f=1:ts=37:td=30:mc=0:ml=60:dim m(100,16)
1 'inicializamos el array con el mapa de tiles'
125 gosub 20200
1 'Mostramos la pantalla de bienvenida'
130 gosub 1800
140 x=0:y=9*8:v=8:P=0:P0=0:P1=1:P2=2:P3=3:P4=4:P5=5:PUTSPRITE0,(x,y),4,p
150 goto 500

1 'Main-loop'
    200 s=STICK(0)ORSTICK(1)
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    210 ON s GOTO 230,250,270,290,310,330,350,370
    220 goto 400

    1 'movimiento hacia arriba o salto
    230 Y=Y-4:P=P4:SWAPP4,P5
    1 '1 Pulsado la tecla 1 Saltamos y reproducimos un sonido'
    1 '230 if a=0 and t5>=ts then o=y:a=1:GOTO 210
    240 GOTO 400
    1 '2 Pulsado 2 movimiento hacia arriba derecha o salto hacia arriba'
    250 X=X+4:if a=0 and t5>=ts then o=y:a=1
    1 ' ponemos el sprite 0 o 1 que corresponde a los de la derecha'
    260 P=P0:SWAPP0,P1:GOTO 400
    1 '3 pulsado Movimiento hacia la derecha '
    270 X=X+v
    280 P=P0:SWAPP0,P1:GOTO 400
    1 '4 Movimiento abajo derecha'
    290 X=X+v
    300 P=P0:SWAPP0,P1:GOTO 400
    1 '5 Movimiento  abajo'
    310 Y=Y+4
    320 P=P4:SWAPP4,P5:GOTO 400
    1 '6 Moviemiento abajo izquierda'
    330 'Y=Y+4:X=X-4
    340 P=P2:SWAPP2,P3:GOTO 400
    1 '7 Movimiento izquierd'
    350 X=X-v
    360 P=P2:SWAPP2,P3:GOTO 400
    1 '8 movimiento arriba izquierda'
    370 X=X-v:if a=0 and t5>=ts then o=y:a=1
    380 P=P2:SWAPP2,P3


    1 'Chequeo colisiones pantalla'
    400 IF Y<56 THEN Y=56 else if y>120 then y=120
    410 if x<0 then x=0 else if x>240 then x=240
    1 'Si el player está saltando, irá hacia arrina hasta -16'
    1 ' 420 if a=1 then y=y-8:if y<o-16 then a=0
    1 'Si el player está cayendo
    1 '430 if a=0 and t5<ts or t5=255 then y=y+8 
    1 'Actualizamos las variables con los tiles t1,t3,t5,t7'
    1 '     ^ t1  '
    1 '     |     '
    1 't7 <- -> t3'
    1 '     |     '
    1 '     v t5  '
    1 '440 hl=base(10)+(((y/8)+1)*32)+((x/8)+1):t3=vpeek(hl)
    450 hl=base(10)+(((y/8)+2)*32)+((x/8)+1):t5=vpeek(hl)
    1 '460 hl=base(10)+(((y/8)+1)*32)+((x/8)):t7=vpeek(hl)
    1 'Si t5 es el tile de la muerte td=dead tile, matamos al player
    470 if t5=td or t3=td or t7=td then gosub 4000
    1 '475 if t3>=ts then x=x-v else if t7>=ts then x=x+v
    480 PUTSPRITE0,(X,Y),4,P
    1'482 t1=time/50:if t1<>t2 then:gosub 2100:t2=t1
    482 mc=time/50
    1 '483 if mc mod 2=0 and mc<ml then restore 22000:gosub 21000
    483  if mc>=ml then interval off
    
    484 gosub 2100
    1 '484 if m2<>mc then restore 22000:gosub 21000:m2=mc
    1 '3000= debug'
    485 'gosub 3000
    490 ON f GOSUB 530,630,730,930,1130,1330,1530
495 goto 200




1 'Fase 1'
1'--------
1 'se pinta el mapa de tiles y se inicializa'
500 'restore 22000
501 gosub 21000
1 'Activamos las interrupciones de intervalo para mostrar el tiempo'
503 time=0:interval on
510 'se inicializan os enemigos, se pintan los objetos y el marcador
520 goto 200
530 if mc=ml then print #1, "fase completada": goto 600
540 'pintamos los enemigos
550 'Actualizamos los enemigos
590 return 200

1 'Fase 2'
1'--------
600 f=2:x=0:y=9*8:gosub 21000
610 goto 200
630 if x>232 then goto 700
640 'lo mismo que en la fase 1
690 return 200

1 'Fase 3'
1'--------
700 f=3:x=0:y=9*8:gosub 21000
710 goto 200
730 if x>232 then goto 1700
740 'lo mismo que en la fase 1
790 return 200

1 'Fase 4'
1'--------
900 f=4:x=0:y=9*8:gosub 21000
910 goto 200
930 if x>240 then goto 1100 
940 'lo mismo que en la fase 1
990 return 200

1 'Fase 5'
1'--------
1100 f=5:x=0:y=9*8:gosub 21000
1110 goto 200
1130 if x>240 then goto 1300
1140 'lo mismo que en la fase 1
1190 return 200

1 'Fase 6'
1'--------
1300 f=6:x=0:y=9*8:gosub 21000
1310 goto 200
1330 if x>240 then goto 1500 
1340 'lo mismo que en la fase 1
1390 return 200

1 'Fase 7'
1'--------
1500 f=7:x=0:y=9*8:gosub 21000
1510 goto 200
1530 if x>240 then goto 1700
1590 return 200


1' Pantalla ganadora
    1700 me$="^Tu ganas":gosub 2000
    1710 ON STRIG GOSUB 1790:STRIG(0)ON
    1720 GOTO 1720
1790 STRIG(0)OFF:RETURN 110

1 ' menu principal'
    1800 me$="^menu pricipal, pulse una tecla":gosub 2000
    1810 ON STRIG gosub 1890:STRIG(0)ON
    1820 GOTO 1820
1890 STRIG(0)OFF:RETURN 140

1 'HUD'
    2000 line(0,140)-(255,150),1,bf
    2010 preset (0,140):print #1,me$
2020 return

1 'print time'
    2100 line(200,160)-(220,170),1,bf
    2110 preset (200,160):print #1,mc
2190 return
1 'debug'
    3000 line(0,160)-(200,180),1,bf
    3010 preset (0,160):print #1,t3
3090 return

1 'Player muere'
4000 x=0:y=9*8
4090 return


20200 restore 22000:po=0
    20210 for f=0 to 15:READ mp$:po=0
        20220 for c=0 to len(mp$) step 2
            20230 tn$=mid$(mp$,c+1,2)
            20240 tn=val("&h"+tn$)
            20250 tn=tn-1: if tn=0 and tn=-1 then tn=0
            20270 m(po,f)=tn:po=po+1
        20280 next c
    20290 next f
20299 return

1 'ponemos en la tabla nombres los tiles
    21000 _TURBO ON (m(),mc)
    21005 md=6144
    21010 for f=0 to 15
        1 ' ahora leemos las columnas c, 63 son 32 tiles
        21020 for c=mc to 31+mc
            21030 tn=m(c,f)
            21040 VPOKE md,tn
            21050 md=md+1
        21060 next c
    21070 next f
    21080 _TURBO OFF


    1 '1 'Compresión RLE-16'
    1 '21050 for r=0 to 15
    1 '    21060 READ mp$
    1 '    21070 for c=0 to 63 step 4
    1 '        1 'El 1 valor indica la cantidad de repeticiones, el 2 el valor en si'
    1 '        21080 r$=mid$(mp$,c+1,2)
    1 '        21090 tn$=mid$(mp$,c+3,2)
    1 '        21100 tn=val("&h"+tn$):tn=tn-1
    1 '        21110 re=val("&h"+r$)
    1 '        21120 for i=0 to re
    1 '            21130 if tn<>0 and tn<>-1 then VPOKE md,tn
    1 '            21140 md=md+1
    1 '        21150 next i
    1 '    21160 next c
    1 '21180 next r

    22000 data 23232323232323232323232323232323232323232323232323232323252523232325232323232323232525232323232323232323232323232323232323232323232525232525252525252523232323232323232323232323232325232525232325252525
    22010 data 23232323232323232323232323232323232323252523232323232323252523232525232323232323232525232323232525232525232323232323232323232323232525252525252525252523232523232323232323252523232525232525232325252525
    22020 data 23252523232323232323232323232525232323252523232323232525252523232525232323232325252525232323232525232525232325232323252523232325252525252525252525252523232525232323252523252523232525232525232325252525
    22030 data 23252523232525232323232323232525232525252523232323232525252523232525232323232325252525232525232525232525232325232323252523232325252525252525252525252523232525232323252523252523232525232525232325252525
    22040 data 23252523232525232323232323232525232525252523232325252525252523232525232525232325252525232525232525232525232325232323252523232325252525252525252525252523232525232323252523252523232525232525232525252525
    22050 data 23252523232525252323232325252525232525252523232325252525252523232525232525232325252525232525232525232525252525232323252523232325252525252525252525252523232525232323252523252523232525232525232525252525
    22060 data 25252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525
    22070 data 21212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121
    22080 data 21212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212145212121212121212121212121212121212121212121472121212121212121212121
    22090 data 21212121212121212121212121212121212121212121212121212121212148484848484848484848484848484848484848484848484848484848484848484848484845212121484848484848484848484848484848484848472121212121212121212121
    22100 data 21212121212121212121212121212121212121212121212121212121212148212121212121212121212121212148212121212121212121212121212121212121212145212121482121212121212121212121212121212121472121212121212121484821
    22110 data 21212148484848484848484848484848484848484848484848484848484848212121212121212121212121212148484848484848484848484848484821212121212121212121484848484848484848484848484848484848484848484848484848484821
    22120 data 21212121212121212121212121212121212121212121212121212121212148212121212121212121212121462121212121212121212121212121214821212121212121212121482121212121214721212121212121212121212121212121212121484821
    22130 data 21212121212121212121212121212121212121212121212121212121212148212121212121212121484848462121212121212121212121212121214848484848484848484848484848484848484721212121212121212121212121212121212121212121
    22140 data 21212121212121212121212121212121212121212121212121212121212148484848484848484848482121462121212121212121212121212121212121212121212121212121212121212121214721212121212121212121212121212121212121212121
    22150 data 21212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121214721212121212121212121212121212121212121212121

   23180 me$=str$(f):gosub 2000
23190 return 
1 '--------------------------------------------------------------------------------------'
1 '-------------------------------------Level 1------------------------------------------'
1 '--------------------------------------------------------------------------------------'

1 'Compresión RLE16'



1 '22000 data 2323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323
1 '22010 data 2323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323
1 '22020 data 2323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323252325252523232323232323232323232323232323232323232323232323232323232323232323232525252323232323232323232323232323232323232323232323232323232323232323232323232323232323
1 '22030 data 2323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323252525232323232323232323232323232323232323232323232525232323232323232323232323232323232525252325252523232323232525232323232523232323232323232323232323232323232323232323232525252325232323232323232323232323232323232323232323232323232323232323232323232323232323
1 '22040 data 2323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323252525252525232323232323232323232323232323232323232523232525252523232323232323232323232525232525252325252523232323232525232525252523232523232323232323232323232323232323232325252525252325252523232323232323232323232323232323232323232325252323232323232323232323252525
1 '22050 data 2323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323252525252525252323232323232323232323232323232323252523232525252523232323232323232323252525232525252325252523252525232525232525252523232525232323232323232323232323232323232325252525252325252525232323232323232323232323232323232525232325252323232525232323232323252525
1 '22060 data 2323232323232323232323232323232323232323232323232323232325252323232523232323232323252523232323232323232323232323232323232323232323252523252525252525252323232323232323232323232323232523252523232525252523232323232323232323252525232525252325252523252525232525232525252523232525232523232323232323232323232323252325252525252325252525232323232323232323232323232323232525232325252323232525252323252323252525
1 '22070 data 2323232323232323232323232323232323232325252323232323232325252323252523232323232323252523232323252523252523232323232323232323232323252525252525252525252323252323232323232325252323252523252523232525252523232523232323232323252525232525252325252523252525232525232525252523232525232525232323232323232323232525252325252525252325252525232325232323232323232323252523232525232325252323232525252323252323252525
1 '22080 data 2325252323232323232323232323252523232325252323232323252525252323252523232323232525252523232323252523252523232523232325252323232525252525252525252525252323252523232325252325252323252523252523232525252523232525232323252523252525232525252325252523252525232525232525252523232525232525232323232323232323232525252325252525252325252525232325252323232323232525252523232525232325252323232525252323252323252525
1 '22090 data 2325252323252523232323232323252523252525252323232323252525252323252523232323232525252523252523252523252523232523232325252323232525252525252525252525252323252523232325252325252323252523252523232525252523232525232525252523252525232525252325252523252525232525232525252523232525232525232323232323252523252525252325252525252325252525232325252323252523232525252523232525232325252323232525252323252323252525
1 '22100 data 2325252323252523232323232323252523252525252323232525252525252323252523252523232525252523252523252523252523232523232325252323232525252525252525252525252323252523232325252325252323252523252523252525252523232525232525252523252525232525252325252523252525232525232525252523232525232525232325232323252523252525252325252525252325252525232325252323252523232525252523232525232325252323232525252323252323252525
1 '22110 data 2325252323252525232323232525252523252525252323232525252525252323252523252523232525252523252523252523252525252523232325252323232525252525252525252525252323252523232325252325252323252523252523252525252523232525232525252523252525232525252325252523252525232525232525252523232525232525232325252523252523252525252325252525252325252525232325252323252523232525252523232525232325252323232525252323252323252525
1 '22120 data 2525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525
1 '22130 data 2121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121
1 '22140 data 2121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121
1 '22150 data 2121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121

 
1 'En este archivo se cargar los sprites y el tileset
    1'Ponemos todos los sprites en la posición y 212 (abajo)
    9000 for i=0 to 31: put sprite i,(0,212),0,0:next i
    1 'Rutina cargar sprites en VRAM con datas basic'
    1 '9000 for i=0 to 5:sp$=""
    1 '    9220 for j=0 to 31
    1 '        9230 read a$
    1 '        9240 sp$=sp$+chr$(val(a$))
    1 '    9250 next J
    1 '    9260 sprite$(i)=sp$
    1 '9270 next i
    9010 'call turbo on
    9020 for i=0 to (32*6)-1
        9030 read b:vpoke 14336+i,b
    9040 next i
    9050 'call turbo off

    9360 data 0,0,0,0,33,195,192,192
    9370 data 192,63,63,62,96,160,240,240
    9380 data 0,0,0,224,208,252,108,112
    9390 data 240,240,240,240,248,102,54,48
    9400 rem data definition sprite 1, name: Sprite-1
    9410 data 0,0,0,0,0,0,240,112
    9420 data 48,15,15,15,15,5,6,6
    9430 data 0,0,240,120,116,31,27,28
    9440 data 60,252,252,188,48,176,176,248

    9445 data 0,0,0,7,11,63,54,14
    9450 data 15,15,15,15,31,102,108,12
    9460 data 0,0,0,0,132,194,2,2
    9470 data 2,252,252,124,6,4,14,14
    9480 rem data definition sprite 3, name: Sprite-3
    9490 data 0,0,15,30,46,248,216,56
    9500 data 60,63,63,61,12,13,13,31
    9510 data 0,0,0,0,0,0,14,14
    9520 data 12,240,240,240,240,160,96,96
    9530 rem data definition sprite 4, name: Sprite-3
    9540 data 0,0,7,15,31,7,3,3
    9550 data 3,7,15,15,15,6,6,15
    9560 data 0,0,192,224,240,192,128,128
    9570 data 128,192,224,224,224,192,192,224
    9580 rem data definition sprite 5, name: Sprite-3
    9590 data 0,0,7,15,31,7,3,3
    9600 data 19,15,15,15,15,12,16,0
    9610 data 0,0,192,224,240,192,128,128
    9620 data 144,224,224,224,224,192,32,0
   
9990 return 

1 'En screen 2'
    10000 'call turbo on
    1 'Ponemos que en la parte del mapa solo se vea el ultimo tile, dejamos el 3 tercio sin tocar para el marcador
    1 'en realidad la tabla de nombres son 768 bytes'
    10005 FOR t=6144 TO (6144+768)-256
        10010 vpoke t,255
    10020 next t


    1' Hay que recordar la estructura de la VRAM, el tilemap se divide en 3 zonas
    1 'Nuestro tileset son X tiles o de 0 hasta el X-1'
    1 'Definiremos a partir de la posición 0 de la VRAM 18 tiles de 8 bytes'
    10030 restore 10040:FOR I=0 TO (79*8)-1
        10035 READ A$
        10036 VPOKE I,VAL("&H"+A$)
        10037 VPOKE 2048+I,VAL("&H"+A$)
        1 '10042 VPOKE 4096+I,VAL("&H"+A$)
    10038 NEXT I




    10040 DATA E7,40,20,7E,3C,18,00,00
    10050 DATA 18,3C,3C,18,00,56,56,74
    10060 DATA 00,06,0A,14,20,30,48,00
    10070 DATA 00,00,00,08,10,20,40,00
    10080 DATA 00,00,00,18,2C,2C,18,00
    10090 DATA 00,18,3C,42,42,42,42,00
    10100 DATA 04,08,18,3C,3C,3C,3C,00
    10110 DATA 00,3E,22,3E,00,08,08,00
    10120 DATA 08,14,2A,08,08,08,08,00
    10130 DATA 00,04,02,7D,02,04,00,00
    10140 DATA 00,20,40,BE,40,20,00,00
    10150 DATA 10,10,10,54,28,10,00,00
    10160 DATA 00,00,00,00,00,00,00,00
    10170 DATA 00,00,00,00,00,00,00,00
    10180 DATA 00,00,00,00,00,00,00,00
    10190 DATA 00,00,00,00,00,00,00,00
    10200 DATA 00,00,00,00,00,00,00,00
    10210 DATA 00,00,00,00,00,00,00,00
    10220 DATA 00,00,00,00,00,00,00,00
    10230 DATA 00,00,00,00,00,00,00,00
    10240 DATA 00,00,00,00,00,00,00,00
    10250 DATA 00,00,00,00,00,00,00,00
    10260 DATA 00,00,00,00,00,00,00,00
    10270 DATA 00,00,00,00,00,00,00,00
    10280 DATA 00,00,00,00,00,00,00,00
    10290 DATA 00,00,00,00,00,00,00,00
    10300 DATA 00,00,00,00,00,00,00,00
    10310 DATA 00,00,00,00,00,00,00,00
    10320 DATA 00,00,00,00,00,00,00,00
    10330 DATA 00,00,00,00,00,00,00,00
    10340 DATA 44,44,EE,EE,44,44,44,44
    10350 DATA 00,00,00,00,00,00,00,00
    10360 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10370 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10380 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10390 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10400 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10410 DATA FF,FF,52,00,10,24,00,00
    10420 DATA FF,FF,52,00,08,20,00,00
    10430 DATA 54,38,10,10,10,10,10,10
    10440 DATA FF,00,7E,00,24,00,24,00
    10450 DATA 7E,24,24,24,24,24,24,24
    10460 DATA 7E,00,24,00,24,18,00,00
    10470 DATA 24,81,FF,00,00,00,00,00
    10480 DATA 12,8A,A8,A0,A0,80,80,00
    10490 DATA 51,00,00,00,00,00,00,00
    10500 DATA 51,00,00,00,00,00,00,00
    10510 DATA 54,55,15,05,05,01,01,00
    10520 DATA 00,00,00,00,00,00,00,00
    10530 DATA FF,00,3F,00,1F,00,07,00
    10540 DATA FF,00,FF,00,FF,00,FF,00
    10550 DATA FF,00,FC,00,F8,00,E0,00
    10560 DATA 00,00,00,00,00,00,00,00
    10570 DATA 00,00,00,00,00,00,00,00
    10580 DATA 00,00,00,00,00,00,00,00
    10590 DATA 00,00,00,00,00,00,00,00
    10600 DATA 00,00,00,00,00,00,00,00
    10610 DATA 00,00,00,00,00,00,00,00
    10620 DATA 00,00,00,00,00,00,00,00
    10630 DATA 00,00,00,00,00,00,00,00
    10640 DATA 00,00,00,00,00,00,00,00
    10650 DATA 00,00,00,00,00,00,00,00
    10660 DATA 00,00,00,00,00,00,00,00
    10670 DATA 00,00,00,00,00,00,00,00
    10680 DATA FB,FB,00,DF,DF,00,FB,FB
    10690 DATA DF,DF,00,FB,FB,00,00,FB
    10700 DATA 00,DF,DF,00,FB,FB,00,DF
    10710 DATA FB,00,DF,DF,00,FB,FB,FB
    10720 DATA 00,F7,F7,F7,00,7F,7F,7F
    10730 DATA 00,F7,F7,F7,00,7F,7F,7F







    1 'Definición de colores, los colores se definen a partir de la dirección 8192/&h2000'
    1 'Como la memoria se divide en 3 bancos, la parte de arriba en medio y la de abajo hay que ponerlos en 3 partes'
    13000 restore 17740:FOR I=0 TO (79*8)-1
        13010 READ A$
        13020 VPOKE 8192+I,VAL("&H"+A$): '&h2000'
        13030 VPOKE 10240+I,VAL("&H"+A$): '&h2800'
        1 'rem 13040 VPOKE 12288+I,VAL("&H"+A$): ' &h3000'
    13050 NEXT I


    
   
    17740 DATA 81,F8,F8,81,81,81,81,81
    17750 DATA B1,B1,B1,B1,B1,81,81,81
    17760 DATA 81,E1,E1,E1,61,61,61,61
    17770 DATA 61,61,61,61,61,61,61,61
    17780 DATA 61,61,61,21,21,21,21,21
    17790 DATA 21,21,21,2C,2C,2C,2C,11
    17800 DATA D1,D1,91,91,91,91,D1,D1
    17810 DATA D1,B1,B1,B1,B1,A1,A1,A1
    17820 DATA 81,81,81,81,81,81,81,81
    17830 DATA 81,81,81,81,81,81,81,81
    17840 DATA 81,81,81,81,81,81,81,81
    17850 DATA 81,81,81,81,81,81,81,81
    17860 DATA 81,81,81,81,81,81,81,81
    17870 DATA 81,81,81,81,81,81,81,81
    17880 DATA 81,81,81,81,81,81,81,81
    17890 DATA 81,81,81,81,81,81,81,81
    17900 DATA 81,81,81,81,81,81,81,81
    17910 DATA 81,81,81,81,81,81,81,81
    17920 DATA 81,81,81,81,81,81,81,81
    17930 DATA 81,81,81,81,81,81,81,81
    17940 DATA 81,81,81,81,81,81,81,81
    17950 DATA 81,81,81,81,81,81,81,81
    17960 DATA 81,81,81,81,81,81,81,81
    17970 DATA 81,81,81,81,81,81,81,81
    17980 DATA 81,81,81,81,81,81,81,81
    17990 DATA 81,81,81,81,81,81,81,81
    18000 DATA 81,81,81,81,81,81,81,81
    18010 DATA 81,81,81,81,81,81,81,81
    18020 DATA 81,81,81,81,81,81,81,81
    18030 DATA 81,81,81,81,81,81,81,81
    18040 DATA B1,A1,A1,A1,81,81,81,81
    18050 DATA 81,81,81,81,81,81,81,81
    18060 DATA 91,91,91,91,91,91,91,91
    18070 DATA 31,31,31,31,31,31,31,31
    18080 DATA 71,71,71,71,71,71,71,71
    18090 DATA B1,B1,B1,B1,B1,B1,B1,B1
    18100 DATA E1,E1,E1,E1,E1,E1,E1,E1
    18110 DATA 21,21,23,23,23,23,23,23
    18120 DATA 91,91,9E,9E,9E,9E,9E,9E
    18130 DATA 91,61,61,61,61,61,61,61
    18140 DATA 91,91,61,61,61,61,61,61
    18150 DATA 91,61,61,61,61,61,61,61
    18160 DATA 91,91,61,61,61,61,61,61
    18170 DATA 79,91,91,91,91,91,91,91
    18180 DATA 75,51,51,51,51,51,51,51
    18190 DATA 75,11,11,11,11,11,11,11
    18200 DATA 35,11,11,11,11,11,11,11
    18210 DATA 75,51,51,51,51,51,51,51
    18220 DATA 51,51,51,51,51,51,51,51
    18230 DATA 51,51,51,51,51,51,51,51
    18240 DATA 51,51,51,51,51,51,51,51
    18250 DATA 51,51,51,51,51,51,51,51
    18260 DATA 51,51,51,51,51,51,51,51
    18270 DATA 51,51,51,51,51,51,51,51
    18280 DATA 51,51,51,51,51,51,51,51
    18290 DATA 51,51,51,51,51,51,51,51
    18300 DATA 51,51,51,51,51,51,51,51
    18310 DATA 51,51,51,51,51,51,51,51
    18320 DATA 51,51,51,51,51,51,51,51
    18330 DATA 51,51,51,51,51,51,51,51
    18340 DATA 51,51,51,51,51,51,51,51
    18350 DATA 51,51,51,51,51,51,51,51
    18360 DATA 51,51,51,51,51,51,51,51
    18370 DATA 51,51,51,51,51,51,51,51
    18380 DATA E1,E1,E1,A1,A1,A1,E1,E1
    18390 DATA E1,E1,E1,A1,A1,A1,A1,A1
    18400 DATA A1,81,81,81,51,51,51,81
    18410 DATA 81,81,51,51,51,81,81,81
    18420 DATA 81,81,81,81,81,81,81,81
    18430 DATA 81,51,51,51,51,51,51,51
    18440 DATA 51,31,31,31,31,31,31,31
    18450 DATA E1,51,E1,51,E1,51,E1,51
    18460 DATA E1,51,E1,51,E1,51,E1,51
    18470 DATA E1,FE,FE,FE,FE,FE,FE,FE
    18480 DATA A1,EA,EA,EA,EA,EA,EA,EA
    18490 DATA F1,FE,FE,FE,FE,FE,FE,FE
    18500 DATA 11,11,11,11,11,11,11,11
    18510 DATA 11,11,11,11,11,11,11,11
    18520 DATA 11,11,11,11,11,11,11,11
    18530 DATA 11,11,11,11,11,11,11,11



    19000 'call turbo off
19990 return


1 '14336 / h3800 -> 16383 / 3fff
1 '(tamaño 2048 / h800)
1 'Tabla de patrones de sprites
    1 'En vasic base(14)
    1 'Aquí es donde se ponen los 8 bytes que componen tu sprite para definir su dibujo, con la
    1 'ayuda de la “tabla atributos de sprites” llamaremos a este bloque y le podremos su
    1 'posición en pantalla.


1 '12288 / h3000 -> 14335 / h37ff
1 'Tamaño: 2048 / h0800
1 'Tabla color tiles banco 2
    1 'Aquí se definen los bloques de 8 bytes que definen el color de los tiles definidos en la
    1 '“tabla tiles banco 2” la tabla que representa a la parte superior de la pantalla
1 '10240 / h2800 -> 12287 / h2fff
1 'Tamaño: 2048 / h0800
1 'Tabla color tiles banco 1
    1 'Aquí se definen los bloques de 8 bytes que definen el color de lostiles definidos en la
    1 '“tabla tiles banco 1” la tabla que representa a la parte central de la pantalla
1 '8192 / h2000 ->10239 / h27ff
1 'Tamaño: 2048/ h0800
1 'Tabla color tiles banco 0
    1 'En basic base (11)
    1 'Aquí se definen los bloques de 8 bytes que definen el color de los tiles definidos en la
    1 '“tabla tiles banco 0” la tabla que representa a la parte inferior de la pantalla


1 'h1800 vacía
1 '6912 /h1b00 -> 7039 / h1b7f
1 'Tamaño 128 /h0080
1 'Tabla de atributos de Sprite (AOM)
    1 'En basic base(13)
    1 'Cada “atributo de Sprite” son 8 bytes que definen su bloque de 32 bits de la tabla
    1 '“patrones de sprite”,su posición x, y, color (los colores del sprite no tienen nada que ver
    1 'con los tiles)


1 '6144 / h1800 -> 6911 / h1aff
1 'Tamaño 768 / h0300
1 'Tabla mapa o nombres de tiles
    1 'En basic base(10)
    1 'Aquí es donde se pone el bloque de bytes que corresponde con el tile definido en la tabla
    1 '“tiles banco 0,1,2”


1 '4096 / h1000 -> 6148 /h17ff
1 'Tamaño: 2048 / h0800
1 'Tabla tiles banco 2
    1 'Lo mismo que banco 0 y banco 1 pero para el banco 2
1 '2048 / h0800 -> 4095 / h0fff
1 'Tamaño: 2048 /h0800
1 'Tabla tiles banco 1
    1 'Lo mismo que el tiles banco 0 pero para el banco 1
1 '0 / h0000 -> 2047 / h07ff
1 'Tamaño: 2048/h0800
1 'Tabla tiles banco 0
    1 'En basic base(12)
    1 'Aquíse definen los bloques de 8 bytes que definen 1 tile para la parte superior de la
    1 'pantalla de las 3 partes que tiene la pantalla (ejemplo 1) Este tile estará relacionado con
    1 'los 8 bytes del “Color tiles banco 0” y con la “tabla mapa” 








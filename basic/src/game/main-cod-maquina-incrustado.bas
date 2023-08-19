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


105 gosub 3330:DEFUSR=62000:A=USR(0)
1 'El interval on es para mostrar el tiempo'
110 me$="":'ON INTERVAL=50 GOSUB 21000
120 f=1:ts=37:td=30:mc=0:ml=60:dim m(100,16)
1 'inicializamos el array con el mapa de tiles'
125 gosub 20200
1 'Mostramos la pantalla de bienvenida'
130 gosub 1800
140 x=0:y=9*8:v=8:P=0:P0=0:P1=1:P2=2:P3=3:P4=4:P5=5:PUTSPRITE0,(x,y),4,p
150 time=0:tw=0
160 goto 500

200 'Main loop'
    1 '200 s=STICK(0)ORSTICK(1)
    1 '1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    1 '210 ON s GOTO 230,250,270,290,310,330,350,370
    1 '220 goto 400
    1 '1 'movimiento hacia arriba o salto
    1 '230 Y=Y-4
    1 '1 '1 Pulsado la tecla 1 Saltamos y reproducimos un sonido'
    1 '1 '230 if a=0 and t5>=ts then o=y:a=1:GOTO 210
    1 '240 GOTO 400
    1 '1 '2 Pulsado 2 movimiento hacia arriba derecha o salto hacia arriba'
    1 '250 X=X+4:if a=0 and t5>=ts then o=y:a=1
    1 '1 ' ponemos el sprite 0 o 1 que corresponde a los de la derecha'
    1 '260 P=P0:SWAPP0,P1:GOTO 400
    1 '1 '3 pulsado Movimiento hacia la derecha '
    1 '270 X=X+v
    1 '280 P=P0:SWAPP0,P1:GOTO 400
    1 '1 '4 Movimiento abajo derecha'
    1 '290 X=X+v
    1 '300 P=P0:SWAPP0,P1:GOTO 400
    1 '1 '5 Movimiento  abajo'
    1 '310 Y=Y+4
    1 '320 P=P0:SWAPP0,P1:GOTO 400
    1 '1 '6 Moviemiento abajo izquierda'
    1 '330 'Y=Y+4:X=X-4
    1 '340 P=P2:SWAPP2,P3:GOTO 400
    1 '1 '7 Movimiento izquierd'
    1 '350 X=X-v
    1 '360 P=P2:SWAPP2,P3:GOTO 400
    1 '1 '8 movimiento arriba izquierda'
    1 '370 X=X-v:if a=0 and t5>=ts then o=y:a=1
    1 '380 P=P2:SWAPP2,P3
    1 '400 PUTSPRITE0,(X,Y),4,P
    400 A=USR(0)
    420 gosub 21000
    490 ON f GOSUB 530,630,730,930,1130,1330,1530
500 goto 200





1 'Fase 1'
1'--------
1 'se pinta el mapa de tiles y se inicializa'
500 time=0
501 'gosub 21000
1 'Activamos las interrupciones de intervalo para mostrar el tiempo'
503 'interval on
510 'se inicializan os enemigos, se pintan los objetos y el marcador
520 goto 200
530 if mc=ml then print #1, "fase completada": goto 1800
540 'pintamos los enemigos
550 'Actualizamos los enemigos
590 RETURN














1 ' menu principal'
    1800 me$="^menu pricipal, pulse una tecla":gosub 2000
    1810 ON STRIG gosub 1890:STRIG(0)ON
    1820 GOTO 1820
1890 STRIG(0)OFF:RETURN 140


1 'HUD'
    2000 line(0,140)-(255,150),1,bf
    2010 preset (0,140):print #1,me$
20 'na'

1 'Input system & render in assembler'
3330 REM 'cacolo'
    3340 RESTORE 3400
    1 '62000=#f230'
    3350 PK#=62000
    3360 READ A$:IF A$="#" THEN 3440
    3370 POKE PK#,VAL("&H"+A$)
    3380 PK#=PK#+1
    3390 GOTO 3360
    1 'AF                      xor a
    1 'CD D5 00                call GTSTCK
    1 'FE 01                   cp 1
    1 'CC 58 F2                call z, mover_personaje_arriba
    1 'FE 03                   cp 3
    1 'CC A8 F2                call z, mover_personaje_derecha
    1 'FE 05                   cp 5
    1 'CC 80 F2                call z, mover_personaje_abajo
    1 'FE 07                   cp 7
    1 'CC D0 F2                call z, mover_personaje_izquierda
    1 'C9                      ret 
    3400 DATA AF,CD,D5,00,FE,01,CC
    3410 DATA 58,F2,FE,03,CC,A8,F2
    3420 DATA FE,05,CC,80,F2,FE,07
    3430 DATA CC,D0,F2,C9,# 
    1 'Rutinas mover y dibujar arriba'
    1 '62040=#f258'
    3440 PK#=62040!
    3460 READ A$:IF A$="#" THEN 3540
    3470 POKE PK#,VAL("&H"+A$)
    3480 PK#=PK#+1
    3490 GOTO 3460
    1 'Donde ver las subrrutinas bios?: http://map.grauw.nl/resources/msxbios.php
    1 '21 00 1B                ld hl, #1b00 ;Start address of VRAM
    1 'CD 4A 00                call #004a ;subrrutina bios RDVRM (lee el contenido de laVRAM),necesuta en hl la dirección de la VRAM a leer y retorna en a el valor
    1 'D6 08                   sub 8;restamos 8 al registro a
    1 'CD 4D 00                call #004d; subrrutina bios WRTVRM (escribe datos en VRAM), necesita en hl la driección a escribir en VRAMy en a el valor
    1 'C9                      ret
    3500 DATA 21,00,1B,CD,4A,00,D6,08
    3510 DATA CD,4D,00,C9,#
    1 'Rutina mover y dibujar abajo'
    1 '62080=#F280'
    3540 PK#=62080!
    3550 READ A$:IF A$="#" THEN 3630
    3560 POKE PK#,VAL("&H"+A$)
    3570 PK#=PK#+1
    3580 GOTO 3550
    1 'C6 08                    add 8'
    3590 DATA 21,00,1B,CD,4A,00,C6,08
    3600 DATA CD,4D,00,C9,#
    1 'Rutina mover y dibujar derecha'
    1 '62120=#F2a8'
    3630 PK#=62120!
    3640 READ A$:IF A$="#" THEN 3720
    3650 POKE PK#,VAL("&H"+A$)
    3660 PK#=PK#+1
    3670 GOTO 3640
    3680 DATA 21,01,1B,CD,4A,00,C6,08
    3690 DATA CD,4D,00,C9,#
    1 'Rutina mover y dibujar izquierda'
    1 '62160=#F2d0'
    3720 PK#=62160!
    3730 READ A$:IF A$="#" THEN 3790
    3740 POKE PK#,VAL("&H"+A$)
    3750 PK#=PK#+1
    3760 GOTO 3730
    3770 DATA 21,01,1B,CD,4A,00,D6,08
    3780 DATA CD,4D,00,C9,#
3790 RETURN







1 'Compresión RLE-16'
    20200 restore 22000
    20205 for r=0 to 15
        20210 READ mp$:po=0
        20220 for c=0 to len(mp$) step 4
            1 'El 1 valor indica la cantidad de repeticiones, el 2 el valor en si'
            20230 r$=mid$(mp$,c+1,2)
            20240 tn$=mid$(mp$,c+3,2)
            20250 tn=val("&h"+tn$):tn=tn-1
            20260 re=val("&h"+r$)
            20270 for i=0 to re
                20280 if tn<>0 and tn<>-1 then m(po,r)=tn:po=po+1
            20300 next i
        20310 next c
    20320 next r
20330 return

1 'ponemos en la tabla nombres los tiles
    21000 _TURBO ON (m(),mc)
    21001 restore 22000
    21002 mc=mc+1
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


    22000 data 1b230125022300250623012515230125002306250e2300250023012501230325
    22010 data 1223012506230125012301250623012503230125002301250c2309250123002506230125012301250023012501230325
    22020 data 002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b25012301250223012500230125012301250023012501230325
    22030 data 00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325
    22040 data 0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012500230425
    22050 data 00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500230425
    22060 data 6325
    22070 data 6321
    22080 data 41210045142100470a21
    22090 data 1d21234800450221114800470a21
    22100 data 1d2100480d210048132100450221004810210047072101480021
    22110 data 02211b480d210e4809211c480021
    22120 data 1d2100480b2100460e2100480921004805210047122101480021
    22130 data 1d2100480821024800460e21114800471521
    22140 data 1d210a4801210046202100471521
    22150 data 4c2100471521

23190 return 
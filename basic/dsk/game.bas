10cls:color15,1,1:keyoff
20defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0):defusr3=&h41:defusr4=&h44
30screen2,2,0
40definta-z
50open"grp:"as#1
60 me$="Loading sprites":gosub 2000
70gosub9000
75gosub19000
80 me$="Loading tileset":gosub 2000
90gosub10000
100dimm(120,16):dimx(3):dimy(3):dimv(3):dimc(3):dimp(3)
110f=0:sc=1:sl=7:td=48:tm=6:tf=32:n=0:w=88:t0=0
120x=0:y=9*8:v=8:h=8:l=9:s=0:p=0:p0=0:p1=1:p2=2:p3=3:p4=4:p5=5
122e1=8:e2=9:e3=10:e4=11:e5=12:e6=13
125restore21000:gosub20200
130gosub20800
135 me$="Main menu, press space key":gosub 2100
140gosub20200
145fori=0to31:vpoke6656+i,39:nexti
150VPOKE6688,39:VPOKE6719,39:VPOKE6720,39:VPOKE6751,39:VPOKE6752,39:VPOKE6783,39
155VPOKE6690,0
160VPOKE6696,1
165VPOKE6702,2
170fori=0to31:vpoke6784+i,39:nexti
175gosub2200
190putsprite0,(x,y),15,p
195mu=7:gosub4000
196gosub20800
197 me$="Press space key to start":gosub 2100
198ONSPRITEGOSUB3000:spriteon
199gosub6000
200j=STICK(0)ORSTICK(1)
210ONjGOTO230,250,270,290,310,330,350,370
220p=p0:ifn<wthenswapp0,p1:goto400elsegoto400
230y=y-h:o=o-8:p=p4:swapp4,p5:goto400
250x=x+v:o=o-8:y=y-h:p=p0:swapp0,p1:goto400
270x=x+v:p=p0:swapp0,p1:goto400
290x=x+v:o=o+8:y=y+h:p=p0:swapp0,p1:goto400
310y=y+h:o=o+8:p=p4:swapp4,p5:goto400
330x=x-v-4:o=o+8:y=y+h:p=p2:swapp2,p3:goto400
350x=x-v-4:p=p2:swapp2,p3:goto400
370x=x-v-4:o=o-8:y=y-h:p=p2:swapp2,p3:goto400
400ifa=0thengoto500
410ifo>104theno=104elseifo<48theno=48:a=2:o=o-8
420ify>othena=2elseifa=1theny=y-8
430ify<o-16thena=2
440ifa=2theny=y+8:ify>=othena=0:PUTSPRITE1,(0,212),1,7
450ifa>0thenPUTSPRITE1,(x,o),1,7
500IFy<48THENy=48elseify>112theny=112
510ifx<0thenx=0elseifx>250thenx=250
520PUTSPRITE0,(X,Y),15,P
530px=x/8:py=y/8
540t0=m(px+1+n,py+1)
550ift0>=tdanda=0thengosub3000
560ift0=tmthenmu=6:gosub4000:PUTSPRITE0,(X,Y),8,6:fori=0to300:nexti:m(px+1+n,py+1)=tf:s=s+10:gosub2200
570ifn=wthenfori=0to50:nexti
580ifn=wandx>240thengosub20000
590ifnmod10=0andn<wthengosub20500
600ifn<wthenn=n+1:gosub20600
610ifsc=2orsc=4orsc=6thengoto690
620ifn>c(0)andn<c(0)+25thenp(0)=e1:swape1,e2:putsprite2,(x(0),y(0)),1,p(0):x(0)=x(0)-v(0):goto690
630ifn>c(1)andn<c(1)+25thenp(1)=e3:swape3,e4:putsprite2,(x(1),y(1)),2,p(1):x(1)=x(1)-v(1):goto690
640ifn>c(2)andn<c(2)+25thenp(2)=e5:swape5,e6:putsprite2,(x(2),y(2)),3,p(2):x(2)=x(2)-v(2)
690goto200
2000line(0,170)-(255,180),6,bf
2010preset(0,170):?#1,me$
2090return
2100line(0,170)-(255,180),6,bf
2110preset(0,170):?#1,me$
2120ifstrig(0)=-1then2180else2120
2180line(0,170)-(255,180),6,bf
2190return
2200vpoke6722,48+l
2230vpoke6728,48+sc
2240s$=str$(s)
2250ls=len(s$)
2260fori=1tols-1
2270vpoke6733+i,48+val(mid$(s$,i+1,1))
2280nexti
2290return
3000'playermuere'
3010mu=5:gosub4000:a=0:spriteoff:strig(0)off
3020fori=0to1000:nexti
3030x=0:y=9*8:PUTSPRITE0,(X,Y),15,0
3035fori=0to2:putsprite2+i,(x(i),y(i)),0,0
3040l=l-1:gosub2200
    3050 if l<=0 then put sprite 0,(0,212),15,p:gosub 19000:me$="Game over":gosub 2100:goto 110
    3060 if sc=2 or sc=4 or sc=6 then strig(0) on:on strig gosub 5000:sprite off:me$="Press space to jump":gosub 2000
3070ifsc=1orsc=3orsc=5thenonscgosub6000,3017,7000,3017,8000:spriteon:strig(0)off
3080n=0:gosub20600
    3085 me$="Ready press space":gosub 2100
3090return
4000a=usr2(0)
4050ifmu=5thenplay"t255l10o3v8gc"
4060ifmu=6thensound1,0:sound6,25:sound8,16:sound12,4:sound13,9
4070ifmu=7thenplay"t255O3L8V8M8000AADFG2AAAA"
4080ifmu=8thensound1,2:sound8,16:sound12,5:sound13,9
4199return
5000ifa=0thenmu=8:gosub4000:o=y:a=1
5090return
6000x(0)=255:y(0)=72:v(0)=12:c(0)=1
6010x(1)=255:y(1)=80:v(1)=12:c(1)=34
6020x(2)=255:y(2)=64:v(2)=12:c(2)=62
6090return
7000x(0)=255:y(0)=72:v(0)=12:c(0)=1
7010x(1)=255:y(1)=64:v(1)=12:c(1)=36
7020x(2)=255:y(2)=64:v(2)=12:c(2)=58
7090return
8000x(0)=255:y(0)=64:v(0)=12:c(0)=1
8010x(1)=255:y(1)=96:v(1)=12:c(1)=38
8020x(2)=255:y(2)=64:v(2)=12:c(2)=60
8090return
20000mu=7:gosub4000:strig(0)off
20005sc=sc+1
20010PUTSPRITE0,(0,212),15,0
    20020 if sc=sl then gosub 19000:gosub 20200:gosub 20800:me$="Congratulations, final":gosub 2100:goto 110
    20030 me$="Loading next level...":gosub 2000
20040gosub20200
20050n=0:gosub20800
20070gosub2200
20075x=0:y=9*8:putsprite0,(x,y),15,p
    20080 me$="Press space key":gosub 2100
    20085 if sc=2 or sc=4 or sc=6 then strig(0) on:on strig gosub 5000:me$="Press space to jump":gosub 2000:sprite off
20086ifsc=1orsc=3orsc=5thenonscgosub6000,20086,7000,20086,8000:spriteon
20090return
20200callturboon(m())
20205forr=0to15
20210READmp$:po=0
20220forc=0tolen(mp$)step4
20230r$=mid$(mp$,c+1,2)
20240tn$=mid$(mp$,c+3,2)
20250tn=val("&h"+tn$):tn=tn-1
20260re=val("&h"+r$)
20270fori=0tore
20280m(po,r)=tn:po=po+1
20300nexti
20310nextc
20320nextr
20325callturbooff
20390return
20500_TURBOON(m(),n)
20510d=6144
20520forr=0to7
20530forc=nto31+n
20540VPOKEd,m(c,r):d=d+1
20550nextc
20560nextr
20570_TURBOOFF
20590return
20600_TURBOON(m(),n)
20610d=6432
20620forr=9to14
20630forc=nto31+n
20640VPOKEd,m(c,r):d=d+1
20650nextc
20660nextr
20670_TURBOOFF
20690return
20800_TURBOON(m())
20810d=6144
20820forr=0to15
20830forc=0to31
20840VPOKEd,m(c,r):d=d+1
20850nextc
20860nextr
20870_TURBOOFF
20890return
21000data1f23
21010data072300530059005e002300590056003b004f0054002300560058003f0059003f0054005a00590523
21020data1f23
21030data0a230052003f005500230053005b0059005a00230052004f005c003f0723
21040data0e23000b000c000d0d23
21050data0923000b000c000d0123002b002c002d0123000b000c000d0823
21060data0923002b002c002d0623002b002c002d0823
21070data1f23
21080data1f23
21090data0823000b000c000d0223000e000f00100223000b000c000d0723
21100data0823002b002c002d0223002e002f00300223002b002c002d0723
21110data1f23
21120data1f23
21130data0923000b000c000d0623000b000c000d0823
21140data0923002b002c002d0123000b000c000d0123002b002c002d0823
21150data0e23002b002c002d0d23
21200data202300251e23012500230625142303251323
21210data122301250a2301251e2309251423032500230125042301250923
21220data0d230125022301250a2301251c230b251423032500230125032302250923
21230data05230325032306250a2301251c230b251423032500230125022303250923
21240data05230e250a230a2513230b2513230425002308250923
21250data05230e250a230a2513230b2513230e250923
21260data7725
21270data7741
21280data7741
21290data06411c2100070a2101411321004102210007012102411c2100410421042a
21300data2921074113210241032102410b2105410a2100410921
21310data0b21114101210141022100410f2101410d210241032102410c210007022100410a2100410421042a
21320data06411d2100410f2101410321054103210241032102410221054107210041012109410921
21340data06411d21004105210b41032105411021014106210341002100411021042a
21350data7741
21360data7741
21400data7723
21410data322304213f23
21420data31230521172307241f23
21430data09230e2411230c2117230724102305240823
21440data092302240023002400230024002300240023042411230c211723002400230b240a23012400230024002300240823
21450data09230e240423001800190a2300210023002100230021002300210023002100230021002300210123001800190e23001a001b02230424012306240a2305240823
21460data092302240623022400250024052300150a23002100250a21022300160f23001602230024002502240123002401230024012300240a230324002500240823
21470data7742
21480data7742
21490data134203221242032200420622014206220a4203220007012200420022004206220142032202420222004202220842022a
21500data09220142052201420322014201220342012201420a2200420322044206220a42062200420022054201220142032202420222004202220b42
21510data092201420522074202221642032200420222034202220042022200420222074200220a42022202420222004202220842022a
21520data092201420522014203220142052201420b220542032200420022000700220342022200420622014202220142022200420122004a004b04220242052203420b22
21540data134203220342032201420422014c042205420322004202220342022200420222004202220142022201420222004201220048004906220042022206420b22
21550data7742
21560data7742
21600data7723
21610data1623001800195e23
21620data172300161c23001a001b072300280023002800230028002300282423001800190123001a001b0523
21630data0123001800190f2306271b2300160723062806230b2712230016022300170523
21640data0223001705230327052306250423072706230125032305270423042800020028042310210c23072104230021
21650data7727
21660data7743
21670data7743
21680data7743
21690data10210f4308210007032100431421044313210043052107430621032a
21700data0521000700210443032100431021044306210043032104430621004302210543042108430521004305210043042100430821022a
21710data08210843102100430e21064305210043032104430f210043022100430521004304210043032100430421012a
21720data04430f21004303210943132102430421004303210007002102430f2100430521002505210343032101430521
21730data04430f21004310211a430a21014304210643052100250d2102430421
21740data7743
21750data7743
22000data19230015172300180019172300171a2300160d23
22010data16230626112302260023001615230326172304260b23
22020data012610230d260b23072613230726032304260a2309260823
22030data002112260b210d26052114260621172604210a26
22040data0d210726092105260d2105260b2101260721052606210226012101261321
22050data7721
22060data09260a210326042103265521
22070data7726
22080data69420d25
22090data0a420125014201250f420b25004a004b022500420425014203250142022501420225014204250442032511420d25
22100data08250142012501420125014202250342032502420b2500480049022500420425014203250142022501420225014204250442032502420b2502420d25
22110data082501420125054202250342032502420125054202250e420125074202250b420325024203250046004705250d42022a
22120data0825014203250a4203250a420325034203250542012509420b25074203250044004505251042
22140data0a420e250e4210250042012509420b252142022a
22150data7742
22160data7742
22200data7723
22210data7723
22220data1e2301280d2301240c230128002301280023012807230128002301280a23012400230124002301240c2301280223
22230data02230024002301240023002411230228002301280d2301240c230728072304280a2307240c2301280223
22240data02230524102306280d2301240c230728072304280a2307240c2301280223
22250data02230524102306280d2301240c230728072304280a2307240c2301280223
22260data7726
22270data7742
22280data7742
22290data0d421a2102420521084202210007012101421121000700210042062103421421
22300data0a210242012100070321004204210e42152104421121004202210042022103420e21052a
22310data0a2103420521004204210e421621034205210242032105420221004203210242022108420821
22320data054204210342052101421021014205210a42062102420421034203210542022101420221024202210b42052a
22340data06420d2102421c210142152100420c21014213210642
22350data7742
22360data7742
22400data3823001c001d0b23001c001d2e23
22410data0223001c001d0923001c001d0b23002800230028202300223523
22420data1c2302280323001c001d0b2300240c2302220d230b241a23
22430data1c230228102302240b2302220c230c241a23
22440data172300280023002801230228102302240623001c001d022302220b230922032409230a240523
22450data07230028002300280023002800230028002300280623072808230828012409230022002302220b23092203240923012400430424004301240523
22460data07230828062307280823002800430128004301280043002801240823052209230b22032409230a240523
22470data072304280043022806230528004300280823082801240823032200430022092309220043002201240043002409230424004304240523
22480data7743
22490data0a43182400430224004302240043022400430224004302240343012401430c240043022400430224114304240243032400430324
22500data232400430224004302240043022400430224004302240343012401430c2400430224004309240143072400430424004301240043022400430024022a
22510data0c24324301240f430924014307240643012404430324
22520data0c2405430c24000702240e43002400070c2406430124024302240c430124094304240043022400430024022a
22540data0a430a24064306240e430e24064301240243002400070024004309240d4304240043022400430324
22550data7743
22560data7743
22600data1f23
22610data0323003e003f005c003f005200550056003f005800590b23001100120323
22620data1923001300140323
22630data07230056003f003e0058005500230055005a003b005200550058003b0a23
22640data1f23
22650data07230051004f0051003f00230053003b003e0058004f004d003b00520a23
22660data1f23
22670data2023
22680data2023
22690data2023
22700data2023
22710data2023
22720data2023
22730data2023
22740data2023
22750data2023
9000callturboon
9005fori=0to31:putspritei,(0,212),0,0:nexti
9010'callturboon
9020fori=0to(32*13)-1
9030readb:vpoke14336+i,b
9040nexti
9050callturbooff
9060data0,0,33,195,192,192,192,63
9070data63,62,96,160,240,240,0,0
9080data0,224,208,252,108,112,240,240
9090data240,240,248,102,54,48,0,0
9100data0,0,0,0,240,112,48,15
9110data15,15,15,5,6,6,0,0
9120data240,120,116,31,27,28,60,252
9130data252,188,48,176,176,248,0,0
9140data0,7,11,63,54,14,15,15
9150data15,15,31,102,108,12,0,0
9160data0,0,132,194,2,2,2,252
9170data252,124,6,4,14,14,0,0
9180data15,30,46,248,216,56,60,63
9190data63,61,12,13,13,31,0,0
9200data0,0,0,0,14,14,12,240
9210data240,240,240,160,96,96,0,0
9220data3,7,15,1,3,3,11,15
9230data7,7,3,7,13,1,0,0
9240data192,224,240,128,192,192,208,240
9250data224,224,192,224,176,128,0,0
9260data1,7,7,7,1,3,3,3
9270data7,15,11,7,9,1,0,0
9280data128,224,224,224,128,192,192,192
9290data224,240,208,224,144,128,0,0
9300data0,0,0,0,0,0,127,255
9310data255,190,99,163,243,243,0,0
9320data0,0,0,0,0,56,190,223
9330data253,55,159,70,102,96,0,0
9340data0,0,0,0,0,0,0,0
9350data0,0,31,255,255,127,0,0
9360data0,0,0,0,0,0,0,112
9370data248,240,248,255,255,252,0,0
9380data3,11,7,1,3,18,19,31
9390data7,3,3,3,7,6,14,14
9400data192,192,192,64,192,194,198,248
9410data224,192,192,192,224,96,96,224
9420data0,0,3,11,7,1,3,3
9430data2,3,7,31,2,9,7,7
9440data0,0,192,192,192,64,192,64
9450data64,224,224,64,192,192,224,120
9460data3,3,3,17,19,18,55,63
9470data19,19,19,19,7,6,14,14
9480data224,240,192,64,192,192,192,224
9490data224,224,224,192,224,96,96,224
9500data0,11,11,11,17,51,59,38
9510data39,35,35,67,67,71,6,7
9520data0,224,240,192,64,196,72,80
9530data224,192,192,192,192,224,96,112
9540data0,0,1,3,6,9,1,3
9550data7,9,1,3,7,14,1,3
9560data0,0,192,224,176,200,64,224
9570data240,200,192,224,240,56,64,96
9990return
10000callturboon
10030restore10040:FORI=0TO(95*8)-1
10035READA$
10036VPOKEI,VAL("&H"+A$)
10037VPOKE2048+I,VAL("&H"+A$)
10038VPOKE4096+I,VAL("&H"+A$)
10039NEXTI
10040DATAE7,40,20,7E,3C,18,00,00
10050DATA00,18,3C,42,42,42,42,00
10060DATA24,FE,A4,7E,25,25,7F,24
10070DATA18,3C,3C,3C,3C,3C,3C,3C
10080DATA00,00,00,00,00,00,00,00
10090DATA00,00,00,00,00,00,00,00
10100DATAFF,FF,C3,81,C2,C3,C3,00
10110DATA18,3C,3C,18,00,56,56,74
10120DATA00,7C,44,7C,00,10,10,00
10130DATA00,04,08,18,3C,3C,3C,3C
10140DATA01,07,0F,0F,1F,3E,9C,3E
10150DATAC3,81,3C,18,18,3C,18,3C
10160DATA80,E0,F0,F0,F8,7C,39,7C
10170DATAFF,07,1E,3C,3C,3C,20,08
10180DATA00,00,00,00,00,C3,C3,00
10190DATA00,E0,78,3C,3E,1C,18,10
10200DATA18,D2,D6,1F,0F,0F,07,07
10210DATA0C,4B,3B,27,8F,F0,E0,E0
10220DATA01,01,01,03,07,07,07,07
10230DATA80,80,C0,C0,E0,E0,F0,F0
10240DATAC0,E0,20,20,30,10,FF,34
10250DATA60,60,60,78,FC,FE,10,6A
10260DATA78,08,38,40,30,30,31,35
10270DATA07,0F,0F,07,1F,1F,00,00
10280DATAF0,C0,E0,F0,FC,F8,E0,60
10290DATAE2,C1,D0,C0,C0,F8,FF,FF
10300DATA0F,87,4F,07,07,0F,E0,60
10310DATA00,03,3F,37,82,80,FC,FF
10320DATAFF,3C,00,18,00,0C,DF,FF
10330DATAFF,CF,07,47,07,1F,3F,FF
10340DATAFF,E7,C3,A3,B1,83,FF,FF
10350DATAFF,FF,F3,E4,C2,80,E5,FF
10360DATAFF,FF,FF,FF,FF,FF,FF,FF
10370DATAFF,FF,FF,FF,FF,FF,FF,FF
10380DATAFF,FF,FF,FF,FF,FF,FF,FF
10390DATAFF,FF,FF,FF,FF,FF,FF,FF
10400DATAFF,FF,FF,FF,FF,FF,FF,FF
10410DATAFF,FF,52,00,10,24,00,00
10420DATAFF,FF,52,00,08,20,00,00
10430DATA6D,DB,DB,6D,6D,DB,DB,6D
10440DATA6D,DB,DB,6C,6C,DB,DB,6C
10450DATAFF,04,02,7D,02,04,00,00
10460DATAE2,E1,7E,C1,E0,F0,F8,FF
10470DATA81,81,00,00,BD,FF,FF,FF
10480DATAC7,78,81,83,07,0F,3F,FF
10490DATAFF,FF,02,01,00,00,00,00
10500DATA3C,3C,04,18,3C,3C,3C,00
10510DATA00,20,00,00,00,00,00,00
10520DATA00,38,44,4C,10,64,44,38
10530DATA00,0C,04,04,00,04,04,04
10540DATA00,38,04,04,38,40,40,78
10550DATA00,38,04,04,38,04,04,38
10560DATA00,44,44,44,38,04,04,04
10570DATA00,38,40,40,38,04,04,38
10580DATA00,38,40,40,38,44,44,38
10590DATA00,38,04,04,00,04,04,04
10600DATA00,38,44,44,38,44,44,38
10610DATA00,38,44,44,38,04,04,38
10620DATA00,1C,22,22,1C,22,22,22
10630DATA00,3C,22,22,1C,22,22,3C
10640DATA00,1C,20,20,00,20,20,1C
10650DATA00,3C,22,22,00,22,22,3C
10660DATA00,3C,20,20,1C,20,20,3C
10670DATA00,3C,20,20,1C,20,20,20
10680DATAFF,FF,FF,FF,FF,FF,FF,FF
10690DATAFF,FF,FF,FF,FF,FF,FF,FF
10700DATAFF,FF,FF,FF,FF,FF,FF,FF
10710DATAC0,F8,07,02,01,00,00,00
10720DATA01,01,87,FA,FA,AD,79,01
10730DATA00,00,00,00,00,03,C2,F5
10740DATA00,00,A8,F8,86,7A,7D,85
10750DATA00,04,02,01,77,F7,FF,80
10760DATA58,28,0C,9C,02,FF,FE,FE
10770DATA0F,07,0F,0F,0F,1F,1F,10
10780DATA80,C0,E0,B0,60,70,78,B8
10790DATA22,22,77,77,22,22,22,22
10800DATA00,38,40,40,0C,44,44,38
10810DATA00,44,44,44,38,44,44,44
10820DATA00,10,10,10,00,10,10,10
10830DATA00,04,04,04,00,44,44,38
10840DATA00,44,48,50,38,44,44,44
10850DATA00,40,40,40,00,40,40,3C
10860DATA00,38,54,54,00,44,44,44
10870DATA00,64,54,4C,00,44,44,44
10880DATA00,38,44,44,00,44,44,38
10890DATA00,78,44,44,38,40,40,40
10900DATA00,38,44,44,00,44,48,34
10910DATA00,78,44,44,38,50,48,44
10920DATA00,3C,40,40,38,04,04,78
10930DATA00,7C,10,10,00,10,10,10
10940DATA00,44,44,44,00,44,44,38
10950DATA00,44,44,44,08,50,60,40
10960DATA00,44,44,44,00,54,54,38
10970DATA00,44,44,28,10,28,44,44
10980DATA00,44,44,44,38,04,04,38
10990DATA00,3C,04,08,10,20,40,78
13000restore17740:FORI=0TO(95*8)-1
13010READA$
13020VPOKE8192+I,VAL("&H"+A$):'&h2000'
13030VPOKE10240+I,VAL("&H"+A$):'&h2800'
13040VPOKE12288+I,VAL("&H"+A$):'&h3000'
13050NEXTI
13060callturbooff
17740DATA81,F8,F8,81,81,81,81,81
17750DATA81,21,21,2C,2C,2C,2C,11
17760DATAA1,A1,A1,A1,A1,A1,A1,A1
17770DATAB1,61,61,61,61,61,61,61
17780DATA61,61,61,61,61,61,61,61
17790DATA61,61,61,61,61,61,61,61
17800DATA91,91,A9,EA,EA,A9,E9,E9
17810DATAB1,B1,B1,B1,B1,81,81,81
17820DATA81,B1,B1,B1,B1,A1,A1,A1
17830DATAA1,D1,D1,91,91,91,91,D1
17840DATAF7,F7,F7,B7,F7,F7,BF,BF
17850DATAF7,EF,EB,FB,FB,EB,BF,BF
17860DATAF7,F7,F7,B7,F7,F7,BF,BF
17870DATA51,E5,F5,F5,F5,E5,45,E5
17880DATAE5,E5,E5,E5,E5,E5,E5,E5
17890DATAE5,E5,F5,F5,F5,F5,F5,E5
17900DATAEF,FB,AB,BF,BF,AF,AF,BF
17910DATAEF,EB,FB,FB,FA,BF,AF,BF
17920DATABF,BF,AF,EF,AF,AF,AF,AF
17930DATAAF,AF,EF,BF,BF,AF,AF,AF
17940DATA97,97,97,97,97,97,97,B9
17950DATA97,97,97,97,97,97,B9,B9
17960DATA97,97,97,97,97,97,B9,B9
17970DATA27,27,27,27,27,27,27,27
17980DATA27,27,27,27,27,27,97,97
17990DATA72,72,72,72,72,72,72,72
18000DATA72,72,72,72,72,72,97,97
18010DATA97,F7,F7,F7,EF,7F,7F,7F
18020DATA7F,7F,7F,EF,EF,7F,7F,7F
18030DATA7F,7F,7F,7F,7F,7F,7F,7F
18040DATA7F,7F,7F,7F,EF,7F,7F,7F
18050DATA7F,7F,7F,7F,7F,7F,7F,7F
18060DATA91,91,91,91,91,91,91,91
18070DATA51,51,51,51,51,51,51,51
18080DATA71,71,71,71,71,71,71,71
18090DATA61,61,61,61,61,61,61,61
18100DATAE1,E1,E1,E1,E1,E1,E1,E1
18110DATA21,21,23,23,23,23,23,23
18120DATA91,91,9E,9E,9E,9E,9E,9E
18130DATAE1,51,E1,51,E1,51,E1,51
18140DATAE1,51,E1,51,E1,51,E1,51
18150DATAB1,8B,8B,8B,8B,8B,8B,8B
18160DATAFB,FB,FB,7F,7F,7F,7F,7F
18170DATAFB,EB,EB,EB,EB,F1,F1,F1
18180DATAEB,BF,BF,7F,7F,7F,7F,7F
18190DATA51,51,E5,E5,E5,E5,E5,E5
18200DATAE5,E5,45,E5,E5,F5,E5,E5
18210DATAE5,E5,E5,E5,E5,E5,E5,E5
18220DATA11,31,31,31,31,31,31,31
18230DATA31,31,31,31,31,31,31,31
18240DATA31,31,31,31,31,31,31,31
18250DATA31,31,31,31,31,31,31,31
18260DATA31,31,31,31,31,31,31,31
18270DATA31,31,31,31,31,31,31,31
18280DATA31,21,31,31,31,31,31,31
18290DATA31,31,31,31,31,31,31,31
18300DATA31,31,31,31,31,31,31,31
18310DATA31,31,31,31,31,31,31,31
18320DATA31,31,31,31,31,31,31,31
18330DATA31,31,31,31,31,31,31,31
18340DATA31,31,31,31,31,31,31,31
18350DATA31,31,31,31,31,31,31,31
18360DATA31,31,31,31,31,31,31,31
18370DATA31,31,31,31,31,31,31,31
18380DATAB1,B1,B1,B1,B1,B1,B1,B1
18390DATA31,31,31,31,31,31,31,31
18400DATAE1,E1,E1,E1,E1,E1,E1,E1
18410DATAE1,E1,E1,E1,E1,E1,E1,E1
18420DATAE1,E1,F1,E1,E1,E1,E1,E1
18430DATAE1,E1,E1,E1,E1,B1,E1,E1
18440DATAE1,E1,B1,E1,E1,E1,F1,F1
18450DATAF1,61,61,61,21,21,21,E2
18460DATA61,61,A1,61,26,26,21,21
18470DATAA1,61,61,61,61,A1,61,61
18480DATAA1,A1,A1,A1,61,61,61,61
18490DATAB1,A1,A1,A1,81,81,81,81
18500DATA81,31,31,31,31,31,31,31
18510DATA31,31,31,31,31,31,31,31
18520DATA31,31,31,31,31,31,31,31
18530DATA31,31,31,31,31,31,31,31
18540DATA31,31,31,31,31,31,31,31
18550DATA31,21,31,31,31,31,31,31
18560DATA31,31,31,31,31,31,31,31
18570DATA31,31,31,31,31,31,31,31
18580DATA31,31,31,31,31,31,31,31
18590DATA31,31,31,31,31,31,31,31
18600DATA31,31,31,31,31,31,31,31
18610DATA31,31,31,31,31,31,31,31
18620DATA31,31,31,31,31,31,31,31
18630DATA31,31,31,31,31,31,31,31
18640DATA31,31,31,31,31,31,31,31
18650DATA31,31,31,31,31,31,31,31
18660DATA31,31,31,31,31,31,31,31
18670DATA31,31,31,31,31,31,31,31
18680DATA31,31,31,31,31,31,31,31
18690DATA31,31,31,31,31,31,31,31
18999return
19000FORt=6144TO(6144+768)-97
19010vpoket,255
19020nextt
19090return

10cls:color15,1,1:keyoff
30screen2,2,0
40definta-z
50open"grp:"as#1
60 me$="Loading sprites":gosub 2000
70gosub9000
80 me$="Loading tileset":gosub 2000
90gosub10000
100dimm(120,16):dimtd(2)
110f=0:sc=1:sl=4:ts=0:td(0)=35:td(1)=33:te=64:mc=0:ml=88:ca=1
120x=0:y=9*8:v=8:h=8:l=5:P=0:P0=0:P1=1:P2=2:P3=3:P4=4:P5=5
130restore22000:gosub20200
150 me$="Main menu, press space key":gosub 2100
160fori=0to31:vpoke6656+i,64:nexti
161VPOKE6688,64:VPOKE6719,64:VPOKE6720,64:VPOKE6751,64:VPOKE6752,64:VPOKE6783,64
163VPOKE6690,0
164VPOKE6696,5
165fori=0to31:vpoke6784+i,64:nexti
166gosub2200
200'ifca=0thengoto400
205s=STICK(0)ORSTICK(1)
210ONsGOTO230,250,270,290,310,330,350,370
220p=p0:swapp0,p1:goto400
230y=y-h
240p=p4:swapp4,p5:goto400
250x=x+v:y=y-h
260P=P0:swapP0,P1:goto400
270x=x+v
280P=P0:swapP0,P1:goto400
290x=x+v:y=y+h
300P=P0:swapP0,P1:goto400
310y=y+h
320P=P4:swapP4,P5:goto400
330x=x-v-4:y=y+h
340P=P2:swapP2,P3:goto400
350x=x-v-4:y=y-h
360P=P2:swapP2,P3:goto400
370x=x-v-4:y=y-h
380P=P2:swapP2,P3
400IFY<40THENY=40elseify>120theny=120
420ifx<0thenx=0elseifx>250thenx=250
430PUTSPRITE0,(X,Y),4,P
460px=x/8:py=y/8
470t3=m(px+1+mc,py+1)
475'ift3=tdthengosub3000
475ift3=td(0)ort3=td(1)thenbeep
476ifsc=slthenme$="Congratulations,final":gosub2100:goto110
    477 if mc=ml and x>240 then sc=sc+1:mc=0:x=0:y=9*8:PUT SPRITE0,(0,212),4,0:me$="Loading next level...":gosub 2000:gosub 20200:gosub 2200:f=7:gosub 21000:me$="Press space key":gosub 2100
480ifmcmod10=0andmc<mlthenf=0:gosub21000
485ifmc<mlthenf=7:gosub21000
486'me$=str$(mc):gosub2000
500goto200
2000line(0,170)-(255,180),6,bf
2010preset(0,170):print#1,me$
2090return
2100line(0,170)-(255,180),6,bf
2110preset(0,170):print#1,me$
2120ifstrig(0)=-1then2180else2120
2180line(0,170)-(255,180),6,bf
2190return
2200vpoke6722,22+l
2230vpoke6728,22+sc
2290return
3000'playermuere'
3010beep
3020ca=0:mc=0:l=l-1:gosub2200
3030x=0:y=9*8:f=7:gosub21000
3040PUTSPRITE0,(X,Y),4,0
3050gosub2200
    3060 me$="Ready press space":gosub 2100
3090return
20200'callturboon(m())
20205forr=0to15
20210READmp$:po=0
20220forc=0tolen(mp$)step4
20230r$=mid$(mp$,c+1,2)
20240tn$=mid$(mp$,c+3,2)
20250tn=val("&h"+tn$):tn=tn-1
20260re=val("&h"+r$)
20270fori=0tore
20280iftn<>0andtn<>-1thenm(po,r)=tn:po=po+1
20300nexti
20310nextc
20320nextr
20325'callturbooff
20330return
21000'_TURBOON(m(),mc,f)
21002mc=mc+1
21005md=6144+(32*f)
21010forf=fto15
21020forc=mcto31+mc
21030tn=m(c,f)
21040VPOKEmd,tn
21050md=md+1
21060nextc
21070nextf
21080'_TURBOOFF
21090return
22000data1b230125022300250623012515230125002306250e23002500230125012303251323
22010data1223012506230125012301250623012503230125002301250c23092501230025062301250123012500230125012303250023012504230125002301250623
22020data002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b250123012502230125002301250123012500230125012303250023012503230225002301250623
22030data00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325002301250223032500230125022302250023
22040data0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b250123012502230125002301250123012500230125002304250023082500230125022302250023
22050data00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500231125022302250023
22060data7725
22070data1f240b210005022101240821000505210424012100050a21022406210e240921
22080data06240721000504210024032105240f2101240f2104240d2102240321000501210e240921
22090data06240d210024032105240f2101240321012403210a240521022404210224062100240c2100240421040a
22100data0b2109240321072404210a24032101240d210224032102240b2103240c21002404210424
22110data0b2103240921002411210024072101240d210224032102240b2103240c2100240421040a
22120data062404210324092100241121002407210124032105240321022403210b240221032402210a2404210424
22130data062404210324092100240c210524032105240321052410210124062103241221040a
22140data06240c210124072104240e2105240821002410210124002100051b210424
22150data06240c210124072104240e2105240021000506210024102101240d211424
22200data7723
22210data7723
22220data1e2301480d2301480c230148002301480023014807230148002301480a23014800230148002301480c2301480223
22230data02230048002301480023004811230248002301480d2301480c230748072304480a2307480c2301480223
22240data02230548102306480d2301480c230748072304480a2307480c2301480223
22250data02230548102306480d2301480c230748072304480a2307480c2301480223
22260data6d260922
22270data0b221c210222142101221b2106221121
22280data0022000609221c2102221421012203211322032103221421
22290data0b22052103220321112202210b220521012213210322032103220a21090a
22300data0a21002207210122032101220b2101220e2101220321052211210322032103220a21090a
22310data0a21032204210122032101220b2101220e210122032105220221052203210822042102220221092205210122
22320data072202210322042101221121012203210c22032105220221052203210a22022102220221092205210122
22340data07220b21012208210a220a210122152100220c21012216210322
22350data07220b2101221e210122152100220c21012216210322
22360data07220b2101221e210122152100220c21012216210322
22400data7748
22410data034801230848022311480023084802230648002303480123154802210a480323094802230348
22420data084801230a48032101480223034802231b48022103480123084803210b48012305480221024800230448
22430data0b48002106480621004802230048022113480021084804210748022100480721104804210748
22440data0148012105480321054806210448072101480123024801210348052104480621044810210c48072104480021
22450data7721
22460data7724
22470data04240a210124092103240d210124142104240d2107240b21002409210024
22480data04240a210124092103240d21012414210424132101240b21002409210024
22490data072104240221012402210124042103240421052403210024022102240e2104240221062409210224022108240221022403210024
22500data0721042402210124022101240b2104240621002402210224052101240221082402210d240221022402210124042100240221032402210124
22510data07210924022101240b21002402210024052101240221052402210124092101240f2100240221022402210124042100240221032402210124
22520data0424022104240721012402210924022100240f21002402210124092101240f21002408210124002104240221032402210124
22540data0424022104240721012402210924022104240b210024022105240321032402210124042106240d2102240321022402210124
22550data04240a210624132100240b210024022101240e2101240a210024142100240621
22560data04240a21062413210d24022101240e2101240a210024022102240e2100240621
22600data1b230125022300250623012515230125002306250e23002500230125012303251323
22610data1223012506230125012301250623012503230125002301250c23092501230025062301250123012500230125012303250023012504230125002301250623
22620data002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b250123012502230125002301250123012500230125012303250023012503230225002301250623
22630data00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325002301250223032500230125022302250023
22640data0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b250123012502230125002301250123012500230125002304250023082500230125022302250023
22650data00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500231125022302250023
22660data7725
22670data1f240f2101240f2104240d21022406210e240921
22680data06240d210024032105240f2101240f2104240d21022406210e240921
22690data06240d210024032105240f2101240321012403210a240321042404210224062100240c2100240421040a
22700data0b2109240321072404210a24032101240d210024052102240b2103240c21002404210424
22710data0b2103240921002411210024072101240d210024052102240b2103240c2100240421040a
22720data062404210324092100241121002407210124032105240321032402210b240221032402210a2404210424
22730data062404210324092100240c210524032105240321052410210124062103241221040a
22740data06240c210124072104240e21052408210024102101241d210424
22750data06240c210124072104240e21052408210024102101240d211424
22800data7723
22810data7723
22820data1e2301480d2301480c230148002301480023014807230148002301480a23014800230148002301480c2301480223
22830data02230048002301480023004811230248002301480d2301480c230748072304480a2307480c2301480223
22840data02230548102306480d2301480c230748072304480a2307480c2301480223
22850data02230548102306480d2301480c230748072304480a2307480c2301480223
22860data242603214e26
22870data0b221c210222142101221b2106221121
22880data0022000609221c2102221421012203211322032103221421
22890data0b22052103220321112202210b220521012213210322032103220a210922
22900data0a21002207210122032101220b2101220e2101220321052211210322032103220a21012205210122
22910data0a21032204210122032101220b2101220e210122032105220221052203210822042102220221092205210122
22920data072202210522022101221121012203210c22032105220221052203210a22022102220221092205210122
22940data07220b21012208210a220a210122152100220c21012216210322
22950data07220b2101221e210122152100220c21012216210322
22960data07220b2101221e210122152100220c21012216210322
23000data7748
23010data034801230848022311480023084802230648002303480123154802210a480323094802230348
23020data084801230a48032101480223034802231b48022103480123084803210b48012305480221024800230448
23030data0b48002106480621004802230048022113480021084804210748022100480721104804210748
23040data0148012105480321054806210448072101480123024801210348052104480621044810210c48072104480021
23050data7721
23060data7724
23070data04240a210124092103240d210124142104240d2107240b21002409210024
23080data04240a210124092103240d21012414210424132101240b21002409210024
23090data072104240221012402210124042103240421052403210024022102240e2104240221062409210224022108240221022403210024
23100data0721042402210124022101240b2104240621002402210224052101240221082402210d240221022402210124042100240221032402210124
23110data07210924022101240b21002402210024052101240221052402210124092101240f2100240221022402210124042100240221032402210124
23120data0424022104240721012402210924022100240f21002402210124092101240f21002408210124002104240221032402210124
23140data0424022104240721012402210924022104240b210024022105240321032402210124042106240d2102240321022402210124
23150data04240a210624132100240b210024022101240e2101240a210024142100240621
23160data04240a21062413210d24022101240e2101240a210024022102240e2100240621
23200data1b230125022300250623012515230125002306250e23002500230125012303251323
23210data1223012506230125012301250623012503230125002301250c23092501230025062301250123012500230125012303250023012504230125002301250623
23220data002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b250123012502230125002301250123012500230125012303250023012503230225002301250623
23230data00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325002301250223032500230125022302250023
23240data0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b250123012502230125002301250123012500230125002304250023082500230125022302250023
23250data00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500231125022302250023
23260data7725
23270data1f240f2101240f2104240d21022406210e240921
23280data06240d210024032105240f2101240f2104240d21022406210e240921
23290data06240d210024032105240f2101240321012403210a240321042404210224062100240c2100240421040a
23300data0b2109240321072404210a24032101240d210024052102240b2103240c21002404210424
23310data0b2103240921002411210024072101240d210024052102240b2103240c2100240421040a
23320data062404210324092100241121002407210124032105240321032402210b240221032402210a2404210424
23340data062404210324092100240c210524032105240321052410210124062103241221040a
23350data06240c210124072104240e21052408210024102101241d210424
23360data06240c210124072104240e21052408210024102101240d211424
9000callturboon
9005fori=0to31:putspritei,(0,212),0,0:nexti
9010'callturboon
9020fori=0to(32*6)-1
9030readb:vpoke14336+i,b
9040nexti
9050'callturbooff
9360data0,0,0,0,33,195,192,192
9370data192,63,63,62,96,160,240,240
9380data0,0,0,224,208,252,108,112
9390data240,240,240,240,248,102,54,48
9400remdatadefinitionsprite1,name:Sprite-1
9410data0,0,0,0,0,0,240,112
9420data48,15,15,15,15,5,6,6
9430data0,0,240,120,116,31,27,28
9440data60,252,252,188,48,176,176,248
9445data0,0,0,7,11,63,54,14
9450data15,15,15,15,31,102,108,12
9460data0,0,0,0,132,194,2,2
9470data2,252,252,124,6,4,14,14
9480remdatadefinitionsprite3,name:Sprite-3
9490data0,0,15,30,46,248,216,56
9500data60,63,63,61,12,13,13,31
9510data0,0,0,0,0,0,14,14
9520data12,240,240,240,240,160,96,96
9530remdatadefinitionsprite4,name:Sprite-3
9540data0,0,7,15,31,7,3,3
9550data3,7,15,15,15,6,6,15
9560data0,0,192,224,240,192,128,128
9570data128,192,224,224,224,192,192,224
9580remdatadefinitionsprite5,name:Sprite-3
9590data0,0,7,15,31,7,3,3
9600data19,15,15,15,15,12,16,0
9610data0,0,192,224,240,192,128,128
9620data144,224,224,224,224,192,32,0
9980callturbooff
9990return
10000callturboon
10005FORt=6144TO(6144+768)-97
10010vpoket,255
10020nextt
10030restore10040:FORI=0TO(79*8)-1
10035READA$
10036VPOKEI,VAL("&H"+A$)
10037VPOKE2048+I,VAL("&H"+A$)
10038VPOKE4096+I,VAL("&H"+A$)
10039NEXTI
10040DATAE7,40,20,7E,3C,18,00,00
10050DATA18,3C,3C,18,00,56,56,74
10060DATA00,06,0A,14,20,30,48,00
10070DATA00,00,00,08,10,20,40,00
10080DATA00,00,00,18,2C,2C,18,00
10090DATA00,18,3C,42,42,42,42,00
10100DATA04,08,18,3C,3C,3C,3C,00
10110DATA00,3E,22,3E,00,08,08,00
10120DATA08,14,2A,08,08,08,08,00
10130DATA00,04,02,7D,02,04,00,00
10140DATA00,20,40,BE,40,20,00,00
10150DATA10,10,10,54,28,10,00,00
10160DATA44,44,EE,EE,44,44,44,44
10170DATA00,00,00,00,00,00,00,00
10180DATA00,00,00,00,00,00,00,00
10190DATA00,00,00,00,00,00,00,00
10200DATA00,00,00,00,00,00,00,00
10210DATA00,00,00,00,00,00,00,00
10220DATA00,00,00,00,00,00,00,00
10230DATA00,00,00,00,00,00,00,00
10240DATA00,00,00,00,00,00,00,00
10250DATA00,00,00,00,00,00,00,00
10260DATA00,38,44,4C,10,64,44,38
10270DATA00,0C,04,04,00,04,04,04
10280DATA00,38,04,04,38,40,40,78
10290DATA00,38,04,04,38,04,04,38
10300DATA00,44,44,44,38,04,04,04
10310DATA00,38,40,40,38,04,04,38
10320DATA00,38,40,40,38,44,44,38
10330DATA00,38,04,04,00,04,04,04
10340DATA00,38,44,44,38,44,44,38
10350DATA00,38,44,44,38,04,04,38
10360DATAFF,FF,FF,FF,FF,FF,FF,FF
10370DATAFF,FF,FF,FF,FF,FF,FF,FF
10380DATAFF,FF,FF,FF,FF,FF,FF,FF
10390DATAFF,FF,FF,FF,FF,FF,FF,FF
10400DATAFF,FF,FF,FF,FF,FF,FF,FF
10410DATAFF,FF,52,00,10,24,00,00
10420DATAFF,FF,52,00,08,20,00,00
10430DATA54,38,10,10,10,10,10,10
10440DATAFF,00,7E,00,24,00,24,00
10450DATA7E,24,24,24,24,24,24,24
10460DATA7E,00,24,00,24,18,00,00
10470DATA24,81,FF,00,00,00,00,00
10480DATA12,8A,A8,A0,A0,80,80,00
10490DATA51,00,00,00,00,00,00,00
10500DATA51,00,00,00,00,00,00,00
10510DATA54,55,15,05,05,01,01,00
10520DATA00,00,00,00,00,00,00,00
10530DATAFF,00,3F,00,1F,00,07,00
10540DATAFF,00,FF,00,FF,00,FF,00
10550DATAFF,00,FC,00,F8,00,E0,00
10560DATA00,00,00,00,00,00,00,00
10570DATA00,00,00,00,00,00,00,00
10580DATA00,00,00,00,00,00,00,00
10590DATA00,00,00,00,00,00,00,00
10600DATA00,00,00,00,00,00,00,00
10610DATA00,00,00,00,00,00,00,00
10620DATA00,00,00,00,00,00,00,00
10630DATA00,00,00,00,00,00,00,00
10640DATA00,00,00,00,00,00,00,00
10650DATA00,00,00,00,00,00,00,00
10660DATA00,00,00,00,00,00,00,00
10670DATA00,00,00,00,00,00,00,00
10680DATAFB,FB,00,DF,DF,00,FB,FB
10690DATADF,DF,00,FB,FB,00,00,FB
10700DATA00,DF,DF,00,FB,FB,00,DF
10710DATAFB,00,DF,DF,00,FB,FB,FB
10720DATA00,F7,F7,F7,00,7F,7F,7F
10730DATA00,F7,F7,F7,00,7F,7F,7F
10740DATA00,F7,F7,F7,00,7F,7F,7F
10750DATA6D,DB,DB,6D,6D,DB,DB,6D
10760DATA6D,DB,DB,6C,6C,DB,DB,6C
10770DATAFF,66,66,00,00,66,66,00
10780DATAFF,66,66,00,00,66,66,00
10790DATAFF,99,99,FF,FF,99,99,FF
10800DATA00,00,00,00,00,00,00,00
10810DATA00,00,00,00,00,00,00,00
10820DATA00,00,00,00,00,00,00,00
10830DATA00,00,00,00,00,00,00,00
13000restore17740:FORI=0TO(79*8)-1
13010READA$
13020VPOKE8192+I,VAL("&H"+A$):'&h2000'
13030VPOKE10240+I,VAL("&H"+A$):'&h2800'
13040VPOKE12288+I,VAL("&H"+A$):'&h3000'
13050NEXTI
17740DATA81,F8,F8,81,81,81,81,81
17750DATAB1,B1,B1,B1,B1,81,81,81
17760DATA81,E1,E1,E1,61,61,61,61
17770DATA61,61,61,61,61,61,61,61
17780DATA61,61,61,21,21,21,21,21
17790DATA21,21,21,2C,2C,2C,2C,11
17800DATAD1,D1,91,91,91,91,D1,D1
17810DATAD1,B1,B1,B1,B1,A1,A1,A1
17820DATA81,81,81,81,81,81,81,81
17830DATA81,81,81,81,81,81,81,81
17840DATA81,81,81,81,81,81,81,81
17850DATA81,81,81,81,81,81,81,81
17860DATAB1,A1,A1,A1,81,81,81,81
17870DATA81,81,81,81,81,81,81,81
17880DATA81,81,81,81,81,81,81,81
17890DATA81,81,81,81,81,81,81,81
17900DATA81,81,81,81,81,81,81,81
17910DATA81,81,81,81,81,81,81,81
17920DATA81,81,81,81,81,81,81,81
17930DATA81,81,81,81,81,81,81,81
17940DATA81,81,81,81,81,81,81,81
17950DATA81,81,81,81,81,81,81,81
17960DATA81,31,31,31,31,31,31,31
17970DATA31,31,31,31,31,31,31,31
17980DATA31,31,31,31,31,31,31,31
17990DATA31,31,31,31,31,31,31,31
18000DATA31,31,31,31,31,31,31,31
18010DATA31,31,31,31,31,31,31,31
18020DATA31,21,31,31,31,31,31,31
18030DATA31,31,31,31,31,31,31,31
18040DATA31,31,31,31,31,31,31,31
18050DATA31,31,31,31,31,31,31,31
18060DATA91,91,91,91,91,91,91,91
18070DATA31,31,31,31,31,31,31,31
18080DATA71,71,71,71,71,71,71,71
18090DATAB1,B1,B1,B1,B1,B1,B1,B1
18100DATAE1,E1,E1,E1,E1,E1,E1,E1
18110DATA21,21,23,23,23,23,23,23
18120DATA91,91,9E,9E,9E,9E,9E,9E
18130DATA91,61,61,61,61,61,61,61
18140DATA91,91,61,61,61,61,61,61
18150DATA91,61,61,61,61,61,61,61
18160DATA91,91,61,61,61,61,61,61
18170DATA79,91,91,91,91,91,91,91
18180DATA75,51,51,51,51,51,51,51
18190DATA75,11,11,11,11,11,11,11
18200DATA35,11,11,11,11,11,11,11
18210DATA75,51,51,51,51,51,51,51
18220DATA51,51,51,51,51,51,51,51
18230DATA51,51,51,51,51,51,51,51
18240DATA51,51,51,51,51,51,51,51
18250DATA51,51,51,51,51,51,51,51
18260DATA51,51,51,51,51,51,51,51
18270DATA51,51,51,51,51,51,51,51
18280DATA51,51,51,51,51,51,51,51
18290DATA51,51,51,51,51,51,51,51
18300DATA51,51,51,51,51,51,51,51
18310DATA51,51,51,51,51,51,51,51
18320DATA51,51,51,51,51,51,51,51
18330DATA51,51,51,51,51,51,51,51
18340DATA51,51,51,51,51,51,51,51
18350DATA51,51,51,51,51,51,51,51
18360DATA51,51,51,51,51,51,51,51
18370DATA51,51,51,51,51,51,51,51
18380DATAE1,E1,E1,A1,A1,A1,E1,E1
18390DATAE1,E1,E1,A1,A1,A1,A1,A1
18400DATAA1,81,81,81,51,51,51,81
18410DATA81,81,51,51,51,81,81,81
18420DATA81,81,81,81,81,81,81,81
18430DATA81,51,51,51,51,51,51,51
18440DATA51,31,31,31,31,31,31,31
18450DATAE1,51,E1,51,E1,51,E1,51
18460DATAE1,51,E1,51,E1,51,E1,51
18470DATAE1,FE,FE,FE,FE,FE,FE,FE
18480DATAA1,EA,EA,EA,EA,EA,EA,EA
18490DATAF1,FE,FE,FE,FE,FE,FE,FE
18500DATA11,11,11,11,11,11,11,11
18510DATA11,11,11,11,11,11,11,11
18520DATA11,11,11,11,11,11,11,11
18530DATA11,11,11,11,11,11,11,11
19000callturbooff
19990return

#! /bin/sh

box="x1end=0.2 hbox=350 wbox=600"


# Para fazer a figura dos dados (sismograma) com a plotagem das leituras de tempo realizadas

# Devem ser definidos, os parâmetros 
#1. pickfile=  #nome do arquivo com as leituras de tempo (picks); se houver mais de um separa com "," sem espaço
# Ex.: 
# pickfile=tempos1,tempos2,tempos3

#2. np=  # número de linhas (pontos de leitura) de cada arquivo atribuído em "pickfile" (separados por ",")

#3.
color=red  #pode usar outras cores, separadas por "," se houver mais de um evento

filesismo= 
pickfile=  np=   

sugain <$filesismo gagc=1 wagc=.1 | suxwigb windowtitle="$filesismo agc" perc=90 label1="   tempo(s)" label2="Num. do Geofone"     curve=$pickfile npair=$np curvecolor=$color $box &


exit
#com filtro passa-banda e fk
fpb=10,20,130,150
slopes=0.000001,0.00001,.0005,.001 
amps=0.,1.,1.,0.
sugain <$filesismo gagc=1 wagc=.1 | sufilter f=$fpb |sudipfilt slopes=$slopes amps=$amps d2=1 | suxwigb perc=90 label1="   tempo(s)" label2="Num. do Geofone" windowtitle="$filesismo agc; fpb=$fpb; fk2=$slopes " $box curve=$pickfile npair=$np curvecolor=$color  &






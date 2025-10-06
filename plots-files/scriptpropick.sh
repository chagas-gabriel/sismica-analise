
data=   #o nome do arquivo de dados ***

n=      #o número do arquivo do ponto de tiro

suwind <$data key=fldr min=$n max=$n >$n.su

#1. visualizar sismograma bruto
suxpicker <$n.su perc=80 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 title=" $n.su bruto" &

#2. visualizar com ganho agc
sugain <$n.su gagc=1 wagc=.1 | suxpicker  perc=90 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 title="$n.su agc" &

#3. Se precisar usar um filtro passa-banda, segue o comando para o filtro trapezoidal e algumas sugestões das frequências de corte, mas deve verificar se essas são as frequências adequadas aos dados em análise
#################################

fpb=20,30,130,150
#fpb=40,50,130,150 

 sugain <$n.su gagc=1 wagc=0.1 | sufilter f=$fpb | suxpicker title="$n.su agc e fpb=$fpb" x1end=0.3 perc=90 & 
############################################################################

#4. Com filtro fk
#Para verificar o uso do filtro fk (de frequencia em duas dimensoes)
#Espectro fk
# sugain gagc=1 wagc=.1 <$n.su | suspecfk | suximage perc=99.5 x1end=250 & 

#4.1 Elimina o quadrante negativo para tiros no sentido DIRETO
#slopes=-0.0001,0.00001 
slopes=0.000001,0.00001
amps=0.,1.
#Espectro fk dpeois do filtro
#	 sugain agc=1 wagc=0.1 <$n.su | sudipfilt slopes=$slopes amps=$amps d2=1 | suspecfk | suximage perc=99.5 x1end=250 label1="frequencia (Hz)"  label2="freq. espacial k (1/m)" cmap=rgb0 & 

sugain <$n.su gagc=1 wagc=.1 | sudipfilt slopes=$slopes amps=$amps d2=1 | suxpicker  perc=90 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 title="$n.su agc e corta dip<0" &

#4.2 com filtro passa-banda e fk
fpb=10,20,130,150
sugain <$n.su gagc=1 wagc=.1 | sufilter f=$fpb |sudipfilt slopes=$slopes amps=$amps d2=1 |  suxpicker  perc=90 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 title="$n.su agc; fpb=$fpb; fk2=$slopes  " &


exit
#4.3 fk2 #para tentar destacar a refratada de maior velocidade no tiro do sentido Direto
slopes=0.000001,0.00001,.0005,.001 
amps=0.,1.,1.,0.
	 sugain agc=1 wagc=0.1 <$n.su | sudipfilt slopes=$slopes amps=$amps d2=1 | suspecfk | suximage perc=99.5 label1="frequencia (Hz)"  label2="freq. espacial k (1/m)" cmap=rgb0 & 

sugain <$n.su gagc=1 wagc=.1 | sudipfilt slopes=$slopes amps=$amps d2=1 | suxpicker  perc=90 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 title="$n.su agc; fk2=$slopes" &

#4.4 com filtro passa-banda e fk2
fpb=10,20,130,150
sugain <$n.su gagc=1 wagc=.1 | sufilter f=$fpb |sudipfilt slopes=$slopes amps=$amps d2=1 |  suxpicker  perc=90 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 title="$n.su agc; fpb=$fpb; fk2=$slopes  " &

exit

######## Pré-processamento ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Essa etapa já foi feita ######################
#1. Comando para converter o formato dos dados
filesgy=
fileSU=
#segyread tape=$file.sgy >$fileSU.su

# arquivos (fldr=n)
# Descrição das anotações de campo .....
# 

#2. Vizualização inicial de todos os sismogramas para verificar qualidade dos dados (nível de ruído e escolher quais devem/podem ser utilizados)

#2a. utilizar o script versismos.sh para visualizar todos os arquivos na mesma janela de imagem

# OU

#2b. Loop para separar todos os tiros, cada um em um arquivo e visualizar cada sismograma individualmente

file=
f1=1
fmax=

f=$f1
 while [ $f -le $fmax ]  
 do  

suwind <$file key=fldr min=$f max=$f  >$f.su

suxwigb <$f.su windowtitle="$f.su" perc=80 label1="   tempo(s)" label2="Num. do Geofone" x1end=0.3 &

 f=`expr $f + 1`
 done





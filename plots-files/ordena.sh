

file=$1
uniq $file >tmp.dat
sort -n -k 2 tmp.dat > $file
npair=$(wc -l $file | cut -c -2)
echo $npair


#Se precisar corrigir leituras de tempo:
# awk '{print $1 - 0.00 ,$2}' input >output


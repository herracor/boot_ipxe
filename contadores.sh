#!/bin/bash

#Global

cmd=snmpwalk
cmd1=sed
date=$(date +"%d/%b/%Y")
date2=$(date +"%d %b %Y")
date3=$(date +"%d_%b_%y")
opt='-c public -v 2c -Ov -u admin'
f1='s/Counter32: //'
f2='s/STRING: //'
f3='s/INTEGER: //'
c1='1.3.6.1.2.1.43.10.2.1.4.1.1'
c2='1.3.6.1.4.1.1347.43.10.1.1.12.1.1'
mat='1.3.6.1.4.1.1347.43.5.1.1.28.1'
mod='1.3.6.1.4.1.1347.43.5.1.1.36.1'
directorio=/home/usuario/Documentos/Impresoras

#Configuracion de Correo

emisor=sistemas@herracor.com.uy
asunto="Consumos de Impresoras $date2"
mensaje="Adjuntamos detalle de consumos del periodo"
receptores="sistemas@herracor.com.uy ctascorrientes@herracor.com.uy contadores@laoficina.com.uy"

# snmpwalk -c public -v 2c -Ov -u admin 10.120.202.100 1.3.6.1.4.1.1347.43.10.1.1.12.1.1

#Printers Casa Central

c1_94=$($cmd $opt 10.120.200.94 $c1 | $cmd1 "$f1")
mat_94=$($cmd $opt 10.120.200.94 $mat | $cmd1 "$f2")
loc_94="Escritorio PB"
mod_94=$($cmd $opt 10.120.200.94 $mod | $cmd1 "$f2")

c1_95=$($cmd $opt 10.120.200.95 $c1 | $cmd1 "$f1")
mat_95=$($cmd $opt 10.120.200.95 $mat | $cmd1 "$f2")
loc_95="Acreedores"
mod_95=$($cmd $opt 10.120.200.95 $mod | $cmd1 "$f2")

c2_98=$($cmd $opt 10.120.200.98 $c2 | $cmd1 "$f3")
mat_98=$($cmd $opt 10.120.200.98 $mat | $cmd1 "$f2")
loc_98="Tesoreria"
mod_98=$($cmd $opt 10.120.200.98 $mod | $cmd1 "$f2")

c2_99=$($cmd $opt 10.120.200.99 $c2 | $cmd1 "$f3")
mat_99=$($cmd $opt 10.120.200.99 $mat | $cmd1 "$f2")
loc_99="Fact. Central"
mod_99=$($cmd $opt 10.120.200.99 $mod | $cmd1 "$f2")

c2_100=$($cmd $opt 10.120.200.100 $c2 | $cmd1 "$f3")
mat_100=$($cmd $opt 10.120.200.100 $mat | $cmd1 "$f2")
loc_100="Ctas. Corrientes"
mod_100=$($cmd $opt 10.120.200.100 $mod | $cmd1 "$f2")

c2_101=$($cmd $opt 10.120.200.101 $c2 | $cmd1 "$f3")
mat_101=$($cmd $opt 10.120.200.101 $mat | $cmd1 "$f2")
loc_101="Bonificaciones"
mod_101=$($cmd $opt 10.120.200.101 $mod | $cmd1 "$f2")

#Printers Sucursales

c2_cur=$($cmd $opt 10.120.201.100 $c2 | $cmd1 "$f3")
mat_cur=$($cmd $opt 10.120.201.100 $mat | $cmd1 "$f2")
loc_cur="Suc. Curva"
mod_cur=$($cmd $opt 10.120.201.100 $mod | $cmd1 "$f2")

c2_mal=$($cmd $opt 10.120.202.100 $c2 | $cmd1 "$f3")
mat_mal=$($cmd $opt 10.120.202.100 $mat | $cmd1 "$f2")
loc_mal="Suc. Maldonado"
mod_mal=$($cmd $opt 10.120.202.100 $mod | $cmd1 "$f2")

c2_col=$($cmd $opt 10.120.203.100 $c2 | $cmd1 "$f3")
mat_col=$($cmd $opt 10.120.203.100 $mat | $cmd1 "$f2")
loc_col="Suc. Colonia"
mod_col=$($cmd $opt 10.120.203.100 $mod | $cmd1 "$f2")


{
printf '\n'
printf "HERRACOR S.A.  \t  CONSUMOS DE IMPRESORAS \t$date"'\n'
printf '\n'
printf '%-11s\t%-12s\t%-16s\t%7s\n' \
  Modelo Matricula Lugar Contador \
  "===========" "============" "================" "=======" \
  "$mod_94" "$mat_94" "$loc_94" "$c1_94" \
  "$mod_95" "$mat_95" "$loc_95" "$c1_95" \
  "$mod_98" "$mat_98" "$loc_98" "$c2_98" \
  "$mod_99" "$mat_99" "$loc_99" "$c2_99" \
  "$mod_100" "$mat_100" "$loc_100" "$c2_100" \
  "$mod_101" "$mat_101" "$loc_101" "$c2_101" \
  "$mod_cur" "$mat_cur" "$loc_cur" "$c2_cur" \
  "$mod_mal" "$mat_mal" "$loc_mal" "$c2_mal" \
  "$mod_col" "$mat_col" "$loc_col" "$c2_col"
} > $directorio/contadores_$date3.txt

#echo "$mensaje" | mutt -x -s "$asunto" sistemas@herracor.com.uy fnegrin@romis.com.uy -a "$directorio/contadores_$date3.txt"


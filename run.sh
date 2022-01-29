#!/bin/bash

for i in `seq 8 -1 1`;
        do
	clear
	printf "Este script ejecutará ./simulate.sh y ./simulate2.sh guardando sus tiempos y posteriormente graficando :)"
	printf "\nEjecutando ./simulate.sh en 3 repeticiones para generar datos"
	printf "\n\n[Ejecutando en $i segundos]"
	printf "\n-Presione Ctrl+C para cancelar"
	sleep 1	
	done

./simulate.sh 

./simulate.sh

./simulate.sh 

clear 
printf "simulate.sh finalizado"

printf "\nEjecutando ./simulate2.sh en 3 repeticiones para generar datos"

sleep 3

./simulate2.sh 

./simulate2.sh

./simulate2.sh 

clear
printf "\nsimulate2.sh finalizado"

printf "\nGenerando gráfica N Threads vs Time in microseconds [uS] (requiere GNUPlot)"

gnuplot -e "set xlabel 'N Cores'; set ylabel 'Time in microseconds [uS]'; set xrange [-1:9];set multiplot layout 2,1;set title '10 craters' ; plot 'times.csv';set title '20 craters and another configuration';plot 'times2.csv'; pause -1" 

printf "\nFinalizado :)" 

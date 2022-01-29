#!/bin/bash

# Simulation Parameters
eruption_temperature=1500
eruption_rate=100
cell_width=1
map_rows=1000
map_columns=1000
number_of_craters=20
time_steps=10

# Config Parameters
ARCH_EXEC=build/scalaf
ARCH_OUTPUT=output/
ARCH_ALTITUD=altitudesMil2.csv
ARCH_CRATER=crater_location2
BASENAME=${map_rows}x${map_columns}_EXP
number_of_repetitions=8

HILOS_BLOQUE=171
BLOQUES=$(($map_rows/$HILOS_BLOQUE))

clear
printf "Número de hilos $HILOS_BLOQUE, número de bloques $BLOQUES"
printf "\nIniciando iteraciones"
for i in `seq 1 $((${number_of_repetitions}))`;
	do
	ITERATION_NAME=${BASENAME}_${i}
	ARCH_SALIDA=${ITERATION_NAME}
	ARCH_ERROR=${ITERATION_NAME}_ERR
	printf "\nIteración $i"
	printf "\nOUTPUT_FILE: $ARCH_SALIDA"
	printf "\nERROR_FILE: $ARCH_ERROR"
	
	printf "\ntime OMP_NUM_THREADS=$i ./$ARCH_EXEC -t $eruption_temperature -v $eruption_rate -w $cell_width -s $ARCH_CRATER -a $ARCH_ALTITUD -r $map_rows -c $map_columns -p $number_of_craters -e $ITERATION_NAME -n $time_steps > $ARCH_SALIDA 2 > $ARCH_ERROR"
	texto1=$((time OMP_NUM_THREADS=$i ./$ARCH_EXEC -t $eruption_temperature -v $eruption_rate -w $cell_width -s $ARCH_CRATER -a $ARCH_ALTITUD -r $map_rows -c $map_columns -p $number_of_craters -e $ITERATION_NAME -n $time_steps > $ARCH_SALIDA) 2>&1 | grep real)
	echo $texto1
	echo $i, `echo ${texto1:4} | sed 's/[^0-9]//g'` >> times2.csv
	
	# Comprimir resultados y mover a directorio de salida
	tar -zcvpf ${ITERATION_NAME}.tgz ${ITERATION_NAME}_*
	mkdir -p ${ARCH_OUTPUT}
    mv ${ITERATION_NAME}* ${ARCH_OUTPUT}
	printf "\nArchivo copiado en ${ARCH_OUTPUT}"
	rm ${ITERATION_NAME}_*
	printf "\nArchivos limpiados"
	done

printf "\nFin de las iteraciones"

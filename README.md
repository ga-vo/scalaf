# scalaf - Introducción a la computación paralela

Use `./run.sh` to execute simulate scripts and show a plot of times vs number of threads

To plot use `gnuplot -e "set xlabel 'N Cores'; set ylabel 'Time in microseconds [uS]'; set xrange [-1:9];set multiplot  plot 'times.csv';set title '20 craters and another configuration';plot 'times2.layout 2,1;set title '10 craters' ; plot 'times.csv';set title '20 craters and another configuration';plot 'times2.csv'; pause -1" 
`

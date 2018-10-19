set view 0,0
set isosample 500,500
set contour base
set cntrparam levels discrete 0
unset surface
set grid
unset key
unset ztics
set xlabel 'x'
set ylabel 'y'
set xtics 
f(x,y) = x**3 + -3*x - y**2 
splot [-5:5][-5:5] f(x,y)

#
# Set overall margins for the combined set of plots and size them
# to generate a requested inter-plot spacing
#
if (!exists("MP_LEFT"))   MP_LEFT = .1
if (!exists("MP_RIGHT"))  MP_RIGHT = .95
if (!exists("MP_BOTTOM")) MP_BOTTOM = .1
if (!exists("MP_TOP"))    MP_TOP = .9
if (!exists("MP_GAP"))    MP_GAP = 0.05

set multiplot layout 3,3 columnsfirst title "{/:Bold=15 Quelques courbes elliptiques}" \
              margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP

set format y "%.1f"
set key box opaque
set ylabel 'ylabel'
set xrange [-3:3]
unset key
unset ylabel
unset xtics
unset ytics
unset ztics
unset surface
set xtics format " "

f(x,y) = x**3 - y**2
set  title '(0,0)'
splot [-3:3] [-3:3] f(x,y) lt 1

set  title '(1,0)'
f(x,y) = x**3 + x - y**2
splot [-3:3] [-3:3] f(x,y) lt 2


set  title '(-2,2)'
f(x,y) = x**3 - 2*x + 2 - y**2
splot [-3:3] [-3:3] f(x,y) lt 3


set  title '(0,1)'
f(x,y) = x**3 + 1 - y**2
splot [-3:3] [-3:3] f(x,y) lt 4
set  title '(1,1)'
f(x,y) = x**3 + x + 1 - y**2
splot [-3:3] [-3:3] f(x,y) lt 5


set  title '(-2,1)'
f(x,y) = x**3 + -2*x + 1 - y**2
splot [-3:3] [-3:3] f(x,y) lt 6

set  title '(0,-2)'
f(x,y) = x**3  - 2 - y**2
splot [-3:3] [-3:3] f(x,y) lt 7

set  title '(-3,0)'
f(x,y) = x**3 - 3*x  - y**2
splot [-3:3] [-3:3] f(x,y) lt 8


set  title '(-3,2)'
f(x,y) = x**3 + -3*x + 2 - y**2
splot [-3:3] [-3:3] f(x,y) lt 9

unset multiplot

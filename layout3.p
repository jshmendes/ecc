#
# Set overall margins for the combined set of plots and size them
# to generate a requested inter-plot spacing
#
if (!exists("MP_LEFT"))   MP_LEFT = .1
if (!exists("MP_RIGHT"))  MP_RIGHT = .95
if (!exists("MP_BOTTOM")) MP_BOTTOM = .1
if (!exists("MP_TOP"))    MP_TOP = .9
if (!exists("MP_GAP"))    MP_GAP = 0.05

set multiplot layout 1,2 columnsfirst title "{/:Bold=15 Différentes représentations}" \
              margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_GAP


set key box opaque
unset key
unset ylabel
set ytics 
unset ztics
unset surface
set ytics format " "

set xtics
plot [0:7] [0:7] 'data7.dat' lt 2
unset xtics
set xtics 0,5
plot [0:23] [0:23] 'data23.p' lt 3

unset multiplot

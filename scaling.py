import matplotlib.pyplot as plt
import numpy as np
from matplotlib.pylab import plot, show, xlabel, ylabel, title, legend, errorbar, subplots
from numpy import loadtxt, array, sqrt
from testaxes import two_scales, color_y_axis

cpu = loadtxt("BridgesCPU.txt")
gpu = loadtxt("BridgesGPU.txt")

N=int(cpu.size/4)
n=int(gpu.size/2)

#  Data for the cpu runs
corestime = cpu[:,0]
perfectdata1 = cpu[:,1]
realdata3 = cpu[:,2]
speeddata2 = cpu[:,3]
realdata5 = gpu[:,1]
speeddata4 = gpu[:,0]



#  Data for the gpu runs
#1st column: steps
errsum = 0
sum = 0
for i in range(n):
    sum += gpu[i,0]
avg = sum/n
for i in range(n):
    errsum += (gpu[i,0]-avg)**2
err = sqrt(errsum/n)

# plot(corestime,perfectdata1)
# plot(corestime,realdata3, '--o')
# errorbar(28,avg,err, marker='^')

#2nd column: time
errsum2 = 0
sum2 = 0
for i in range(n):
    sum2 += gpu[i,1]
avg2 = sum2/n
for i in range(n):
    errsum2 += (gpu[i,1]-avg2)**2
err2 = sqrt(errsum2/n)
# errorbar(28,avg2,err2,marker='^')





# Create axes
fig, ax = subplots()
ax1, ax2, ax3, ax4, ax5 = two_scales(ax, corestime, perfectdata1, speeddata2, realdata3, avg, avg2, err, err2)

#xlabel("Number of cores",fontsize=18)
#ylabel("Time steps",fontsize=18)
# title("SMD 10ns",fontsize=24)
title("NAMD Scaling",fontsize=24)
legend = ax.legend(loc='upper right', shadow=True, fontsize='x-large')
legend = ax2.legend(loc='upper left', shadow=True, fontsize='x-large')

show()
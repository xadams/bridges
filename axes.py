def two_scales(ax, time, data1, data2, data3, data4, data5, err, err2):
    """

    Parameters
    ----------
    ax : axis
        Axis to put two scales on

    time : array-like
        x-axis values for both datasets

    data1: array-like
        Data for left hand scale

    data2 : array-like
        Data for right hand scale

    c1 : color
        Color for line 1

    c2 : color
        Color for line 2

    Returns
    -------
    ax : axis
        Original axis
    ax2 : axis
        New twin axis
    ax3: axis
       2nd twin axis
    """
    ax1, ax2= ax, ax.twinx() #ax1: perfect, ax2: speed
    ax3 = ax #ax3: real
    ax4 = ax #ax4: speedGPU
    ax5 = ax2 #ax5: realGPU


    ax1.plot(time, data1, color='Black',  label='PerfectCPU')
    ax1.set_xlabel('time (s)')
    ax1.set_ylabel('steps', color='Blue')

    ax2.plot(time, data2, color='Red',  marker = "o", label='SpeedCPU')
    ax2.set_ylabel('time', color='Red')

    ax3.plot(time, data3, label='RealCPU', marker = "o", linestyle='dashed', color='b')
    #ax3.set_ylabel('time', color='b)

    ax4.errorbar(28, data4, yerr=err, label='RealGPU', marker = "o", color='Green')
    ax5.errorbar(28, data5, yerr=err2, label='SpeedGPU', marker = "o", color='Purple')


    return ax1, ax2, ax3, ax4, ax5

# Change color of each axis
def color_y_axis(ax, color):
    """Color your axes."""
    for t in ax.get_yticklabels():
        t.set_color(color)
    return None
#color_y_axis(ax1, 'r')
#color_y_axis(ax2, 'b')
#plot.show()
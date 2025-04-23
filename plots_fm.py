"""
Python module implementing the GT functions for the 2D benchmarks
"""

###############################################################################
# Libraries
import numpy as np
import scipy as sp
import matplotlib.pyplot as plt

#############################################################################################
# Directories
N = [8,15,20]
dir_1 = ['8','15','20']
dir_2 = ['L','M','N','P','R','T','X','Y']

# Nodes name
Nodes = ['$d_A$','$d_B$','$d_C$','$d_D$','$d_E$','$d_F$','$d_G$','$d_H$']

#############################################################################################
# Times
tau = [0,0,0]
tau_data = [0,0,0] 

#for k in range(3):
for k in range(2):
    filename = dir_1[k] + '/results/mcmc_samples/tau.txt'
    tau[k] = np.loadtxt(filename)
    filename = dir_1[k] + '/results/mcmc_samples/tau_data.txt'
    tau_data[k] = np.loadtxt(filename)

#############################################################################################
# Data read
FM_l = 8*[0]
y_l = 8*[0]
cs_l = 8*[0]

FM = [0,0,0]
y = [0,0,0]
cs = [0,0,0]

#for k in range(3):
for k in range(2):
    # Allocate
    yk = np.zeros((N[k],2))
    csk = np.zeros((N[k],2))
    for l in range(8):
        # Directory
        Dir = dir_1[k] + '/results/mcmc_samples/' + dir_2[l] + '/'
		# PDE solution
        filename = Dir + 'c_true_' + dir_2[l] + '.txt'
        data = np.loadtxt(filename)
        FM_l[l] = np.copy(data)
		# Data
        filename = Dir + 'data_' + dir_2[l] + '.txt'
        data = np.loadtxt(filename)
        yk[:,0] = data[0:N[k]]
        yk[:,1] = data[N[k]:2*N[k]]
        y_l[l] = np.copy(yk)
        # Surrogate model
        filename = Dir + 'c_ind_depth_5_' + dir_2[l] + '.txt'
        data = np.loadtxt(filename)
        csk[:,0] = data[0:N[k]]
        csk[:,1] = data[N[k]:2*N[k]]
        cs_l[l] = np.copy(csk)
    # Save data
    FM[k] = np.copy(FM_l)
    y[k] = np.copy(y_l)
    cs[k] = np.copy(cs_l)

#############################################################################################
# Plots

# Parameters
c_min = -1
c_max = 20
tau_min = 0
tau_max = 10
colors = [['k','ro','kx'],['r','yo','gx']]

p = 16*[0]
labels = ['EDM model','Surrogate model','Data']

#############################################################################################
# Utility subplots

# Grid structure
G = [[0,0],[1,0],[2,0],[3,0],[0,1],[1,1],[2,1],[3,1]]

# Plots
#for k in range(3):
for m in range(2):

    # Select the data
    FM_l = np.copy(FM[m])
    y_l = np.copy(y[m])
    cs_l = np.copy(cs[m])
    tau_m = np.copy(tau[m])
    tau_data_m = np.copy(tau_data[m])

    """
    # Create the plots
    fig, ax = plt.subplots(nrows=8, ncols=1, figsize = [6.4,8.0])#, sharex=True, sharey=True)
    acum = -1
    filename = 'FM_' + dir_1[m] + '.pdf'

    for k in range(8):
        FMk = np.copy(FM_l[k])
        yk = np.copy(y_l[k])
        csk = np.copy(cs_l[k])
        for l in range(2):
            acum += 1
            p[acum] = ax[k].plot(tau_m,FMk[:,l],colors[l][0])
            p[acum] = ax[k].plot(tau_data_m,csk[:,l],colors[l][1])
            p[acum] = ax[k].plot(tau_data_m,yk[:,l],colors[l][2])
            #ax[k].set_xticks([])
            #ax[k].set_yticks([])
            ax[k].set_xticks([0,5,10])
            ax[k].set_yticks([0,10,20])
            ax[k].set_xlabel(r'$\tau$')
            ax[k].set_ylabel(r'$c$')            
            ax[k].set_xlim(left=tau_min, right=tau_max)
            ax[k].set_ylim(bottom=c_min, top=c_max)
        ax[k].text(8,15,'Point ' + dir_2[k],fontsize=9)
    ax[7].set_xticks([0,5,10])
    ax[7].set_xlabel(r'$\tau$')
    ax[7].set_yticks([0,10,20])
#    ax[7].legend([r'$c_1$','Surrogate model '+ r'$c_1$','Data ' + r'$c_1$',r'$c_2$','Surrogate model '+ r'$c_2$','Data ' + r'$c_2$'])
#    ax[7][0].set_ylabel(r'$c_1$')
#    ax[7][1].set_ylabel(r'$c_2$')
    fig.legend([r'$c_1$','Surrogate model '+ r'$c_1$','Data ' + r'$c_1$',r'$c_2$','Surrogate model '+ r'$c_2$','Data ' + r'$c_2$'],loc = 'lower center',ncol=3,fontsize = '9')
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()
    """
    
    # Second version
    # Create the plots
    fig, ax = plt.subplots(nrows=4, ncols=2, figsize = [7.5,10.5])#, sharex=True, sharey=True)
    acum = -1
    filename = 'FM_' + dir_1[m] + '_2.pdf'

    for k in range(8):
        FMk = np.copy(FM_l[k])
        yk = np.copy(y_l[k])
        csk = np.copy(cs_l[k])
        L = G[k]
        i = L[0]
        j = L[1]
        for l in range(2):
            acum += 1
            p[acum] = ax[i][j].plot(tau_m,FMk[:,l],colors[l][0])
            p[acum] = ax[i][j].plot(tau_data_m,csk[:,l],colors[l][1])
            p[acum] = ax[i][j].plot(tau_data_m,yk[:,l],colors[l][2])
            ax[i][j].set_xticks([])
            ax[i][j].set_yticks([])
            ax[i][j].set_xlim(left=tau_min, right=tau_max)
            ax[i][j].set_ylim(bottom=c_min, top=c_max)
            ax[i][j].set_xticks([0,5,10],labels=['0','5','10'], fontsize=8)
            ax[i][j].set_yticks([0,10,20],labels=['0','10','20'], fontsize=8)
            ax[i][j].set_xlabel(r'$\tau$',fontsize=8)
            ax[i][j].set_ylabel(r'$c$',fontsize=8)
            ax[i][j].set_aspect('0.3')            
        ax[i][j].text(6,15,'Point ' + dir_2[k],fontsize=8)
#    ax[3][0].set_xticks([0,5,10])
#    ax[3][0].set_xlabel(r'$\tau$',fontsize=8)
#    ax[3][0].set_yticks([0,10,20])
#    ax[3][0].tick_params(axis="x", labelsize=8)
#    ax[3][0].tick_params(axis="y", labelsize=8)
#    ax[3][1].legend([r'$c_1$','Surrogate model '+ r'$c_1$','Data ' + r'$c_1$',r'$c_2$','Surrogate model '+ r'$c_2$','Data ' + r'$c_2$'])    
#    ax[7][0].set_ylabel(r'$c_1$')
#    ax[7][1].set_ylabel(r'$c_2$')
    fig.legend([r'$c_1$','Surrogate model '+ r'$c_1$','Data ' + r'$c_1$',r'$c_2$','Surrogate model '+ r'$c_2$','Data ' + r'$c_2$'],loc = 'lower center',ncol=3,fontsize="8")
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()

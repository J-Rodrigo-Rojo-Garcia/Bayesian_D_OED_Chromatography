"""
Python module implementing the GT functions for the 2D benchmarks
"""

###############################################################################
# Libraries
import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
from matplotlib import colors 

#############################################################################################
# Directories
N = [8,15,20]
dir_1 = ['8','15','20']
dir_2 = ['L','M','N','P','R','T','X','Y']

# Nodes name
Nodes = ['$d_A$','$d_B$','$d_C$','$d_D$','$d_E$','$d_F$','$d_G$','$d_H$']

#############################################################################################
# Data read
theta_post_l = 8*[0]
theta_post_s_l = 8*[0]

theta_post = [0,0,0]
theta_post_s = [0,0,0]

theta_true = np.array([0.05,0.1,10,70])

burnin = 10000

for k in range(2):
#for k in range(3):
    for l in range(8):
        # Directory
        Dir = dir_1[k] + '/results/mcmc_samples/' + dir_2[l] + '/'
		# Samples true model
        filename = Dir + 'theta_post.txt'
        data = np.loadtxt(filename)
        Nk = len(data)
        data = data[burnin:Nk]
        theta_post_l[l] = np.copy(data)
		# Samples surrogate model
        filename = Dir + 'theta_post_surr.txt'
        data = np.loadtxt(filename)
        data = data[burnin:Nk]
        theta_post_s_l[l] = np.copy(data)
    # Save data
    theta_post[k] = np.copy(theta_post_l)
    theta_post_s[k] = np.copy(theta_post_s_l)

#############################################################################################
# Plots

# Parameters
th_min = np.array([0.02,0.03,8,50])
th_max = np.array([0.08,0.17,11,180])
p = 16*[0]

th1_thicks = [0.02,0.05,0.08]
th2_thicks = [0.05,0.1,0.15]
th3_thicks = [8,9.5,11]
th4_thicks = [50,115,180]

N_bins = 50
P1 = 0.03 
P2 = 0.14
P3 = 8.5
P4 = 170
Names = ['$d_A$','$d_B$','$d_C$','$d_D$','$d_E$','$d_F$','$d_G$','$d_H$']

#############################################################################################
# Utility subplots

# Plots
#for m in range(3):
for m in range(2):

    # Select the data
    theta_post_l = np.copy(theta_post[m])
    theta_post_l_s = np.copy(theta_post_s[m])

    # Create the plots

    # Theta 1 vs Theta 2
    fig, ax = plt.subplots(nrows=4, ncols=2, figsize = [3,8],layout="constrained")
    filename = 'th_' + dir_1[m] + '.pdf'

    acum = -1
    for l in range(2):
        for k in range(4):
            acum += 1
            theta_post_l_k = np.copy(theta_post_l[acum])
            ax[k][l].hist2d(theta_post_l_k[:,0],theta_post_l_k[:,1],bins=N_bins,cmap = "gnuplot2",norm = colors.LogNorm())
            ax[k][l].plot(theta_true[0],theta_true[1],'ko',markersize=3)
#            ax[k][l].text(P1,P2,dir_2[acum],horizontalalignment='center',verticalalignment='center',fontsize = 8)
            ax[k][l].set_xticks(th1_thicks)
            ax[k][l].set_yticks(th2_thicks)
            ax[k][l].tick_params(axis="x", labelsize=8)
            ax[k][l].tick_params(axis="y", labelsize=8)
            ax[k][l].set_xlabel(r'$\theta_1$',fontsize = 8)
            ax[k][l].set_ylabel(r'$\theta_2$',fontsize = 8)
            ax[k][l].set_xlim(left=th_min[0], right=th_max[0])
            ax[k][l].set_ylim(bottom=th_min[1], top=th_max[1])
            ax[k][l].set_title('Point '+ dir_2[acum],fontsize = 8)            
    #ax[k][0].set_xticks(th1_thicks)
    #ax[k][0].set_yticks(th2_thicks)
    #ax[k][0].set_xlabel(r'$\theta_1$',fontsize = 8)
    #ax[k][0].set_ylabel(r'$\theta_2$',fontsize = 8)
    #ax[k][0].tick_params(axis="x", labelsize=8)
    #ax[k][0].tick_params(axis="y", labelsize=8)
#    plt.tight_layout()
    fig.suptitle('True',fontsize = 10)
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()

    # Theta 1 vs Theta 2
    fig, ax = plt.subplots(nrows=4, ncols=2, figsize = [3,8],layout="constrained")
    filename = 'th_' + dir_1[m] + '_surr.pdf'

    acum = -1
    for l in range(2):
        for k in range(4):
            acum += 1
            theta_post_l_s_k = np.copy(theta_post_l_s[acum])
            ax[k][l].hist2d(theta_post_l_s_k[:,0],theta_post_l_s_k[:,1],bins=N_bins,cmap = "gnuplot2",norm = colors.LogNorm())
            ax[k][l].plot(theta_true[0],theta_true[1],'ko',markersize=3)
#            ax[k][l].text(P1,P2,dir_2[acum],horizontalalignment='center',verticalalignment='center',fontsize = 8)
            ax[k][l].set_xticks(th1_thicks)
            ax[k][l].set_yticks(th2_thicks)
            ax[k][l].tick_params(axis="x", labelsize=8)
            ax[k][l].tick_params(axis="y", labelsize=8)
            ax[k][l].set_xlabel(r'$\theta_1$',fontsize = 8)
            ax[k][l].set_ylabel(r'$\theta_2$',fontsize = 8)
            ax[k][l].set_xlim(left=th_min[0], right=th_max[0])
            ax[k][l].set_ylim(bottom=th_min[1], top=th_max[1])
            ax[k][l].set_title('Point '+ dir_2[acum],fontsize = 8)            
#    ax[k][0].set_xticks(th1_thicks)
#    ax[k][0].set_yticks(th2_thicks)
#    ax[k][0].set_xlabel(r'$\theta_1$',fontsize = 8)
#    ax[k][0].set_ylabel(r'$\theta_2$',fontsize = 8)
#    ax[k][0].tick_params(axis="x", labelsize=8)
#    ax[k][0].tick_params(axis="y", labelsize=8)
#    plt.tight_layout()
    fig.suptitle('Surrogate',fontsize = 10)
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()

    # Theta 3 vs Theta 4
    fig, ax = plt.subplots(nrows=4, ncols=2, figsize = [3,8],layout="constrained")
    filename = 'th_' + dir_1[m] + '_2.pdf'

    acum = -1
    for l in range(2):
        for k in range(4):
            acum += 1
            theta_post_l_k = np.copy(theta_post_l[acum])
            ax[k][l].hist2d(theta_post_l_k[:,2],theta_post_l_k[:,3],bins=N_bins,cmap = "gnuplot2",norm = colors.LogNorm())
            ax[k][l].plot(theta_true[2],theta_true[3],'ko',markersize=3)
#            ax[k][l].text(P3,P4,dir_2[acum],horizontalalignment='center',verticalalignment='center',fontsize = 8)
            ax[k][l].set_xticks(th3_thicks)
            ax[k][l].set_yticks(th4_thicks)
            ax[k][l].tick_params(axis="x", labelsize=8)
            ax[k][l].tick_params(axis="y", labelsize=8)
            ax[k][l].set_xlabel(r'$\theta_3$',fontsize = 8)
            ax[k][l].set_ylabel(r'$\theta_4$',fontsize = 8)
            ax[k][l].set_xlim(left=th_min[2], right=th_max[2])
            ax[k][l].set_ylim(bottom=th_min[3], top=th_max[3])
            ax[k][l].set_title('Point '+ dir_2[acum],fontsize = 8)            
#    ax[k][0].set_xticks(th3_thicks)
#    ax[k][0].set_yticks(th4_thicks)
#    ax[k][0].set_xlabel(r'$\theta_3$',fontsize = 8)
#    ax[k][0].set_ylabel(r'$\theta_4$',fontsize = 8)
#    ax[k][0].tick_params(axis="x", labelsize=8)
#    ax[k][0].tick_params(axis="y", labelsize=8)
#    plt.tight_layout()
    fig.suptitle('True',fontsize = 10)
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()

    # Theta 3 vs Theta 4
    fig, ax = plt.subplots(nrows=4, ncols=2, figsize = [3,8],layout="constrained")
    filename = 'th_' + dir_1[m] + '_surr_2.pdf'

    acum = -1
    for l in range(2):
        for k in range(4):
            acum += 1
            theta_post_l_s_k = np.copy(theta_post_l_s[acum])
            ax[k][l].hist2d(theta_post_l_s_k[:,2],theta_post_l_s_k[:,3],bins=N_bins,cmap = "gnuplot2",norm = colors.LogNorm())
            ax[k][l].plot(theta_true[2],theta_true[3],'ko',markersize=3)
#            ax[k][l].text(P3,P4,dir_2[acum],horizontalalignment='center',verticalalignment='center',fontsize = 8)
            ax[k][l].set_box_aspect(2)
            ax[k][l].set_xticks(th3_thicks)
            ax[k][l].set_yticks(th4_thicks)
            ax[k][l].tick_params(axis="x", labelsize=8)
            ax[k][l].tick_params(axis="y", labelsize=8)
            ax[k][l].set_xlabel(r'$\theta_3$',fontsize = 8)
            ax[k][l].set_ylabel(r'$\theta_4$',fontsize = 8)
            ax[k][l].set_xlim(left=th_min[2], right=th_max[2])
            ax[k][l].set_ylim(bottom=th_min[3], top=th_max[3])
            ax[k][l].set_title('Point '+ dir_2[acum],fontsize = 8)
#    ax[k][0].set_xticks(th3_thicks)
#    ax[k][0].set_yticks(th4_thicks)
#    ax[k][0].set_xlabel(r'$\theta_3$',fontsize = 8)
#    ax[k][0].set_ylabel(r'$\theta_4$',fontsize = 8)
#    ax[k][0].tick_params(axis="x", labelsize=8)
#    ax[k][0].tick_params(axis="y", labelsize=8)
    #plt.tight_layout()
    fig.suptitle('Surrogate',fontsize = 10)
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()


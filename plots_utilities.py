"""
Python module implementing the GT functions for the 2D benchmarks
"""

###############################################################################
# Libraries
import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
from matplotlib import cm, ticker

#############################################################################################
# Design space
d = np.loadtxt('8/fortran_data/design_space.txt')
Nd = len(d)

# Grid of "d"
d1 = np.unique(d[:,0])
d2 = np.unique(d[:,1])
D1,D2 = np.meshgrid(d1,d2)
Dk1 = D1[0,:]
Dk2 = D2[:,0]
Nd1 = len(Dk1)
Nd2 = len(Dk2)

# Selection
Ind = np.zeros((Nd,3),dtype=int)
dk = np.zeros(2)
k = -1
for i in range(Nd1):
    for j in range(Nd2):
        dk[0] = D1[i,j]
        dk[1] = D2[i,j]
        r = np.argmin(np.sum(np.abs(d - dk),1))
        k += 1
        Ind[k,0] = i
        Ind[k,1] = j
        Ind[k,2] = r

#############################################################################################
# Utility functions
Ut = np.zeros((Nd,3))
Ut[:,0] = np.loadtxt('8/results/oed/U_8.txt')
Ut[:,1] = np.loadtxt('15/results/oed/U_15.txt') 
Ut[:,2] = np.loadtxt('20/results/oed/U_20.txt') 
Us = np.zeros((Nd,3))
Us[:,0] = np.loadtxt('8/results/oed/Us_8.txt')
Us[:,1] = np.loadtxt('15/results/oed/Us_15.txt') 
Us[:,2] = np.loadtxt('20/results/oed/Us_20.txt') 

#############################################################################################
# Grid format
U1 = np.copy(D1)
U2 = np.copy(D1)
U3 = np.copy(D1)
Us1 = np.copy(D1)
Us2 = np.copy(D1)
Us3 = np.copy(D1)

for k in range(Nd):
    i = Ind[k,0]
    j = Ind[k,1]
    r = Ind[k,2]
    U1[i,j] = Ut[r,0]
    U2[i,j] = Ut[r,1]
    U3[i,j] = Ut[r,2]
    Us1[i,j] = Us[r,0]
    Us2[i,j] = Us[r,1]
    Us3[i,j] = Us[r,2]

#############################################################################################
# Errors
E1 = np.abs(U1 - Us1)
E2 = np.abs(U2 - Us2)
E3 = np.abs(U3 - Us3)

#############################################################################################
# Limits
U_min = np.min(Ut)
U_max = np.max(Ut)
Us_min = np.min(Us)
Us_max = np.max(Us)
u_min = min(U_min,Us_min)
u_max = max(U_max,Us_max)
L0 = np.linspace(u_min,u_max,300)
V0 =  np.linspace(2,8,4)

E1_min = np.min(E1); E2_min = np.min(E2); E3_min = np.min(E3)
E1_max = np.max(E1); E2_max = np.max(E2); E3_max = np.max(E3)
E_min = min(min(E1_min,E2_min),E3_min)
E_max = max(max(E1_max,E2_max),E3_max)
LE = np.linspace(E_min,E_max,100)
VE = np.array([0.05,0.15,0.30,0.45])

#############################################################################################
# Points
dP = np.loadtxt('8/fortran_data/d_mcmc.txt')
Ind = np.arange(8)
Ind[0] = 12; Ind[1] = 13; Ind[2] = 14; Ind[3] = 16
Ind[4] = 18; Ind[5] = 20; Ind[6] = 24; Ind[7] = 25
Ind = Ind-1
dP = dP[Ind,:]

# Labels
Names = ['L','M','N','P','R','T','X','Y']
#Names = [r'$\bullet$',r'$\circledast$',r'$\bigotimes$',r'$\ast$',r'$\bigoplus$',r'$\star$',r'$\bigodot$',r'$\times$']
#colors = ['k*','ks','kx','k+','kD','k<','ko','k>']
colors = ['y','y','y','y','y','y','y','y']
colors_2 = ['r','r','r','r','r','r','r','r']
#Fonts = [9,10,5,8,5,14,5,8]
Fonts = [8,8,8,8,8,8,8,8]

#############################################################################################
# Utility subplots
fig, ax = plt.subplots(nrows=3, ncols=3, layout="constrained")#, sharex=True, sharey=True)

# Plots
p1 = ax[0][0].contourf(D1,D2,U1,levels = L0,cmap=cm.hsv)
ax[0][0].set_xticks([0.05,1,2,3])
ax[0][0].set_yticks([1,5,10,15])
ax[0][0].set_xlim(left=0.05, right=3)
ax[0][0].set_ylim(bottom=1, top=15)
ax[0][0].tick_params(axis="x", labelsize=8)
ax[0][0].tick_params(axis="y", labelsize=8)
ax[0][0].set_title('True model',fontsize=10)
for k in range(8):
    ax[0][0].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k],color = 'k')#,fontweight='bold') 
#    ax[0][0].plot(dP[k,0],dP[k,1],colors[k], markersize=3) 
#ax[0][0].set_axis_off()
ax[0][0].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[0][0].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p1)
colorbar.set_ticks(V0)
colorbar.ax.tick_params(labelsize=8)

p2 = ax[0][1].contourf(D1,D2,Us1,levels = L0,cmap=cm.hsv)
ax[0][1].set_xticks([0.05,1,2,3])
ax[0][1].set_yticks([1,5,10,15])
ax[0][1].set_xlim(left=0.05, right=3)
ax[0][1].set_ylim(bottom=1, top=15)
ax[0][1].tick_params(axis="x", labelsize=8)
ax[0][1].tick_params(axis="y", labelsize=8)
ax[0][1].set_title('Surrogate model',fontsize=10)
for k in range(8):
    ax[0][1].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k],color = 'k') 
ax[0][1].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[0][1].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p2)
colorbar.set_ticks(V0)
colorbar.ax.tick_params(labelsize=8)

p3 = ax[0][2].contourf(D1,D2,E1,levels = LE,cmap=cm.hsv)
ax[0][2].set_xticks([0.05,1,2,3])
ax[0][2].set_yticks([1,5,10,15])
ax[0][2].set_xlim(left=0.05, right=3)
ax[0][2].set_ylim(bottom=1, top=15)
ax[0][2].tick_params(axis="x", labelsize=8)
ax[0][2].tick_params(axis="y", labelsize=8)
ax[0][2].set_title('Error',fontsize=10)
#for k in range(8):
#    ax[0][2].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k],color = 'k')#,fontweight='bold') 

ax[0][2].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[0][2].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p3)
colorbar.set_ticks(VE)
colorbar.ax.tick_params(labelsize=8)

p4 = ax[1][0].contourf(D1,D2,U2,levels = L0,cmap=cm.hsv)
ax[1][0].set_xticks([0.05,1,2,3])
ax[1][0].set_yticks([1,5,10,15])
ax[1][0].set_xlim(left=0.05, right=3)
ax[1][0].set_ylim(bottom=1, top=15)
ax[1][0].tick_params(axis="x", labelsize=8)
ax[1][0].tick_params(axis="y", labelsize=8)
ax[1][0].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[1][0].set_ylabel(r'$c^{Feed}$',fontsize = 8)
for k in range(8):
    ax[1][0].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k]) 
colorbar = fig.colorbar(p4)
colorbar.set_ticks(V0)
colorbar.ax.tick_params(labelsize=8)

p5 = ax[1][1].contourf(D1,D2,Us2,levels = L0,cmap=cm.hsv)
ax[1][1].set_xticks([0.05,1,2,3])
ax[1][1].set_yticks([1,5,10,15])
ax[1][1].set_xlim(left=0.05, right=3)
ax[1][1].set_ylim(bottom=1, top=15)
ax[1][1].tick_params(axis="x", labelsize=8)
ax[1][1].tick_params(axis="y", labelsize=8)
for k in range(8):
    ax[1][1].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k]) 
ax[1][1].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[1][1].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p5)
colorbar.set_ticks(V0)
colorbar.ax.tick_params(labelsize=8)

p6 = ax[1][2].contourf(D1,D2,E2,levels = LE,cmap=cm.hsv)
ax[1][2].set_xticks([0.05,1,2,3])
ax[1][2].set_yticks([1,5,10,15])
ax[1][2].set_xlim(left=0.05, right=3)
ax[1][2].set_ylim(bottom=1, top=15)
ax[1][2].tick_params(axis="x", labelsize=8)
ax[1][2].tick_params(axis="y", labelsize=8)
#for k in range(8):
#    ax[1][2].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k],color = 'k')#,fontweight='bold') 

ax[1][2].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[1][2].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p6)
colorbar.set_ticks(VE)
colorbar.ax.tick_params(labelsize=8)

p7 = ax[2][0].contourf(D1,D2,U3,levels = L0,cmap=cm.hsv)
ax[2][0].set_xticks([0.05,1,2,3])
ax[2][0].set_yticks([1,5,10,15])
ax[2][0].set_xlim(left=0.05, right=3)
ax[2][0].set_ylim(bottom=1, top=15)
ax[2][0].tick_params(axis="x", labelsize=8)
ax[2][0].tick_params(axis="y", labelsize=8)
for k in range(8):
    ax[2][0].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k]) 
ax[2][0].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[2][0].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p7)
colorbar.set_ticks(V0)
colorbar.ax.tick_params(labelsize=8)

p8 = ax[2][1].contourf(D1,D2,Us3,levels = L0,cmap=cm.hsv)
ax[2][1].set_xticks([0.05,1,2,3])
ax[2][1].set_yticks([1,5,10,15])
ax[2][1].set_xlim(left=0.05, right=3)
ax[2][1].set_ylim(bottom=1, top=15)
ax[2][1].tick_params(axis="x", labelsize=8)
ax[2][1].tick_params(axis="y", labelsize=8)
for k in range(8):
    ax[2][1].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k]) 
ax[2][1].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[2][1].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p8)
colorbar.set_ticks(V0)
colorbar.ax.tick_params(labelsize=8)

p9 = ax[2][2].contourf(D1,D2,E3,levels = LE,cmap=cm.hsv)
ax[2][2].set_xticks([0.05,1,2,3])
ax[2][2].set_yticks([1,5,10,15])
ax[2][2].set_xlim(left=0.05, right=3)
ax[2][2].set_ylim(bottom=1, top=15)
ax[2][2].tick_params(axis="x", labelsize=8)
ax[2][2].tick_params(axis="y", labelsize=8)
#for k in range(8):
#    ax[2][2].text(dP[k,0],dP[k,1],Names[k],horizontalalignment='center',verticalalignment='center',fontsize = Fonts[k],color = 'k')#,fontweight='bold') 

ax[2][2].set_xlabel(r'$\tau^{inj}$',fontsize = 8)
ax[2][2].set_ylabel(r'$c^{Feed}$',fontsize = 8)
colorbar = fig.colorbar(p9)
colorbar.set_ticks(VE)
colorbar.ax.tick_params(labelsize=8)

plt.savefig('U.pdf', format="pdf", bbox_inches="tight")
plt.close()

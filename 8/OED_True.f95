
program OED_True

use OMP_LIB
use OED
use Variables_Reading
use Variables_Writing

character(len = 225)::filename
integer::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED,M,N,i,u_file
real(kind = 8)::dy,d_tao,tao_inj,F,c_Feed,Sigma,Sigma2,start,finish
integer,allocatable,dimension(:,:)::Ind
real(kind = 8),allocatable,dimension(:)::tao_dat,U
real(kind = 8),allocatable,dimension(:,:)::Lag,theta_pr,d0

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read variables

! Initial unit_file (Something random)
 u_file = 666

! Scalar variables
 filename = 'fortran_data/var_fm.dat' 
 call Read_FM_Params(filename,u_file +  1,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED)

! Nodes
 filename = 'fortran_data/var_nodes_fm.dat'
 allocate(tao_dat(Nt_d),Ind(Nt_d,3),Lag(Nt_d,3)) 
 call Read_FM_Vectors(filename,u_file + 2,N_tao,Nt_d,tao_dat,Ind,Lag)

! Dimensions of the OED
 filename = 'fortran_data/n_grids_training.dat'
 call Read_OED_General_Params(filename,u_file + 3,M,N) 	

! Inversion parameters (Noise)
 filename = 'fortran_data/var_inversion.dat'
 call Read_Inversion_Variables(filename,u_file + 4,Sigma,Sigma2)

! Uncertainty and design variables
 allocate(theta_pr(M,N_th),d0(N,N_OED),U(N))
 filename = 'fortran_data/theta_sample.dat' 
 theta_pr = Read_Theta_Sample(filename,u_file + 5,M,N_th)
 filename = 'fortran_data/design_space.dat'
 d0 = Read_Design_Space(filename,u_file + 6,N,N_OED)

! Utility function
 !$OMP PARALLEL DEFAULT(SHARED) PRIVATE(I) 
 !$OMP DO 
 do i = 1,N
 	U(i) = Utility_Function_V1(Nc,Ny,N_tao,Nt_d,Nd,M,Ind,d_tao,dy,F,Lag,Sigma,Sigma2,theta_pr,d0(i,:))
 enddo
 !$OMP END DO
 !$OMP BARRIER
 !$OMP END PARALLEL	

 ! Save data
 N_char = len('results/oed/U_true.dat')
 call save_vector_dbl(N_char,u_file + 7,N,'results/oed/U_true.dat',U)

end program


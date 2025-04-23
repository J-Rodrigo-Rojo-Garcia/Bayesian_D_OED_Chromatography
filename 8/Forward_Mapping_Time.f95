program Forward_Mapping_Eval

use Chromatography_2D_Dispersive
use Variables_Reading
use Variables_Writing

character(len = 225)::filename
integer::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED,u_file
real(kind = 8)::dy,d_tao,tao_inj,F,c_Feed
integer,allocatable,dimension(:,:)::Ind
real(kind = 8),allocatable,dimension(:)::tao_dat,theta,d,cI
real(kind = 8),allocatable,dimension(:,:)::Lag

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read variables

! Initial unit_file (Something random)
 u_file = 555

! Scalar variables
 filename = 'fortran_data/var_fm.dat'
 call Read_FM_Params(filename,u_file + 1,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED)

! Nodes
 filename = 'fortran_data/var_nodes_fm.dat'
 allocate(tao_dat(Nt_d),Ind(Nt_d,3),cI(Nd),Lag(Nt_d,3)) 
 call Read_FM_Vectors(filename,u_file + 2,N_tao,Nt_d,tao_dat,Ind,Lag)

! Uncertainty and design variables
 allocate(theta(N_th),d(N_OED))
 filename = 'results/forward_mapping_evaluation/theta.dat' 
 theta = Read_Theta_param(filename,u_file + 3,N_th)
 filename = 'results/forward_mapping_evaluation/d.dat'
 d = Read_d_param(filename,u_file + 4,N_OED)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Forward Mapping
 cI = Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,theta(4),Ind,d_tao,dy,d(1),&
 F,theta(3),d(2),theta(1:2),Lag)
 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save data
 filename = 'results/forward_mapping_evaluation/cI.dat'
 call Write_cI(filename,u_file + 5,Nd,cI)

end program

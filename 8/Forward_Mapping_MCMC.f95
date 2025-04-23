program Forward_Mapping_MCMC

use Chromatography_2D_Dispersive
use Variables_Reading
use Variables_Writing

character(len = 225)::filename,abs_dir,point
integer::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED,u_file,N_char
real(kind = 8)::dy,d_tao,tao_inj,F,c_Feed,start,finish
integer,allocatable,dimension(:,:)::Ind
real(kind = 8),dimension(:)::aux(1)
real(kind = 8),allocatable,dimension(:)::tao_dat,theta,d,cI
real(kind = 8),allocatable,dimension(:,:)::c,Lag

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read variables

 ! Call directory
 call getcwd(abs_dir)
 
 ! Read the last folder directory
 read(*,*)point
 u_file = iachar(trim(adjustl(point))) * 100		

 ! Absolute directory
 abs_dir = trim(adjustl(abs_dir))//'/results/mcmc_samples/'//trim(adjustl(point))//'/'

! Scalar variables
 filename = trim(adjustl(abs_dir))//'var_fm_'//trim(adjustl(point))//'.dat'
 call Read_FM_Params(filename,u_file + 1,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED)

! Nodes
 filename = trim(adjustl(abs_dir))//'var_nodes_fm_'//trim(adjustl(point))//'.dat'
 allocate(tao_dat(Nt_d),Ind(Nt_d,3),c(N_tao,Nc),cI(Nd),Lag(Nt_d,3)) 
 call Read_FM_Vectors(filename,u_file + 2,N_tao,Nt_d,tao_dat,Ind,Lag)

! Uncertainty and design variables
 allocate(theta(N_th),d(N_OED)) 
 filename = trim(adjustl(abs_dir))//'theta_'//trim(adjustl(point))//'.dat'
 theta = Read_Theta_param(filename,u_file + 3,N_th)
 filename = trim(adjustl(abs_dir))//'d_'//trim(adjustl(point))//'.dat'
 d = Read_d_param(filename,u_file + 4,N_OED)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Forward Mapping
 cI = Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,theta(4),Ind,d_tao,dy,d(1),&
 F,theta(3),d(2),theta(1:2),Lag)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save data
 filename = trim(adjustl(abs_dir))//'cI_'//trim(adjustl(point))//'.dat'
 call Write_cI(filename,u_file + 5,Nd,cI)

end program

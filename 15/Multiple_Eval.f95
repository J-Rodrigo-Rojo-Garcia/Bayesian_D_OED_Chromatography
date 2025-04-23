program Multiple_Eval

use OMP_LIB
use data_module
use Variables_Reading
use Variables_Writing
use Chromatography_2D_Dispersive

character(len = 225)::filename
integer::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED,N_OED_T
integer::i,j,k,N_char,Nk,u_file
real(kind = 8)::dy,d_tao,tao_inj,F,c_Feed,Sigma,Sigma2
integer,allocatable,dimension(:,:)::Ind
real(kind = 8),allocatable,dimension(:)::tao_dat,d,aux
real(kind = 8),allocatable,dimension(:,:)::Lag,Theta,Fk

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read variables

! Initial unit_file (Something random)
 u_file = 888

! Scalar variables
 filename = 'fortran_data/var_fm.dat'
 call Read_FM_Params(filename,u_file + 1,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED)

! Nodes
 filename = 'fortran_data/var_nodes_fm.dat'
 allocate(tao_dat(Nt_d),Ind(Nt_d,3),Lag(Nt_d,3))
 call Read_FM_Vectors(filename,u_file + 2,N_tao,Nt_d,tao_dat,Ind,Lag)

! Number of evaluations
 allocate(aux(1)) 
 filename = 'results/forward_mapping_evaluation/size_multiple_theta.dat'
 N_char = len(trim(adjustl(filename)))	
 aux = load_vector_dbl(N_char,u_file + 3,1,trim(adjustl(filename)))
 Nk = nint(aux(1))
 
! Design point
 allocate(d(N_OED)) 
 filename = 'results/forward_mapping_evaluation/d.dat'
 d = Read_d_param(filename,u_file + 4,N_OED)
 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Training process
  
! Space in memory
 allocate(Theta(Nk,N_th),Fk(Nk,Nd))
	
! Read the Theta-nodes
 filename = 'results/forward_mapping_evaluation/theta_multiple.dat'
 N_char = len(trim(adjustl(filename)))	
 Theta = load_matrix_dbl(N_char,u_file + 5,Nk,N_th,trim(adjustl(filename)))
 
! Begin the training
 !$OMP PARALLEL DEFAULT(SHARED) PRIVATE(I) 
 !$OMP DO 

 do i = 1,Nk
 	Fk(i,:) = Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,Theta(i,4),Ind,d_tao,dy,d(1),F,Theta(i,3),d(2),Theta(i,1:2),Lag)
 enddo
 		
 !$OMP END DO
 !$OMP BARRIER
 !$OMP END PARALLEL

! Save data
 filename = 'results/forward_mapping_evaluation/F_multiple.dat'
 N_char = len(trim(adjustl(filename)))
 u_file = 800
 call save_matrix_dbl(N_char,u_file,Nk,Nd,trim(adjustl(filename)),Fk)

end program


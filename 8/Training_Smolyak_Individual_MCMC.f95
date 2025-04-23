program Training_Smolyak_Individual_MCMC

use OMP_LIB
use OED
use data_module
use Variables_Reading
use Variables_Writing
character(len = 225)::filename
character(len = 225),allocatable,dimension(:)::filenames,filenames_2,filenames_3
integer::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED,N_OED_T,dimen,Depth_Max
integer::i,j,k,N_char,Nk,u_file
real(kind = 8)::dy,d_tao,tao_inj,F,c_Feed,Sigma,Sigma2
integer,allocatable,dimension(:)::depth,N
integer,allocatable,dimension(:,:)::Ind
real(kind = 8),allocatable,dimension(:)::tao_dat,U,d,aux
real(kind = 8),allocatable,dimension(:,:)::Lag,theta_pr,d1,X,Fk

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read variables

! Initial unit_file (Something random)
 u_file = 778

! Scalar variables
 filename = 'fortran_data/var_fm.dat'
 call Read_FM_Params(filename,u_file + 1,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED)

! Nodes
 filename = 'fortran_data/var_nodes_fm.dat'
 allocate(tao_dat(Nt_d),Ind(Nt_d,3),Lag(Nt_d,3))
 call Read_FM_Vectors(filename,u_file + 2,N_tao,Nt_d,tao_dat,Ind,Lag)

! Smolyak parameters
 filename = 'fortran_data/general_smolyak.dat'
 call Read_Smolyak_Parameters(dimen,u_file + 3,Depth_Max,filename)
 
! Smolyak parameter depths
 filename = 'fortran_data/depth_smolyak.dat'
 allocate(depth(Depth_Max),N(Depth_Max))
 call Read_Smolyak_Depths(Depth_Max,u_file + 4,depth,N,filename)

! Read the temporal index for run
 filename = 'results/surrogated_model_ind/temporal_index.dat'
 N_char = len(trim(adjustl(filename)))
 aux = load_vector_dbl(N_char,u_file + 5,1,trim(adjustl(filename)))
 k = nint(aux(1))
 
! Design Space
 N_OED_T = 25
 allocate(d1(N_OED_T,N_OED)) 
 filename = 'fortran_data/d_mcmc.dat' 	 
 d1 = Read_Design_Space(filename,u_file + 7,N_OED_T,N_OED)
 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Create character variables

 allocate(filenames(Depth_Max),filenames_2(Depth_Max),filenames_3(N_OED_T))

 filename = 'fortran_data/smolyak_names.dat'
 N_char = len(trim(adjustl(filename)))
 filenames = load_vector_character(N_char,u_file + 8,199,Depth_Max,trim(adjustl(filename)))
 
 filename = 'fortran_data/training_mcmc_names.dat'
 N_char = len(trim(adjustl(filename)))
 filenames_2 = load_vector_character(N_char,u_file + 9,200,Depth_Max,trim(adjustl(filename))) 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Training process
 
! Auxiliar variables
 Nk = N(k)
 
! Space in memory
 allocate(X(Nk,N_th),Fk(Nk,Nd))
	
! Read the Smolyak nodes
 X = Read_Smolyak_Nodes(filenames(depth(k)),u_file + 10,depth(k),Nk,N_th)
 	
! Read the filenames for saving each depth
 N_char = len(trim(adjustl(filenames_2(k))))
 filenames_3 = load_vector_character(N_char,u_file + 11,500+k,N_OED_T,trim(adjustl(filenames_2(k))))
 	
! Begin the training
 !$OMP PARALLEL DEFAULT(SHARED) PRIVATE(I,J,N_CHAR,FK,UNIT_FILE) 
 !$OMP DO 
 do j = 1,N_OED_T
 	do i = 1,Nk
 		Fk(i,:) = Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,X(i,4),Ind,d_tao,dy,d1(j,1),F,X(i,3),d1(j,2),X(i,1:2),Lag)
 	enddo
 		
! Save data
 N_char = len(trim(adjustl(filenames_3(j))))
 u_file = 900+j
 call save_matrix_dbl(N_char,u_file,Nk,Nd,trim(adjustl(filenames_3(j))),Fk)

 enddo
 !$OMP END DO
 !$OMP BARRIER
 !$OMP END PARALLEL

end program


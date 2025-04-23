program Training_Smolyak_Total

use OMP_LIB
use OED
use data_module
use Variables_Reading
use Variables_Writing

character(len = 225)::filename
character(len = 225),allocatable,dimension(:)::filenames,filenames_2
integer::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED,dimen,Depth_Max
integer::i,j,k,N_char,Nk,u_file
real(kind = 8)::dy,d_tao,tao_inj,F,c_Feed,Sigma,Sigma2
integer,allocatable,dimension(:)::depth,N
integer,allocatable,dimension(:,:)::Ind
real(kind = 8),allocatable,dimension(:)::tao_dat,U,d,aux
real(kind = 8),allocatable,dimension(:,:)::Lag,X,Fk

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read variables

! Initial unit_file (Something random)
 u_file = 888

! Scalar variables
 filename = 'fortran_data/var_fm.dat'
 call Read_FM_Params(filename,u_file + 1,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED)

! Nodes
 filename = 'fortran_data/var_nodes_fm.dat'
 allocate(tao_dat(Nt_d),Ind(Nt_d,3),Lag(Nt_d,3),aux(1))
 call Read_FM_Vectors(filename,u_file + 2,N_tao,Nt_d,tao_dat,Ind,Lag)

! Smolyak parameters
 filename = 'fortran_data/general_smolyak_tot.dat'
 call Read_Smolyak_Parameters(dimen,u_file + 3,Depth_Max,filename)
 
! Smolyak parameter depths
 filename = 'fortran_data/depth_smolyak_tot.dat'
 allocate(depth(Depth_Max),N(Depth_Max))
 call Read_Smolyak_Depths(Depth_Max,u_file + 4,depth,N,filename)

! Read the temporal index for run
 filename = 'results/surrogated_model_tot/temporal_index.dat'
 N_char = len(trim(adjustl(filename)))
 aux = load_vector_dbl(N_char,u_file + 4,1,trim(adjustl(filename)))
 k = nint(aux(1))
 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Create character variables

 allocate(filenames(Depth_Max),filenames_2(Depth_Max))

 filename = 'fortran_data/smolyak_tot_names.dat'
 N_char = len(trim(adjustl(filename)))
 filenames = load_vector_character(N_char,225,u_file + 5,Depth_Max,trim(adjustl(filename)))
 
 filename = 'fortran_data/training_tot_names.dat'
 N_char = len(trim(adjustl(filename)))
 filenames_2 = load_vector_character(N_char,225,u_file + 6,Depth_Max,trim(adjustl(filename))) 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Training process
 
! Auxiliar variables
 Nk = N(k)
 
! Space in memory
 allocate(X(Nk,dimen),Fk(Nk,Nd))
	
! Read the Smolyak nodes
 X = Read_Smolyak_Nodes(filenames(depth(k)),999,depth(k),Nk,dimen)

 ! Begin the training

 !$OMP PARALLEL DEFAULT(SHARED) PRIVATE(I) 
 !$OMP DO 
 do i = 1,Nk
 	Fk(i,:) = Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,X(i,4),Ind,d_tao,dy,X(i,5),F,X(i,3),X(i,6),X(i,1:2),Lag)
 enddo

 !$OMP END DO
 !$OMP BARRIER
 !$OMP END PARALLEL

 ! Save data
 N_char = len(trim(adjustl(filenames_2(k))))
 call save_matrix_dbl(N_char,201,Nk,Nd,trim(adjustl(filenames_2(k))),Fk)

end program


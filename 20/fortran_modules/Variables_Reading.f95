!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! MODULE Chromatography
! This module contains functions for calculate the Forward Mapping related
! with the PDE that models chromatography
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! DEVELOPER
! Jose Rodrigo Rojo Garcia (Phd Student at LUT)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!The functions are

! 1) ...
! 2) ...
! 3) ...
! 4) ...
! 5) ...

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Parameters


module Variables_Reading

use data_module

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 											READ
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Reading parameters of Forward Mapping
subroutine Read_FM_Params(filename,u_file,Ny,N_tao,Nc,Nt_d,Nd,dy,d_tao,tao_inj,F,N_th,N_OED) 

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::u_file
integer,intent(out)::Ny,N_tao,Nc,Nt_d,Nd,N_th,N_OED
real(kind = 8),intent(out)::dy,d_tao,tao_inj,F

! Local variables
integer:: N_char
real(kind = 8),dimension(:)::vect(11)

 !!! Forward Mapping variables !!!	
 N_char = len(trim(adjustl(filename)))
 vect = load_vector_dbl(N_char,u_file,11,trim(adjustl(filename)))
 
 ! Declaration
 tao_inj = vect(1)
 F = vect(2)
 Ny = nint(vect(3))
 N_tao = nint(vect(4))
 dy = vect(5)
 d_tao = vect(6)
 Nc = nint(vect(7))
 Nt_d = nint(vect(8))
 Nd = nint(vect(9))
 N_th = nint(vect(10))
 N_OED = nint(vect(11))

end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Reading vectors of Forward Mapping
subroutine Read_FM_Vectors(filename,u_file,N_tao,Nt_d,tao_dat,Ind,Lag) 

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::N_tao,Nt_d,u_file
integer,dimension(:,:),intent(out)::Ind(Nt_d,3)
real(kind = 8),dimension(:),intent(out)::tao_dat(Nt_d)
real(kind = 8),dimension(:,:),intent(out)::Lag(Nt_d,3)

! Local variables
integer:: N_char
real(kind = 8),dimension(:,:)::vect(Nt_d,7)

 ! Nodes 	
 N_char = len(trim(adjustl(filename)))
 vect = load_matrix_dbl(N_char,u_file,Nt_d,7,trim(adjustl(filename)))
 Ind = nint(vect(:,1:3))
 tao_dat = vect(:,4)
 Lag = vect(:,5:7)
 	
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Reading the uncertainty parameters
function Read_Theta_param(filename,u_file,N_th) result(theta)

! Input variables
character(len = 225),intent(in)::filename
integer,intent(in)::N_th,u_file

! Local variables
integer:: N_char
real(kind = 8),dimension(:)::theta(N_th)

 ! Uncertainty parameter !	
 N_char = len(trim(adjustl(filename)))
 theta = load_vector_dbl(N_char,u_file,N_th,trim(adjustl(filename)))
 
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Reading the uncertainty parameters
function Read_d_param(filename,u_file,N_OED) result(d)

! Input variables
character(len = 225),intent(in)::filename
integer,intent(in)::N_OED,u_file

! Local variables
integer:: N_char
real(kind = 8),dimension(:)::d(N_OED)

 ! Unvertainty parameter !	
 N_char = len(trim(adjustl(filename)))
 d = load_vector_dbl(N_char,u_file,N_OED,trim(adjustl(filename)))
 
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Inversion variables
subroutine Read_Inversion_Variables(filename,u_file,Sigma,Sigma2)

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::u_file
real(kind = 8),intent(out)::Sigma,Sigma2

! Local variables
integer:: N_char
real(kind = 8),dimension(:)::vect(2)

 ! Variables !	
 N_char = len(trim(adjustl(filename)))
 vect = load_vector_dbl(N_char,u_file,2,trim(adjustl(filename)))

 ! Declaration
 Sigma = vect(1)
 Sigma2 = vect(2) 
 	
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Bounds
subroutine Read_Bounds(f_name_1,f_name_2,u_file_1,u_file_2,N_th,N_OED,lbnd_th,ubnd_th,lbnd_d,ubnd_d) 

! Input-Output variables
character(len = 225),intent(in)::f_name_1,f_name_2
integer,intent(in)::N_th,N_OED,u_file_1,u_file_2
real(kind = 8),intent(out)::lbnd_th(N_th),ubnd_th(N_th),lbnd_d(N_OED),ubnd_d(N_OED)

! Local variables
integer:: N_char
real(kind = 8),dimension(:,:)::vect_1(N_th,2),vect_2(N_OED,2)

 ! Uncertainty Variables !	
 N_char = len(trim(adjustl(f_name_1)))
 vect_1 = load_matrix_dbl(N_char,u_file_1,N_th,2,trim(adjustl(f_name_1)))
 lbnd_th = vect_1(:,1)
 ubnd_th = vect_1(:,2) 

 ! Uncertainty Variables !	
 N_char = len(trim(adjustl(f_name_2)))
 vect_2 = load_matrix_dbl(N_char,u_file_2,N_OED,2,trim(adjustl(f_name_2)))
 lbnd_d = vect_2(:,1)
 ubnd_d = vect_2(:,2) 
 	
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Smolyak parameters
subroutine Read_Smolyak_Parameters(dimen,u_file,Depth_Max,filename) 

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::u_file
integer,intent(out)::dimen,Depth_Max

! Local variables
integer:: N_char
real(kind = 8),dimension(:)::vect(2)

 ! Uncertainty Variables !	
 N_char = len(trim(adjustl(filename)))
 vect = load_vector_dbl(N_char,u_file,2,trim(adjustl(filename)))
 dimen = nint(vect(1))
 Depth_Max = nint(vect(2))
	
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Smolyak parameter depths
subroutine Read_Smolyak_Depths(Depth_Max,u_file,depth,N,filename) 

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::Depth_Max,u_file
integer,dimension(:),intent(out)::depth(Depth_Max),N(Depth_Max)

! Local variables
integer:: N_char
real(kind = 8),dimension(:,:)::vect(Depth_Max,2)

 ! Uncertainty Variables !	
 N_char = len(trim(adjustl(filename)))
 vect = load_matrix_dbl(N_char,u_file,Depth_Max,2,trim(adjustl(filename)))
 depth = nint(vect(:,1))
 N = nint(vect(:,2))

end subroutine


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Smolyak nodes
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Read_Smolyak_Nodes(filename,u_file,depth_k,Nk,N_th) result(X)

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::depth_k,Nk,N_th,u_file

! Local variables
integer:: N_char
real(kind = 8)::X(Nk,N_th)

 ! Training Smolyak nodes !	
 N_char = len(trim(adjustl(filename)))
 X = load_matrix_dbl(N_char,u_file,Nk,N_th,trim(adjustl(filename)))
	
end function


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! OED Params
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine Read_OED_General_Params(filename,u_file,N_Theta,N_d_OED)

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::u_file
integer,intent(out)::N_Theta,N_d_OED

! Local variables
integer:: N_char
real(kind = 8)::vect(2)

 ! Read data !	
 N_char = len(trim(adjustl(filename)))
 vect = load_vector_dbl(N_char,u_file,2,trim(adjustl(filename)))
	
 ! Return the variables
 N_Theta = nint(vect(1))
 N_d_OED = nint(vect(2))
 	
end subroutine


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! OED Unceratinty Sample
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Read_Theta_Sample(filename,u_file,Nk,N_th) result(Theta)

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::Nk,N_th,u_file

! Local variables
integer:: N_char
real(kind = 8)::Theta(Nk,N_th)

 ! Theta Sample !	
 N_char = len(trim(adjustl(filename)))
 Theta = load_matrix_dbl(N_char,u_file,Nk,N_th,trim(adjustl(filename)))
	
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! OED design space
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Read_Design_Space(filename,u_file,Nr,N_OED) result(d)

! Input-Output variables
character(len = 225),intent(in)::filename
integer,intent(in)::Nr,N_OED,u_file

! Local variables
integer:: N_char
real(kind = 8)::d(Nr,N_OED)

 ! Theta Sample !	
 N_char = len(trim(adjustl(filename)))
 d = load_matrix_dbl(N_char,u_file,Nr,N_OED,trim(adjustl(filename)))
	
end function


end module


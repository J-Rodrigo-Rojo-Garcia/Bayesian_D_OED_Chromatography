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


module Variables_Writing

use data_module

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 											Write
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing the uncertainty parameters
subroutine Write_Theta_param(filename,u_file,N_th,theta) 

! Input variables
character(len = 225),intent(in)::filename
integer,intent(in)::N_th,u_file
real(kind = 8),dimension(:),intent(in)::theta

! Local variables
integer:: N_char

 ! Unvertainty parameter !	
 N_char = len(trim(adjustl(filename)))
 call save_vector_dbl(N_char,u_file,N_th,trim(adjustl(filename)),theta)
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Reading the uncertainty parameters
subroutine Write_d_param(filename,u_file,N_OED,d)

! Input variables
character(len = 225),intent(in)::filename
integer,intent(in)::N_OED,u_file
real(kind = 8),dimension(:),intent(in)::d

! Local variables
integer:: N_char

 ! Unvertainty parameter !	
 N_char = len(trim(adjustl(filename)))
 call save_vector_dbl(N_char,u_file,N_OED,trim(adjustl(filename)),d)
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing FM evaluation
subroutine Write_cI(filename,u_file,Nd,cI) 

! Input variables
character(len = 225),intent(in)::filename
integer,intent(in)::Nd,u_file
real(kind = 8),dimension(:),intent(in)::cI

! Local variables
integer:: N_char

 ! Unvertainty parameter !	
 N_char = len(trim(adjustl(filename)))
 call save_vector_dbl(N_char,u_file,Nd,trim(adjustl(filename)),cI)
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing solution of the PDE
subroutine Write_c(filename,u_file,N_tao,c) 

! Input variables
character(len = 225),intent(in)::filename
integer,intent(in)::N_tao,u_file
real(kind = 8),dimension(:,:),intent(in)::c

! Local variables
integer:: N_char

 ! Unvertainty parameter !	
 N_char = len(trim(adjustl(filename)))
 call save_matrix_dbl(N_char,u_file,N_tao,2,trim(adjustl(filename)),c)
 
end subroutine


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing evaluations of the Forward_Mapping
subroutine Write_c_sample(Nk,Nd,c_sample,N_char,unit_file,filename) 

! Input variables
character(len = N_char),intent(in)::filename
integer,intent(in)::Nk,Nd,N_char,unit_file
real(kind = 8),dimension(:),intent(in)::c_sample(Nk,Nd)

 ! Uncertainty parameter !	
 call save_matrix_dbl(N_char,unit_file,Nk,Nd,filename,c_sample)
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing evaluations of the Forward_Mapping
subroutine Write_CPU_time(Depth_max,CPU_Tim,N_char,filename,u_file) 

! Input variables
integer,intent(in)::Depth_max,N_char,u_file
character(len = N_char),intent(in)::filename
real(kind = 8),dimension(:),intent(in)::CPU_Tim

 ! Unvertainty parameter !	
 call save_vector_dbl(N_char,u_file,Depth_max,filename,CPU_Tim)
 
end subroutine

end module


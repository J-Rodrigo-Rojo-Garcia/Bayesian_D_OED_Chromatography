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

module Directories_Data

use data_module

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! 									Directories
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing filenames for smolyak training
subroutine Directories_Depths(depth_max,dir_depths) 

! Input variables
integer,intent(in)::depth_max
character(len = 50),dimension(:),intent(out)::dir_depths(depth_max)

! Local variables
integer::k
integer,dimension(:)::numbers(depth_max)
character(len = 5),dimension(:)::n_chars(depth_max)
 
 ! Construct the numbers
 numbers = (/(k,k=1,depth_max)/)	

 ! Transform the integers in characters
 n_chars = convert_vector_int_character(5,depth_max,numbers)
 
 ! Construct the vector with names !
 do k = 1,depth_max
 	dir_depths(k) = 'matlab_data/depth_'//trim(adjustl(n_chars(k)))//'/'
 enddo
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing filenames for smolyak training
subroutine Filenames_Smolyak_training(Depth_max,grid_names,training_names) 

! Input variables
integer,intent(in)::Depth_max
character(len = 50),dimension(:),intent(out)::grid_names(Depth_max),training_names(Depth_max)

! Local variables
integer::k
integer,dimension(:)::numbers(Depth_max)
character(len = 5),dimension(:)::n_chars(Depth_max)
 
 ! Construct the numbers
 numbers = (/(k,k=1,Depth_max)/)	

 ! Transform the integers in characters
 n_chars = convert_vector_int_character(5,Depth_max,numbers)
 
 ! Construct the vector with names !
 do k = 1,Depth_max
 	grid_names(k) = 'fortran_data/grid_smolyak_'//trim(adjustl(n_chars(k)))//'.dat'
 	training_names(k) = 'matlab_data/training_psi_'//trim(adjustl(n_chars(k)))//'.dat'
 enddo
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing filenames for Smolyak training
subroutine Filenames_Smolyak_training_d(Depth_max,N_Grid_d,grid_names,training_names) 

! Input variables
integer,intent(in)::N_Grid_d,Depth_max
character(len = 50),dimension(:),intent(out)::grid_names(Depth_max)
character(len = 50),dimension(:,:),intent(out)::training_names(N_Grid_d,Depth_max)

! Local variables
integer::k,l
integer,dimension(:)::numbers_depth(Depth_max),numbers_d(N_Grid_d)
character(len = 50)::aux
character(len = 5),dimension(:)::n_chars_depth(Depth_max),n_chars_d(N_Grid_d)
character(len = 50),dimension(:)::dir_depths(Depth_max)
 
 ! Construct the numbers
 numbers_depth = (/(k,k=1,Depth_max)/)	
 numbers_d = (/(k,k=1,N_Grid_d)/)	

 ! Transform the integers in characters
 n_chars_depth = convert_vector_int_character(5,Depth_Max,numbers_depth)
 n_chars_d = convert_vector_int_character(5,N_Grid_d,numbers_d) 
 
 ! Names of the Smolyak grids
 do	k = 1,Depth_max
 	grid_names(k) = 'fortran_data/grid_smolyak_'//trim(adjustl(n_chars_depth(k)))//'.dat'
 enddo 
 
 ! Create the directories for the depths
 call Directories_Depths(Depth_max,dir_depths) 
 
 ! Construct the vector with names !
 do k = 1,N_Grid_d
 	do l = 1,Depth_max
 		aux = trim(adjustl(dir_depths(l)))//'training_psi_'
 		aux = trim(adjustl(aux))//trim(adjustl(n_chars_d(k)))//'.dat'
		training_names(k,l) = trim(adjustl(aux))
	enddo
 enddo
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Writing filenames for Evaluations in
subroutine Filenames_Evaluations_for_utility(N_Grid_d,eval_names) 

! Input variables
integer,intent(in)::N_Grid_d
character(len = 50),dimension(:),intent(out)::eval_names(N_Grid_d)

! Local variables
integer::k,l
integer,dimension(:)::numbers_d(N_Grid_d)
character(len = 50)::aux
character(len = 5),dimension(:)::n_chars_d(N_Grid_d)
 
 ! Construct the numbers
 numbers_d = (/(k,k=1,N_Grid_d)/)	

 ! Transform the integers in characters
 n_chars_d = convert_vector_int_character(5,N_Grid_d,numbers_d) 
  
 ! Construct the vector with names !
 do k = 1,N_Grid_d
 	aux = 'matlab_data/true/'
 	aux = trim(adjustl(aux))//'evaluations_utility_'
 	aux = trim(adjustl(aux))//trim(adjustl(n_chars_d(k)))//'.dat'
	eval_names(k) = trim(adjustl(aux))
 enddo
 
end subroutine


end module


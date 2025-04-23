!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! MODULE DATA
! This module contains subroutines to read and write files
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! DEVELOPER
! José Rodrigo Rojo García UNAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! The subroutines are

module data_module

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                                     CHARACTERES                                       
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Convert vector (integer) to vector (character)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function convert_vector_int_character(N_char,N,vector_int) result(vector_char)

implicit none
integer,intent(in)::N_char,N
integer,dimension(:),intent(in)::vector_int(N)
integer::i
character(len = N_char),dimension(:)::vector_char(N)

    !Convert elements
    do i = 1,N
        write(vector_char(i),'(I5)') vector_int(i)
    enddo 
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Convert vector (quad) to vector (character)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function convert_vector_quad_character(N_char,N,vector_quad) result(vector_char)

implicit none
integer,intent(in)::N_char,N
real(kind = 16),dimension(:),intent(in)::vector_quad(N)
integer::i
character(len = N_char),dimension(:)::vector_char(N)

    !Convert elements
    do i = 1,N
        write(vector_char(i),*) real(vector_quad(i))
    enddo 
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on vector (character)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_vector_character(N_char,N_char_data,unit_file,N,name_file) result(vector)

implicit none
integer,intent(in)::N_char,N_char_data,N,unit_file
character(len = N_char),intent(in)::name_file
character(len = N_char_data),dimension(:)::vector(N)
integer::k,u_file

    ! Read elements on file 
    u_file = unit_file + 10
    open(unit = u_file, file = name_file, status = 'old')
    do k = 1,N
        read(u_file,"(A100)")vector(k)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save character elements of vector in file
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_vector_character(N_char,unit_file,N,name_file,vector)

implicit none
integer,intent(in)::N_char,unit_file,N
character(len = N_char),intent(in)::name_file
character(len = N_char),dimension(:),intent(in)::vector(N)
integer::k,u_file

    ! Save elements on file 
    u_file = unit_file + 10
    open(unit = u_file,file = name_file)
    do k = 1,N
        write(u_file,*)vector(k)
    enddo
    close(unit = u_file)       
                     
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Count elements in data file
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function count_data(unit_file,N_char,name_file) result(N)

!implicit none
integer,intent(in)::N_char,unit_file
character(len = N_char),intent(in)::name_file
integer::N,u_file

    ! Count data
    N = 0
    u_file = unit_file + 10
    open(unit = u_file, file = name_file, status = 'old')
    do
        read (1,*,iostat = ios)
        if (ios == 0)    then
            N = N + 1
        else
            exit        
        end if

    end do
    close(unit = u_file)    
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Make directory
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 subroutine make_directory(N_char,name_directory)

implicit none
integer,intent(in)::N_char
character(len = N_char),intent(in)::name_directory

    ! Make directory
    call system('mkdir -p ' // name_directory)   
                     
end subroutine


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                                      INTEGERS                                       
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on vector
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_vector_integer(N_char,unit_file,N,name_file) result(vector)

implicit none
integer,intent(in)::N_char,N,unit_file
character(len = N_char),intent(in)::name_file
integer,dimension(:)::vector(N)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file, file = name_file, status = 'old')
    do k = 1,N
        read(u_file,*)vector(k)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on matrix
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_matrix_integer(N_char,unit_file,M,N,name_file) result(matrix)

implicit none
integer,intent(in)::N_char,M,N,unit_file
character(len = N_char),intent(in)::name_file
integer,dimension(:)::matrix(M,N)
integer::k,u_file

    ! Read elements on file 
    u_file = unit_file + 10
    open(unit = u_file,file = name_file)
    do k = 1,M
        write(u_file,*)matrix(k,:)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                                DOUBLE PRECISION                                       
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on vector
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_vector_dbl(N_char,unit_file,N,name_file) result(vector)

implicit none
integer,intent(in)::N_char,N,unit_file
character(len = N_char),intent(in)::name_file
real(kind = 8),dimension(:)::vector(N)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10
    open(unit = u_file, file = name_file, status = 'old')
    do k = 1,N
        read(u_file,*)vector(k)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on matrix
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_matrix_dbl(N_char,unit_file,N,col,name_file) result(matrix)

implicit none
integer,intent(in)::N_char,N,unit_file,col
character(len = N_char),intent(in)::name_file
real(kind = 8),dimension(:,:)::matrix(N,col)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file,file = name_file)
    do k = 1,N
        read(u_file,*)matrix(k,:)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save elements for vector
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_vector_dbl(N_char,unit_file,N,name_file,vector)

implicit none
integer,intent(in)::N_char,N,unit_file
character(len = N_char),intent(in)::name_file
real(kind = 8),dimension(:),intent(in)::vector(N)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file,file = name_file)
    do k = 1,N
        write(u_file,*)vector(k)
    enddo
    close(unit = u_file)       
                     
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save elements for matrix
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_matrix_dbl(N_char,unit_file,N,col,name_file,matrix)

implicit none
integer,intent(in)::N_char,N,unit_file,col
character(len = N_char),intent(in)::name_file
real(kind = 8),dimension(:,:),intent(in)::matrix(N,col)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file,file = name_file)
    do k = 1,N
        write(u_file,*)matrix(k,:)
    enddo
    close(unit = u_file)       
                     
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save elements for matrix (with indices)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_matrix_index_dbl(N_char,unit_file,N,M,name_file,matrix)

implicit none
integer,intent(in)::N_char,N,M,unit_file
character(len = N_char),intent(in)::name_file
real(kind = 8),dimension(:,:),intent(in)::matrix(N,M)
integer::i,j,u_file

    ! Read elements on file 
    u_file = unit_file + 10
    open(unit = u_file,file = name_file)
    do i = 1,N
        do j = 1,M
            write(u_file,*)i,j,matrix(i,j)
        enddo
    enddo
    close(unit = u_file)       
                     
end subroutine


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                                  QUAD PRECISION                                       
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on vector
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_vector_quad(N_char,unit_file,N,name_file) result(vector)

implicit none
integer,intent(in)::N_char,N,unit_file
character(len = N_char),intent(in)::name_file
real(kind = 16),dimension(:)::vector(N)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file, file = name_file, status = 'old')
    do k = 1,N
        read(u_file,*)vector(k)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read elements on matrix
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function load_matrix_quad(N_char,unit_file,N,col,name_file) result(matrix)

implicit none
integer,intent(in)::N_char,N,unit_file,col
character(len = N_char),intent(in)::name_file
real(kind = 16),dimension(:,:)::matrix(N,col)
integer::k,u_file

    ! Read elements on file 
    u_file = unit_file + 10
    open(unit = u_file, file = name_file, status = 'old')
    do k = 1,N
        read(u_file,*)matrix(k,:)
    enddo
    close(unit = u_file)       
                     
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save elements for vector
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_vector_quad(N_char,unit_file,N,name_file,vector)

implicit none
integer,intent(in)::N_char,N,unit_file
character(len = N_char),intent(in)::name_file
real(kind = 16),dimension(:),intent(in)::vector(N)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file,file = name_file)
    do k = 1,N
        write(u_file,*)vector(k)
    enddo
    close(unit = u_file)       
                     
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save elements for matrix
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_matrix_quad(N_char,unit_file,N,col,name_file,matrix)

implicit none
integer,intent(in)::N_char,N,unit_file,col
character(len = N_char),intent(in)::name_file
real(kind = 16),dimension(:,:),intent(in)::matrix(N,col)
integer::k,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file,file = name_file)
    do k = 1,N
        write(u_file,*)matrix(k,:)
    enddo
    close(unit = u_file)       
                     
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Save elements for matrix (with indices)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine save_matrix_index_quad(N_char,unit_file,N,M,name_file,matrix)

implicit none
integer,intent(in)::N_char,N,M,unit_file
character(len = N_char),intent(in)::name_file
real(kind = 16),dimension(:,:),intent(in)::matrix(N,M)
integer::i,j,u_file

    ! Read elements on file
    u_file = unit_file + 10 
    open(unit = u_file,file = name_file)
    do i = 1,N
        do j = 1,M
            write(u_file,*)i,j,matrix(i,j)
        enddo
    enddo
    close(unit = u_file)       
                     
end subroutine

end module


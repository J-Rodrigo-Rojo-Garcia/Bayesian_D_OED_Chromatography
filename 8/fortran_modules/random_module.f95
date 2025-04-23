!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! RANDOM_MODULE
! This module contains subroutines to read and write files
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! DEVELOPER
! Jose Rodrigo Rojo Garcia UNAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! The subroutines are

module random_module

! Parameters
real(kind = 8),private,parameter::pi = 3.14159265358979D0
real(kind = 8),private,parameter::pi_2 = 6.283185307179586D0

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Standard Multivariate Normal 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function mvn_rand(N) result(x)

implicit none
integer,intent(in)::N

integer::i
real(kind = 8)::aux1,aux2
real(kind = 8),dimension(:)::x(N)

    !Calculates a sample from uniform
	call random_number(x)
	
	! Box Muller algorithm
	do i = 1,N-1,2
		aux1 = sqrt(-2.D0*log(x(i)))
		aux2 = aux1*cos(pi_2*x(i+1))		
		x(i+1) = aux1*sin(pi_2*x(i+1))
		x(i) = aux2
	enddo
                     
end function

end module


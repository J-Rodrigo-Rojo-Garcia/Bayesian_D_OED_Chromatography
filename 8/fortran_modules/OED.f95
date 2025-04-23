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


module OED

use random_module
use Chromatography_2D_Dispersive
!use Test

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Utility function
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Utility_Function_V1(Nc,Ny,N_tao,Nt_d,Nd,M,Ind,d_tao,dy,F,Lag,Sigma,Sigma2,theta,d) result(U)
! Input-Output variables
integer,intent(in)::Nc,Ny,N_tao,Nt_d,Nd,M
integer,dimension(:,:),intent(in)::Ind
real(kind = 8),intent(in)::d_tao,dy,F,Sigma,Sigma2
real(kind = 8),dimension(:),intent(in)::d
real(kind = 8),dimension(:,:),intent(in)::theta,Lag
! Local variables
integer::i,j,k
real(kind = 8)::U,cons,r,p_y_d,M2,ul
real(kind = 8),dimension(:)::y(Nd),yk(Nd),aux_sum(M)
real(kind = 8),dimension(:,:)::Func(M,Nd)

	! Constants
	cons = -0.5D0/Sigma2
	M2 = dble(M)

	! Forward Mapping evaluations
	do j = 1,M
		Func(j,:) = Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,theta(j,4),Ind,d_tao,dy,d(1),F,theta(j,3),d(2),theta(j,1:2),Lag)
!		write(*,*)Func(j,:)
	enddo
	
	! Utility
	U = 0.D0 	
	do i = 1,M

		! Sampling from likelihood
		y = Func(i,:)
		yk = y + Sigma*mvn_rand(Nd)	

		! MSE
		r = cons*sum((yk-y)**2)
		
		! Sample			
		aux_sum = 0.D0		
		do j = 1,Nd
			aux_sum = aux_sum + (Func(:,j) - yk(j))**2
		enddo	
		aux_sum = exp(cons*aux_sum)

		! Utility
		p_y_d = log(sum(aux_sum))
		
		U = U + (r - p_y_d)/M2	
		
	enddo
	U = U + log(M2)

end function 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Utility function
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!function Utility_Function_V2(M,Nd,Sigma,Sigma2,theta,d) result(U)
! Input-Output variables
!integer,intent(in)::M,Nd
!real(kind = 8),intent(in)::Sigma,Sigma2
!real(kind = 8),dimension(:),intent(in)::d
!real(kind = 8),dimension(:,:),intent(in)::theta

! Local variables
!integer::i,j,k
!real(kind = 8)::U,cons,r,p_y_d,M2
!real(kind = 8),dimension(:)::y(Nd),yk(Nd),ul(M)
!real(kind = 8),dimension(:,:)::Func(M,Nd)

	! Constants
!	cons = -0.5D0/Sigma2
!	M2 = dble(M)

	! Forward Mapping evaluations
!	do j = 1,M
!		Func(j,:) = Marzouk(theta(j,:),d,Nd)
!	enddo
	
	! Utility
!	U = 0.D0 	
!	do i = 1,M

		! Sampling from likelihood
!		y = Func(i,:)
!		yk = y + Sigma*mvn_rand(Nd)	

		! MSE
!		r = cons*sum((yk-y)**2)
		
		! Sample			
!		ul = 0.D0		
!		do j = 1,Nd
!			ul = ul + (Func(:,j) - yk(j))**2
!		enddo	
				
		! Utility			
!		p_y_d = log(sum(exp(cons*ul)))
!		U = U + (r - p_y_d)/M2
		
!	enddo
!	U = U + log(M2)
	
!end function 



end module


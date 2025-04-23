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


module Chromatography_2D_Dispersive

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Forward Mapping
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Forward_Mapping(Nc,Ny,N_tao,Nt_d,Nd,Ntp,Ind,d_tao,dy,tao_inj,F,Qs,c_Feed,b,Lag) result(cI)
! Input-Output variables
integer,intent(in)::Nc,Ny,N_tao,Nt_d,Nd
integer,dimension(:,:),intent(in)::Ind
real(kind = 8),intent(in)::d_tao,dy,tao_inj,F,Qs,c_Feed,Ntp
real(kind = 8),dimension(:),intent(in)::b
real(kind = 8),dimension(:,:),intent(in)::Lag
! Local variables
integer::Ny_p1,Ny_2
real(kind = 8)::eta
real(kind = 8),dimension(:)::aF(Nc),c_RK4(2),C_PDE(2),c_Jac(2),cI(Nd)
real(kind = 8),dimension(:,:)::c(N_tao,Nc)
	
	!!! Auxiliar variables !!!
	call Auxiliar_var(Nc,N_tao,d_tao,Ny,dy,Ntp,F,Qs,b,Ny_p1,Ny_2,eta,c_RK4,C_PDE,aF,c_Jac) 

	!!! Koren Scheme !!!
	c = Koren_scheme(N_tao,Nc,Ny,Ny_2,Ny_p1,d_tao,C_PDE(1),C_PDE(2),c_RK4(1),c_RK4(2),aF,b,c_Jac,tao_inj,c_Feed,eta)

	!!! Interpolation nodes !!!
	cI(1:Nt_d) = Lag(:,1)*c(Ind(:,1),1) + Lag(:,2)*c(Ind(:,2),1) + Lag(:,3)*c(Ind(:,3),1)

	cI(1+Nt_d:Nd) = Lag(:,1)*c(Ind(:,1),2) + Lag(:,2)*c(Ind(:,2),2) + Lag(:,3)*c(Ind(:,3),2)
	
end function 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Forward Mapping and Koren scheme
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine FM_Koren(Nc,Ny,N_tao,Nt_d,Nd,Ntp,Ind,d_tao,dy,tao_inj,F,Qs,c_Feed,b,Lag,c,cI)
! Input-Output variables
integer,intent(in)::Nc,Ny,N_tao,Nt_d,Nd
integer,dimension(:,:),intent(in)::Ind
real(kind = 8),intent(in)::d_tao,dy,tao_inj,F,Qs,c_Feed,Ntp
real(kind = 8),dimension(:),intent(in)::b
real(kind = 8),dimension(:,:),intent(in)::Lag
real(kind = 8),dimension(:),intent(out)::cI(Nd)
real(kind = 8),dimension(:,:),intent(out)::c(N_tao,Nc)
! Local variables
integer::Ny_p1,Ny_2
real(kind = 8)::eta
real(kind = 8),dimension(:)::aF(Nc),c_RK4(2),C_PDE(2),c_Jac(2)
	
	!!! Auxiliar variables !!!
	call Auxiliar_var(Nc,N_tao,d_tao,Ny,dy,Ntp,F,Qs,b,Ny_p1,Ny_2,eta,c_RK4,C_PDE,aF,c_Jac) 

	!!! Koren Scheme !!!
	c = Koren_scheme(N_tao,Nc,Ny,Ny_2,Ny_p1,d_tao,C_PDE(1),C_PDE(2),c_RK4(1),c_RK4(2),aF,b,c_Jac,tao_inj,c_Feed,eta)

	! Interpolation nodes
	cI(1:Nt_d) = Lag(:,1)*c(Ind(:,1),1) + Lag(:,2)*c(Ind(:,2),1) + Lag(:,3)*c(Ind(:,3),1)

	cI(1+Nt_d:Nd) = Lag(:,1)*c(Ind(:,1),2) + Lag(:,2)*c(Ind(:,2),2) + Lag(:,3)*c(Ind(:,3),2)
	
end subroutine 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Global varables
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Auxiliar varables
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine Auxiliar_var(Nc,N_tao,d_tao,Ny,dy,Ntp,F,Qs,b,Ny_p1,Ny_2,eta,c_RK4,C_PDE,aF,c_Jac) 
! Input-Output variables
integer,intent(in)::N_tao,Ny
real(kind = 8),intent(in)::d_tao,dy,Qs,F,Ntp
real(kind = 8),dimension(:),intent(in)::b
integer,intent(out)::Ny_p1,Ny_2
real(kind = 8),intent(out)::eta
real(kind = 8),dimension(:),intent(out)::aF(Nc),c_RK4(2),C_PDE(2),c_Jac(2)

	!!! Auxiliar constants !!!
	
	! For RK4
	c_RK4(1) = 0.5D0*d_tao 
	c_RK4(2) = d_tao/6.D0
	
	! For Koren
	eta = 0.0000000001D0	
	
    ! For PDE
	C_PDE(1) = -1.D0/dy
	C_PDE(2) = 0.5D0/(Ntp*dy*dy)	

	! Parameters
	aF = F*Qs*b
	Ny_p1 = Ny + 1
	Ny_2 = Ny-2
 
 	! Parameter for Jacoboian matrix
 	c_Jac(1) = b(1)*aF(2)
 	c_Jac(2) = b(2)*aF(1) 
 	
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Nunmerical solution with the Koren scheme
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Koren_scheme(N_tao,Nc,Ny,Ny_2,Ny_p1,d_tao,C_PDE_1,C_PDE_2,c_RK4_1,c_RK4_2,aF,b,c_Jac,tao_inj,c_Feed,eta) result(c)
! Input-Output variables
integer,intent(in)::N_tao,Nc,Ny,Ny_2,Ny_p1
real(kind = 8),intent(in)::d_tao,C_PDE_1,C_PDE_2,c_RK4_1,c_RK4_2,tao_inj,eta
real(kind = 8),dimension(:),intent(in)::aF,b,c_Jac
!real(kind = 8),dimension(:),intent(in)::c_Feed
real(kind = 8),intent(in)::c_Feed
! Local variables
integer::k
real(kind = 8),dimension(:,:)::c(N_tao,Nc),ck(Ny,Nc),ck_1(Ny,Nc)
	
	!!! Boundary condition !!!
	call Boundary_conditions(d_tao,tao_inj,c,c_Feed)
	
	!!! Previous step !!!
	ck_1 = 0.D0	! It begins with the initial condition in the ODE

	!!! ODE solution !!!
	do k = 2,N_tao
		
		! RK4 step	
		ck = RK4_step(Nc,Ny,Ny_2,Ny_p1,d_tao,C_PDE_1,C_PDE_2,c_RK4_1,c_RK4_2,aF,b,c_Jac,c(k,:),ck_1,eta)

		! Save the last layer
		c(k,:) = ck(Ny,:)
		
		! Update
		ck_1 = ck
		
	enddo	
 
end function 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Global varables
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine Boundary_conditions(d_tao,tao_inj,c,c_Feed) 
! Input-Output variables
real(kind = 8),intent(in)::tao_inj,d_tao
!real(kind = 8),dimension(:),intent(in)::c_Feed
real(kind = 8),intent(in)::c_Feed
real(kind = 8),dimension(:,:),intent(inout)::c
! Local variables
integer::N_inj
	
	! Initial values
	c = 0.D0
	
	! Look for the time of injection
	N_inj = nint(tao_inj/d_tao)
	
	! Substitute with the injection
	c(2:N_inj,:) = c_Feed
 
end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Slope limiter in Koren scheme
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Limiting_Koren(Nc,Ny_2,r) result(phi_K)
! Input-Output variables
integer,intent(in)::Nc,Ny_2
real(kind = 8),dimension(:,:),intent(in)::r
! Local variables
real(kind = 8)::phi_K(Ny_2,Nc)

	! Ratio
	phi_K = min((1.D0 + 2.D0*r)/3.D0,2.D0)
	phi_K = min(2.D0*r,phi_K)
	phi_K = max(0.D0,phi_K)
    
end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Flux
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function flux(Nc,Ny,Ny_2,Ny_p1,c,c0,eta) result(f_j_1_2)
! Input-Output variables
integer,intent(in)::Nc,Ny,Ny_2,Ny_p1
real(kind = 8),intent(in)::eta
real(kind = 8),dimension(:),intent(in)::c0
real(kind = 8),dimension(:,:),intent(in)::c
! Local variables
real(kind = 8)::f_j_1_2(Ny_p1,Nc)

    !!! Initial Memory !!!

    !!! Left side !!!
    f_j_1_2(1,:) = c0					! j = 0		Boundary condition
    f_j_1_2(2,:) = c(1,:)	    		! j = 1

    !!! Interior !!!
    f_j_1_2(3:Ny,:) = ((c(3:Ny,:) - c(2:Ny-1,:)) + eta)
    f_j_1_2(3:Ny,:) = f_j_1_2(3:Ny,:)/((c(2:Ny-1,:) - c(1:Ny-2,:)) + eta)
    
    ! Limiting Koren function (Phi_{j+1/2})
    f_j_1_2(3:Ny,:) = limiting_Koren(Nc,Ny_2,f_j_1_2(3:Ny,:))
    
    ! Flux (f_{j+1/2})
    f_j_1_2(3:Ny,:) = c(2:Ny-1,:) + 0.5D0*f_j_1_2(3:Ny,:)*(c(3:Ny,:) - c(2:Ny-1,:))
              
    !!! Right side !!!
    f_j_1_2(Ny_p1,:) = c(Ny,:)

end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Diffusion
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Difussion_c(Nc,Ny,c) result(D2_c)
! Input-Output variables
integer::Nc,Ny
real(kind = 8),dimension(:,:),intent(in)::c
! Local variables
real(kind = 8)::D2_c(Ny,Nc)

    ! Left side
    D2_c(1,:) = c(2,:)- c(1,:)
    ! Interior
    D2_c(2:Ny-1,:) = c(3:Ny,:) - 2.D0*c(2:Ny-1,:) + c(1:Ny-2,:)
    ! Right side
    D2_c(Ny,:) = c(Ny-1,:)- c(Ny,:)

end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Apply the inverse of Jacobian isotherms
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Apply_inverse_Jac_isotherms_2D(Nc,Ny,aF,b,c_Jac,c,Gc) result(J_1_c)
! Input-Output variables
integer,intent(in)::Nc,Ny
real(kind = 8),dimension(:),intent(in)::aF,b,c_Jac
real(kind = 8),dimension(:,:),intent(in)::c,Gc
! Local variables
real(kind = 8)::den2_1(Ny),A_B(Ny),B_B(Ny),C_B(Ny),D_B(Ny),J_1_c(Ny,Nc)
	
    !!! Blocks !!!
    den2_1 = 1.D0/((1.D0 + b(1)*c(:,1) + b(2)*c(:,2))**2)
    A_B = 1.D0 + (aF(1) + c_Jac(2)*c(:,2))*den2_1
    B_B = (-c_Jac(2))*c(:,1)*den2_1    
    C_B = (-c_Jac(1))*c(:,2)*den2_1    
    D_B = 1.D0 + (aF(2) + c_Jac(1)*c(:,1))*den2_1
 
 	!!! Schur Complement solution of linear system !!!
 	! Step 1
 	J_1_c(:,2) = (Gc(:,2) - C_B*Gc(:,1)/A_B)/(D_B - C_B*B_B/A_B)

	! Step 2
 	J_1_c(:,1) = (Gc(:,1) - B_B*J_1_c(:,2))/A_B
 
end function 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Dispersion function "Gc"
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function G_function_dispersion(Nc,Ny,Ny_2,Ny_p1,C_PDE_1,C_PDE_2,aF,b,c_Jac,c0,c,eta) result(Gc)
! Input-Output variables
integer,intent(in)::Nc,Ny,Ny_2,Ny_p1
real(kind = 8),intent(in)::C_PDE_1,C_PDE_2,eta
real(kind = 8),dimension(:),intent(in)::aF,b,c0,c_Jac
real(kind = 8),dimension(:,:),intent(in)::c
! Local variables
real(kind = 8)::flu(Ny_p1,Nc),Gc(Ny,Nc)

    !!!!!!!!!! Spatial discretization !!!!!!!!!!
	! Flux
	flu = flux(Nc,Ny,Ny_2,Ny_p1,c,c0,eta)
	Gc = flu(2:Ny_p1,:) - flu(1:Ny,:) 

	! Difussion term
	Gc = C_PDE_1*Gc + C_PDE_2*Difussion_c(Nc,Ny,c)

	! Apply Jacobian Matrix
	Gc = Apply_inverse_Jac_isotherms_2D(Nc,Ny,aF,b,c_Jac,c,Gc)

end function

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! RK4 step
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function RK4_step(Nc,Ny,Ny_2,Ny_p1,d_tao,C_PDE_1,C_PDE_2,c_RK4_1,c_RK4_2,aF,b,c_Jac,c0,ck_1,eta) result(ck)
! Input-Output variables
integer,intent(in)::Nc,Ny,Ny_2,Ny_p1
real(kind = 8),intent(in)::d_tao,C_PDE_1,C_PDE_2,c_RK4_1,c_RK4_2,eta
real(kind = 8),dimension(:),intent(in)::c0,aF,b,c_Jac
real(kind = 8),dimension(:,:),intent(in)::ck_1
! Local variables
real(kind = 8)::ck(Ny,Nc),K1(Ny,Nc),K2(Ny,Nc),K3(Ny,Nc),K4(Ny,Nc)

	! Stage 1
	K1 = G_function_dispersion(Nc,Ny,Ny_2,Ny_p1,C_PDE_1,C_PDE_2,aF,b,c_Jac,c0,ck_1,eta)

	! Stage 2
	K2 = G_function_dispersion(Nc,Ny,Ny_2,Ny_p1,C_PDE_1,C_PDE_2,aF,b,c_Jac,c0,ck_1 + c_RK4_1*K1,eta)	

	! Stage 3
	K3 = G_function_dispersion(Nc,Ny,Ny_2,Ny_p1,C_PDE_1,C_PDE_2,aF,b,c_Jac,c0,ck_1 + c_RK4_1*K2,eta)

	! Stage 4
	K4 = G_function_dispersion(Nc,Ny,Ny_2,Ny_p1,C_PDE_1,C_PDE_2,aF,b,c_Jac,c0,ck_1 + d_tao*K3,eta)
	
	! Final Step
	ck = ck_1 + c_RK4_2*(K1 + 2.D0*K2 + 2.D0*K3 + K4)

end function

end module


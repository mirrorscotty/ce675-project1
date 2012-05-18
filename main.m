%   *---------------------------------------------------------------------------*
%   |  NonLinear Finite Element Analysis                                        |
%   |                                                                           |
%   |                                                                           |
%   |   by:             Ghadir Haikal                                           |
%   |   last modified:  03/07/12                                                |
%   |                                                                           |
%   *---------------------------------------------------------------------------*

clear all; close all;
%------------------------------------------------------------------------------
%   Input problem data 
%------------------------------------------------------------------------------
[plane_for,nnode,ndof,nel,nnel_v,X,nodes,bcdof,bcval,mat_set_v,mat_list,t,...
        nodal_forces,surface_tractions,no_steps,arc_length]=input_data;
nsdof=nnode*ndof;                                       % total no. of Dofs
figure;title('undeformed configuration')
[X_plot,plot_axes]=draw_deflected_shape(X,zeros(nsdof,1),nnode,nel,nnel_v,nodes,ndof);
%------------------------------------------------------------------------------
%   Initialize solution and boundary condition constraints
%------------------------------------------------------------------------------
[nbcs,Kbcs] = setup_bc_constraints(bcdof,bcval,nsdof);
%------------------------------------------------------------------------------
%   Calculate load vector
%------------------------------------------------------------------------------
nLgp = 4;
[P_nodal_incr] = calculate_load_vector(nodal_forces,surface_tractions,...
    X,nodes,nnel_v,ndof,nsdof,nLgp);norm_ref=norm(P_nodal_incr); 
%------------------------------------------------------------------------------
%   Find solution
%------------------------------------------------------------------------------
%   itinialization
max_iter = 30;
disp=zeros(nsdof,1); lag_bcs=zeros(nbcs,1); lambda=0;
Delta_q=0;

%   Newton algorithm

for istp=1:no_steps
    disp0=disp; lag_bcs0=lag_bcs; lambda0 = lambda; lambda=lambda+arc_length;
    err=1; iter=0; 
    while (err>1e-8 && iter < max_iter)
        %----------------------------------------------------------------------
        %   Calculate stiffness matrix and internal load vector
        %----------------------------------------------------------------------
        [F_int,K]=Stiff_NL(plane_for,ndof,nnode,nsdof,X,nel,nodes,t,nnel_v,mat_set_v,mat_list,disp);
        Kt=[K,Kbcs;Kbcs',zeros(nbcs)];
        %----------------------------------------------------------------------
        %   Setup residual vector
        %----------------------------------------------------------------------
        res_bcs = bc_residual(disp,nbcs,bcdof,bcval);
        res = F_int-P_nodal_incr*lambda+Kbcs*lag_bcs;
        Rt=[res; res_bcs];
        %----------------------------------------------------------------------
        %   Setup arc-length constraint
        %----------------------------------------------------------------------
        if Delta_q==0, Delta_q=-Kt\Rt; norm2_q=Delta_q'*Delta_q; end
        Delta_lambda = lambda-lambda0;
        Delta_disp = disp-disp0;
        res_arcL=Delta_disp'*Delta_disp/norm2_q+Delta_lambda^2-arc_length^2;
        %----------------------------------------------------------------------
        %   Compute variable increments
        %----------------------------------------------------------------------
        Pt=[P_nodal_incr;zeros(nbcs,1)];
        Kt=[Kt,Pt;
            2*Delta_disp'/norm2_q,zeros(1,nbcs),2*Delta_lambda];
        Rt=[Rt; res_arcL];
        %
        err = norm(Rt)/norm_ref;
        du= -Kt\Rt;
        disp=disp+du(1:nsdof); lag_bcs=lag_bcs+du(nsdof+1:nsdof+nbcs);lambda=lambda+du(end);
        %
        iter=iter+1;    %   update no of increments
    end
    %istp,iter,disp,lambda,lag_bcs
end
post_process(plane_for,ndof,nnode,nsdof,X,disp,nel,nnel_v,nodes,t,mat_set_v,mat_list)



%   *---------------------------------------------------------------------------*
%   |  Linear Finite Element Analysis                                           |
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
        nodal_forces,surface_tractions]=input_data;
%------------------------------------------------------------------------------
%   Initialize solution and boundary condition constraints
%------------------------------------------------------------------------------
nsdof=nnode*ndof;                                       % total no. of Dofs
[nbcs,Kbcs] = setup_bc_constraints(bcdof,bcval,nsdof);
%------------------------------------------------------------------------------
%   Calculate load vector
%------------------------------------------------------------------------------
nLgp = 4;
[P_nodal] = calculate_load_vector(nodal_forces,surface_tractions,...
    X,nodes,nnel_v,ndof,nsdof,nLgp);
%------------------------------------------------------------------------------
%   Calculate stiffness matrix
%------------------------------------------------------------------------------
[K]=Stiff(plane_for,ndof,nnode,nsdof,X,nel,nodes,t,nnel_v,mat_set_v,mat_list);
%------------------------------------------------------------------------------
%   Find solution
%------------------------------------------------------------------------------
Kt=[K,Kbcs;Kbcs',zeros(nbcs)];
Pt=[P_nodal; zeros(nbcs,1)];
u= Kt\Pt;

disp=u(1:nsdof), lag_bcs=u(nsdof+1:nsdof+nbcs);
function [plane_for,nnode,ndof,nel,nnel_v,X,nodes,bcdof,bcval,mat_set_v,mat_list,t,...
        nodal_forces,surface_tractions] = qstatic_simpleQ4

    plane_for='plane_stress';              
    nnode=4;
    ndof=2;
    nel=1;
    %--------------------------------------------------------------------------
    % Material properties
    %--------------------------------------------------------------------------
    E=2.0e3; nu=0.3;rho=1;t=1;
    mat_set_v = ones(nel,1);    % material set no for each element
    mat_list = [E, nu];         % properties for each material set
    %--------------------------------------------------------------------------
    % Undeformed Configuration Coordinates
    %--------------------------------------------------------------------------
    X=[0 0; 1 0;1 1; 0 1];
    %--------------------------------------------------------------------------
    % Boundary conditions
    %--------------------------------------------------------------------------
    bcdof=[1 2 4];  % degrees of freedom at which displacements are prescribed
    bcval=[0 0 0];  % prescribed displacement values
    %--------------------------------------------------------------------------
    % Element connectivity
    %--------------------------------------------------------------------------
    nnel_v=4*ones(1,nel);       % no. of nodes for each element
    nodes=[1 2 3 4];            % list of nodes for each element
    %--------------------------------------------------------------------------
    % Applied forces
    %--------------------------------------------------------------------------
    nodal_forces=[];                % [d.o.f. where force is applied, value]
    surface_tractions=[1,2,1,0,-1]; % applied surface tractions:
                                    % [element no=1, tractions are applied
                                    % on surface z2 = constant, constant =
                                    % 1, traction vector =[0,-1]'
    %--------------------------------------------------------------------------

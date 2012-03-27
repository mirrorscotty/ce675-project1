function [P_nodal] = calculate_load_vector(nodal_forces,surface_tractions,X,nodes,nnel_v,ndof,nsdof,nLgp)
%--------------------------------------------------------------------------
%
%   Calculate the total equivalent load vector from the applied 
%       nodal loads and surface tractions 
%       for a 2D triangular area 
% 
%   P_nodal = equivalent load vector
% ex:  nodal_forces=[1,2];          % [d.o.f. where force is applied =1,
%                                   %  value = 2]
%   surface_tractions=[1,2,1,0,-1]; % applied surface tractions:
%                                   % [element no=1, tractions are applied
%                                   % on surface z2 = constant, constant =
%                                   % 1, traction vector =[0,-1]'
%
%--------------------------------------------------------------------------

P_nodal = zeros(nsdof,1); 
[cgp,wgp]=gaussL(nLgp);

no_applied_forces = size(nodal_forces,1);

for i=1:no_applied_forces
    k= nodal_forces(i,1);
    P_nodal(k) = nodal_forces(i,2);
end


no_applied_tractions = size(surface_tractions,1);

for i=1:no_applied_tractions
    el_no = surface_tractions(i,1);
    surface_dof = surface_tractions(i,2);
    surface_dof_val = surface_tractions(i,3);
    q_vec= surface_tractions(i,4:5)';
    
    [nnel,Xe,ii] = localize(el_no,X,nodes,nnel_v,ndof);
    tan_dof = surface_dof+1; if tan_dof>ndof, tan_dof=1; end

    qe=zeros(nnel*ndof,1);
    for ip=1:nLgp
        zp=cgp(ip)*ones(ndof,1);
        zp(surface_dof)=surface_dof_val;

        [Nz,dNz]=shapefn(zp,nnel,ndof);
        for i=1:nnel
            i1=ndof*(i-1)+1;
            i2=ndof*i;
            Ne(i1:i2)=Nz(i)*q_vec;
        end
        dXz_T=dNz*Xe;  % J_T
        J_ZL = norm(dXz_T(tan_dof,:));

        q_ip=Ne.*J_ZL.*wgp(ip);
        qe=qe+q_ip';
    end
    
    P_nodal(ii)=P_nodal(ii)+qe;
end
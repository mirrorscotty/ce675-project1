function [nbcs,Kbcs] = setup_bc_constraints(bcdof,bcval,nsdof)

%------------------------------------------------------------------------------
%
%   Setup the boundary condition constraints using Lagrange multipliers
%
%   nbcs     = no. of boundary conditions
%   Kbcs     = gradient of boundary condition equations
%------------------------------------------------------------------------------

nbcs = size(bcdof,2);
Kbcs = zeros (nsdof,nbcs);

for i = 1:nbcs
    n = bcdof(i);
    Kbcs(n,i)=1;
end


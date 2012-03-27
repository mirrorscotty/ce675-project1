function [ngp,cgp,wgp]=gauss2DT(dp)
%--------------------------------------------------------------------------
%
%   Calculate Gauss Point locations cgp(ngp) and weights wgp(ngp) 
%       for a 2D triangular area 
% 
%   ngp = no. of integration points
%   cgp(ngp,ndof)  = integration points coordinates
%   wgp(ngp)       = of integration points weights
%
%--------------------------------------------------------------------------

trifac=0.5;
switch dp
    case 1
        ngp=1;
        cgp(1,:)=[1/3 1/3];wgp(1)=1;
    case 2
        ngp=3;
        cgp(1,:)=[2/3 1/6];wgp(1)=1/3;
        cgp(2,:)=[1/6 1/6];wgp(2)=1/3;
        cgp(3,:)=[1/6 2/3];wgp(3)=1/3;
    case 3
        ngp=4;
        cgp(1,:)=[1/3 1/3];wgp(1)=-27/48;
        cgp(2,:)=[3/5 1/5];wgp(2)=25/48;
        cgp(3,:)=[1/5 1/5];wgp(3)=25/48;
        cgp(4,:)=[1/5 3/5];wgp(4)=25/48;
end
wgp = wgp*trifac;
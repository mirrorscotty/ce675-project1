function [ngp,cgp,wgp]=gauss2DQ(dp)
%--------------------------------------------------------------------------
%
%   Calculate Gauss Point locations cgp(ngp) and weights wgp(ngp) 
%       for a 2D quadrilateral area 
% 
%   ngp = no. of integration points
%   cgp(ngp,ndof)  = integration points coordinates
%   wgp(ngp)       = of integration points weights
%
%--------------------------------------------------------------------------

[c,w]=gaussL(dp);

ngp=0;
for i=1:dp
    for j=1:dp
        ngp=ngp+1;
        cgp(ngp,1)=c(i);
        cgp(ngp,2)=c(j);
        wgp(ngp)=w(i)*w(j);
    end
end

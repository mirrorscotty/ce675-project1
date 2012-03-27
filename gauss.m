function [ngp,cgp,wgp]=gauss(nnel,ndof)
%------------------------------------------------------------------------------
%
%   Calculate Gauss Point locations cgp(ngp,ndof) and weights wgp(ngp)
% 
%   ngp            = no. of integration points
%   cgp(ngp,ndof)  = integration points coordinates
%   wgp(ngp)       = of integration points weights
%
%------------------------------------------------------------------------------
switch ndof
case 2
    switch nnel
        case 3
            [ngp,cgp,wgp]=gauss2DT(1);
        case 6
            [ngp,cgp,wgp]=gauss2DT(2);
        case 4
            [ngp,cgp,wgp]=gauss2DQ(2);
        case 8
            [ngp,cgp,wgp]=gauss2DQ(3);
    end
case 3
    switch nnel
        case 4
            [ngp,cgp,wgp]=gauss3DT(1);
        case 10
            [ngp,cgp,wgp]=gauss3DT(2);
        case 8
            [ngp,cgp,wgp]=gauss3DQ(2);
    end
end

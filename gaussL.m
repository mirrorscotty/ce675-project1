function [cgp,wgp]=gaussL(nLgp)
%--------------------------------------------------------------------------
%
%   Calculate Gauss Point locations cgp(ngp) and weights wgp(ngp) 
%       for a line integral
% 
%   ngp = no. of integration points
%   cgp(ngp)       = integration points coordinates
%   wgp(ngp)       = of integration points weights
%
%--------------------------------------------------------------------------
switch nLgp
case 2
    cgp(1)=-1/sqrt(3);wgp(1)=1;
    cgp(2)= 1/sqrt(3);wgp(2)=1;
case 3
    cgp(1)=-sqrt(0.6);wgp(1)=5/9;
    cgp(2)= 0;        wgp(2)=8/9;
    cgp(3)= sqrt(0.6);wgp(3)=5/9;
case 4
    cgp(1)=-0.861136311594;wgp(1)=0.347854845137;
    cgp(2)=-0.339981043585;wgp(2)=0.652145154863;
    cgp(3)= 0.339981043585;wgp(3)=0.652145154863;
    cgp(4)= 0.861136311594;wgp(4)=0.347854845137;
case 5
    cgp(1)=-0.906179846;wgp(1)=0.236926885;
    cgp(2)=-0.53846931;wgp(2)=0.478628670;
    cgp(3)= 0;         wgp(3)=0.568888889;
    cgp(4)= 0.53846931;wgp(4)=0.478628679;
    cgp(5)= 0.906179846;wgp(5)=0.236926885;
case 6
    cgp(1)=-0.932469514;wgp(1)=0.171324492;
    cgp(2)=-0.661209386;wgp(2)=0.360761573;
    cgp(3)=-0.238619186;wgp(3)=0.467913935;
    cgp(4)= 0.238619186;wgp(4)=0.467913935;
    cgp(5)= 0.661209386;wgp(5)=0.360761573;
    cgp(6)= 0.932469514;wgp(6)=0.171324492;
end
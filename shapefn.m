function [Nz,dNz]=shapefn(zp,nnel,ndof)
%------------------------------------------------------------------------------
%
%   Calculate shape functions Nz and their derivatives dNz
%
%   zp(ndof) = isoparametric coordinates
%   nnel     = no. of nodes per element
%   ndof     = no. of degrees of freedom per node
%------------------------------------------------------------------------------
switch ndof
case 2
    z1=zp(1);z2=zp(2);
    switch nnel
    case 3
        Nz(1)=1-z1-z2;Nz(2)=z1;Nz(3)=z2;
        dNz=[-1 1 0
            -1 0 1];
    case 4
        z1i=[-1 1 1 -1];z2i=[-1 -1 1 1];
        for nn=1:nnel
            Nz(nn)=(1+z1*z1i(nn))*(1+z2*z2i(nn))/4;
            dNz(1,nn)=z1i(nn)*(1+z2*z2i(nn))/4;
            dNz(2,nn)=z2i(nn)*(1+z1*z1i(nn))/4;
        end
    case 8
        z1i=[-1 0 1 1 1 0 -1 -1];z2i=[-1 -1 -1 0 1 1 1 0];
        for nn=1:2:8
            Nz(nn)=(1+z1*z1i(nn))*(1+z2*z2i(nn))/4;
            dNz(1,nn)=z1i(nn)*(1+z2*z2i(nn))/4;
            dNz(2,nn)=z2i(nn)*(1+z1*z1i(nn))/4;
        end
        Nz(2)=(1-z1^2)*(1-z2)/2;dNz(1,2)=-z1*(1-z2);
        dNz(2,2)=-(1-z1^2)/2;
        Nz(4)=(1+z1)*(1-z2^2)/2;dNz(1,4)=(1-z2^2)/2;
        dNz(2,4)=-z2*(1+z1);
        Nz(6)=(1-z1^2)*(1+z2)/2;dNz(1,6)=-z1*(1+z2);
        dNz(2,6)=(1-z1^2)/2;
        Nz(8)=(1-z1)*(1-z2^2)/2;dNz(1,8)=-(1-z2^2)/2; 
        dNz(2,8)=-z2*(1-z1);
        
        Nz(1)=Nz(1)-(Nz(8)+Nz(2))/2; dNz(:,1)=dNz(:,1)-(dNz(:,8)+dNz(:,2))/2;
        Nz(3)=Nz(3)-(Nz(2)+Nz(4))/2; dNz(:,3)=dNz(:,3)-(dNz(:,2)+dNz(:,4))/2;
        Nz(5)=Nz(5)-(Nz(4)+Nz(6))/2; dNz(:,5)=dNz(:,5)-(dNz(:,4)+dNz(:,6))/2;
        Nz(7)=Nz(7)-(Nz(6)+Nz(8))/2; dNz(:,7)=dNz(:,7)-(dNz(:,6)+dNz(:,8))/2;
    otherwise
        disp('Shape functions not defined')
    end
otherwise
    switch nnel
    case 8
        z1i=[-1 1 1 -1 -1 1 1 -1];
        z2i=[-1 -1 1 1 -1 -1 1 1];
        z3i=[-1 -1 -1 -1 1 1 1 1];
        for nn=1:nnel
            Nz(nn)=(1+zp(1)*z1i(nn))*(1+zp(2)*z2i(nn))*(1+zp(3)*z3i(nn))/8;
            dNz(1,nn)=z1i(nn)*(1+zp(2)*z2i(nn))*(1+zp(3)*z3i(nn))/8;
            dNz(2,nn)=z2i(nn)*(1+zp(1)*z1i(nn))*(1+zp(3)*z3i(nn))/8;
            dNz(3,nn)=z3i(nn)*(1+zp(1)*z1i(nn))*(1+zp(2)*z2i(nn))/8;
        end
    otherwise
        disp('Shape functions not defined')
    end
end
function [F_int,K]=Stiff_L(plane_for,ndof,nnode,nsdof,X,nel,nodes,t,nnel_v,mat_set_v,mat_list,disp)


K=zeros(nsdof);F_int=zeros(nsdof,1);
%--------------------------------------------------------------------------
% Calculate Tangent Stiffness Matrix
%--------------------------------------------------------------------------
zp=zeros(ndof);
for el_no=1:nel
    mat_no = mat_set_v(el_no); 
    nnel = nnel_v(el_no); 
    
    [nnel,Xe,ii] = localize(el_no,X,nodes,nnel_v,ndof); xe=zeros(nnel,ndof);
    [ngp,cgp,wgp]=gauss(nnel,ndof);
    
    ue=disp(ii); for i=1:nnel, xe(i,:)=Xe(i,:)+ue(2*i-1:2*i)'; end

    Ke=zeros(nnel*ndof);
    B=zeros(3,nnel*ndof);
    
    C = mat_list(mat_no,1); nu = mat_list(mat_no,2);
    b = C/(1+nu);
    if plane_for == 'plane_stress', a = C*nu/(1-nu^2); else a = C/(1-2*nu)/(1+nu); end

    for ip=1:ngp
        zp=cgp(ip,:);
        [Nz,dNz]=shapefn(zp,nnel,ndof);
        dXz_T=dNz*Xe;       % transpose(DX/Dz)
        dXzi_T=dXz_T^(-1);  % transpose(Dz/DX)
        JX=det(dXz_T);
        
        DNe=dXzi_T*dNz;        
        F_T=DNe*xe; F=F_T';   J=det(F);
        C = F_T*F; E = .5*(C - eye(ndof));
        S= a*trace(E)*eye(ndof)+b*E;
        
        f0 = zeros(ndof*nnel,1); k0=zeros(ndof*nnel);
        for i=1:nnel
            i_start = ndof*(i-1)+1; i_end = ndof*i;

            DNi=DNe(:,i);
            f0(i_start:i_end,1)=F*S*DNi;
            
            for j=1:nnel
                j_start = ndof*(j-1)+1; j_end = ndof*j;

                DNj=DNe(:,j);
                gamma = DNi'*DNj;
                gamma_s = DNi'*S*DNj;
                T = F*DNi*DNj'*F';
                
                k0(i_start:i_end,j_start:j_end)= a*T+.5*b*T'+.5*b*gamma*F*F'+gamma_s*eye(ndof);
            end
        end
        f0=f0.*t.*JX.*wgp(ip);
        F_int(ii)=F_int(ii)+f0;
        
        k0=k0.*t.*JX.*wgp(ip);
        K(ii,ii)=K(ii,ii)+k0;
    end
end

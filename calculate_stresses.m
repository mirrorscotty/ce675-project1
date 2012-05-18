function [stress_plot]=calculate_stresses(plane_for,ndof,nnode,nsdof,X,disp,nel,nnel_v,nodes,t,mat_set_v,mat_list)

stress_plot= zeros(4,nnode); 

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

    zp_list = get_zn_list(nnel,ndof);
    
    for ip=1:nnel
        node = nodes(el_no,ip);
        zp=zp_list(ip,:);
        [Nz,dNz]=shapefn(zp,nnel,ndof);
        dXz_T=dNz*Xe;       % transpose(DX/Dz)
        dXzi_T=dXz_T^(-1);  % transpose(Dz/DX)
        JX=det(dXz_T);
        
        DNe=dXzi_T*dNz;        
        F_T=DNe*xe; F=F_T';   J=det(F);
        C = F_T*F; E = .5*(C - eye(ndof));
        S= a*trace(E)*eye(ndof)+b*E;
        cauchy = 1/J*F*S*F_T;
               
        stress_vec = [cauchy(1,1);cauchy(2,2);cauchy(1,2)];
        stress_plot(1:3,node)=stress_plot(1:3,node)+stress_vec;
        stress_plot(4,node)=stress_plot(4,node)+1;
        
    end
    %Ke
end


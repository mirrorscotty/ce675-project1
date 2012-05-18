function []=draw_elem(iel,nnel_v,nodes,nnode,ndof,x)

    nnel = nnel_v(iel); 
    
    [nnel,xe,ii] = localize(iel,x,nodes,nnel_v,ndof);

    np=0;strt_p = 1;end_p = -1;stp = -0.1;
    for val_dof = -1:2:1
        for j=1:ndof
            for k=strt_p:stp:end_p;
                np = np+1;
                zp = k*ones(ndof,1);
                zp(j) = val_dof;
                [Nz,dNz]=shapefn(zp,nnel,ndof);
                xp = xe'*Nz';
                dn(:,np)=xp;
            end
            strt_p = -strt_p;end_p = -end_p;stp = -stp;
        end
        strt_p = -strt_p;end_p = -end_p;stp = -stp;
    end
    plot(dn(1,:),dn(2,:),'LineWidth',2);

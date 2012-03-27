function []=draw_deflected_shape(X,U,X_enr,U_enr,nnode,nel,nnel_v,nodes,ndof,con_data_list,con_elm_list,con_elm_id,ifenrich)
%--------------------------------------------------------------------------
% 2D Animation
%--------------------------------------------------------------------------
sc=1;
hold on, cla, axis equal

U_sc = sc*U; U_enr_sc = sc*U_enr;

for n=1:nnode
    x(n,:) = X(n,:)+U_sc(ndof*(n-1)+1:ndof*n)';
    %text(x(n,1),x(n,2),int2str(n),'FontSize',8)
end

x_enr = [];
for n=1:size(X_enr,1)
    x_enr(n,:) = X_enr(n,:) + U_enr_sc(ndof*(n-1)+1:ndof*n)';
end
    nL1 = 15; nL2 = 12; nL3 = 15;nH1=2; nH2=1; nH3=2;

for iel=1:nL1*nH1
    %if iel<=10, r='b', else r='r', end
    draw_elem(iel,nnel_v,nnode,ndof,nodes,x,X,x_enr,X_enr,con_elm_id,con_elm_list,con_data_list,ifenrich,'b')
    %for i=1:abs(nnel_v(iel)), n=nodes(iel,i); text(x(n,1),x(n,2),int2str(n),'FontSize',8),end
end
for iel=nL1*nH1+nL2*nH2+1:nel
    %if iel<=10, r='b', else r='r', end
    draw_elem(iel,nnel_v,nnode,ndof,nodes,x,X,x_enr,X_enr,con_elm_id,con_elm_list,con_data_list,ifenrich,'b')
    %for i=1:abs(nnel_v(iel)), n=nodes(iel,i); text(x(n,1),x(n,2),int2str(n),'FontSize',8),end
end
for iel=nL1*nH1+1:nL1*nH1+nL2*nH2
    %if iel<=10, r='b', else r='r', end
    draw_elem(iel,nnel_v,nnode,ndof,nodes,x,X,x_enr,X_enr,con_elm_id,con_elm_list,con_data_list,ifenrich,'r')
    %for i=1:abs(nnel_v(iel)), n=nodes(iel,i); text(x(n,1),x(n,2),int2str(n),'FontSize',8),end
end

[maxx,maxy]= max(x);
[minx,miny]= min(x);
minx=minx-1;miny=miny-1;maxx=maxx+1;maxy=maxy+1;
% pause(0.1)
axis([-2 10.5 -0.5 4.5]), axis equal, axis off
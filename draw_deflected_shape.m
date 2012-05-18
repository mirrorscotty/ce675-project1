function [x_plot,plot_axes]=draw_deflected_shape(X,U,nnode,nel,nnel_v,nodes,ndof)
%--------------------------------------------------------------------------
% 2D Animation
%--------------------------------------------------------------------------
sc=1; % scaling
hold on, cla, axis equal

U_sc = sc*U; 

for n=1:nnode
    x_plot(n,:) = X(n,:)+U_sc(ndof*(n-1)+1:ndof*n)';
    text(x_plot(n,1),x_plot(n,2),int2str(n),'FontSize',8)
end

for iel=1:nel
    draw_elem(iel,nnel_v,nodes,nnode,ndof,x_plot);
end

[maxx]= max(x_plot);
[minx]= min(x_plot);
delta_x=maxx-minx;
minx=minx-.1*delta_x;
maxx=maxx+.1*delta_x;
plot_axes=[minx(1) maxx(1) minx(2) maxx(2)];
axis(plot_axes), axis equal%, axis off
function []=post_process(plane_for,ndof,nnode,nsdof,X,disp,nel,nnel_v,nodes,t,mat_set_v,mat_list)


figure;[x_plot,plot_axes]=draw_deflected_shape(X,disp,nnode,nel,nnel_v,nodes,ndof);
title('deformed configuration')

[stress_plot]=calculate_stresses(plane_for,ndof,nnode,nsdof,X,disp,nel,nnel_v,nodes,t,mat_set_v,mat_list);

for i=1:nnode,stress_plot(1:3,i)=stress_plot(1:3,i)./stress_plot(4,i); end

%figure; clf;

figure;%subplot(3,1,1);
patch('Vertices',x_plot,'Faces',nodes,'FaceVertexCData',stress_plot(1,:)','FaceColor','interp','EdgeColor','interp');
xlabel('x_1');ylabel('x_2');title('\sigma_1_1')
hold on; axis equal ; axis(plot_axes); colorbar; 
figure;%subplot(3,1,2);
patch('Vertices',x_plot,'Faces',nodes,'FaceVertexCData',stress_plot(2,:)','FaceColor','interp','EdgeColor','interp');
xlabel('x_1');ylabel('x_2');title('\sigma_2_2')
hold on; axis equal ; axis(plot_axes); colorbar; 
figure;%subplot(3,1,3);
patch('Vertices',x_plot,'Faces',nodes,'FaceVertexCData',stress_plot(3,:)','FaceColor','interp','EdgeColor','interp');
xlabel('x_1');ylabel('x_2');title('\sigma_1_2')
hold on; axis equal ; axis(plot_axes); colorbar; 
stress_plot= zeros(4,nnode); 




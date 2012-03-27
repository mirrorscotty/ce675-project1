function [X, nodes] = createmeshQ4 (L, H, nL, nH)
%--------------------------------------------------------------------------
%
%   Discretize a 2D rectangular domain into a regular mesh of Q4 elements
% 
%   L,H = dimensions of rectangular domain
%   nL,nH= no. of elements in each direction
%
%--------------------------------------------------------------------------

stepL = L/nL;
stepH = H/nH;
%
%   generate nodes
%
k=0;
for i=1:nH+1
    yc=(i-1)*stepH;
    for j=1:nL+1
        xc=(j-1)*stepL;
        
        k=k+1;%,xc,yc
        X(k,1)=xc; X(k,2)=yc;
    end
end
%
%   generate elements
%
k=0;
for i=1:nH
    addnodes =(i-1)*(nL+1);
    for j=1:nL
        
        k=k+1;
        current_node= addnodes+j;
        nodes(k,1)= current_node;
        nodes(k,2)=current_node+1;
        nodes(k,4)=current_node+nL+1;
        nodes(k,3)=current_node+nL+2;
    end
end
return
function [nnel,Xe,ii] = localize(el_no,X,nodes,nnel_v,ndof)
%------------------------------------------------------------------------------
%
%   Retrieve element properties
%
%   nnel     = no. of nodes in the element
%   Xe       = Matrix of element nodal coordinates
%   ii       = element degrees of freedom pointer
%------------------------------------------------------------------------------

nnel=nnel_v(el_no);
ii=zeros(ndof*nnel,1);Xe = zeros(nnel,ndof);

for i=1:nnel
    node_no=nodes(el_no,i);      Xe(i,:) = X(node_no,:);
    ii(2*i-1) = 2*node_no-1;     ii(2*i) = 2*node_no;
end

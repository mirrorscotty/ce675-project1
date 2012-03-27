function [D]=linear_material_tangent(plane_for,mat_no,mat_list)

%------------------------------------------------------------------------------
%
%   Compute material tangent
%
%------------------------------------------------------------------------------
E = mat_list(mat_no,1); nu = mat_list(mat_no,2);

if plane_for == 'plane_stress'
   D=[1 nu 0
      nu 1 0
      0 0 0.5*(1-nu)];
   D=D.*E/(1-nu^2);
else
   D=[1-nu nu 0
      nu 1-nu 0
      0 0 0.5*(1-2*nu)];
   D=D.*E/(1+nu)/(1-2*nu);
end

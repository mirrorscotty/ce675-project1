function [res_bcs] = bc_residual(disp,nbcs,bcdof,bcval)

res_bcs= zeros(nbcs,1);

for i = 1:nbcs
    n = bcdof(i);
    res_bcs(i)=disp(n)-bcval(i);
end
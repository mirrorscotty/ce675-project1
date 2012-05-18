function zn_list = get_zn_list(nnel,ndof)

switch ndof
    case 2
        switch nnel
            case 4
                zn_list =[-1 -1;1 -1; 1 1; -1 1];
            case 8
                zn_list =[-1 -1;0 -1;1 -1; 1 0;1 1; 0 1;-1 1;-1 0];
            case 5
                zn_list =[-1 -1;1 -1; 1 1; -1 1; 0 1];
            case -5
                zn_list =[-1 -1;1 -1; 1 1; -1 1; 0 -1];
        end
end
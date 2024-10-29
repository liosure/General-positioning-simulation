function Pos = cell_rand_pos_gen(Pos_slec_vec,r,r_cell)
% Uniform pick pos in one cell 
% Pos_slec_vec is pre_input location of the vertex in one cell
% r is the radius of the random point
    Area_slec = randi([0,5],1,1);
    r1 = rand();
    r2 = rand();
    if r1 + r2 > 1
        r1 = 1 - r1;
        r2 = 1 - r2;
    end
    Pos = Pos_slec_vec(1,:) + r1*Pos_slec_vec(Area_slec+2,:)*r/r_cell + r2*Pos_slec_vec(Area_slec+3,:)*r/r_cell;
    P_slec = 2*randi(2,1)-3;
    Pos = Pos + [P_slec*sqrt(3)*r/2,r/2,0] ;
end


function Pos_ant = UPA(Pos, Spacing, Num_ant, dire)
    Spacing_v = Spacing(1);
    Spacing_h = Spacing(2);
    Num_v = Num_ant(1);
    Num_h = Num_ant(2);
    Dire_ant = dire+90;
    Pos_ant = Pos + kron(ones(Num_h,1),(0:Num_v-1)'*[sin(Dire_ant/180*pi), cos(Dire_ant/180*pi),0]*Spacing_v)...
        + kron((0:Num_h-1)'*[0,0,Spacing_h],ones(Num_v,1));

end


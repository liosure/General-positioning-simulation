function Pos_ant = LA(Pos, Spacing, Num_ant, dire)
    Spacing_v = Spacing(1);
    Spacing_h = Spacing(2);
    Num_v = Num_ant(1);
    Num_h = Num_ant(2);
    Dire_ant = dire+90;
    Pos_ant = Pos + [(0:Num_v-1)'*[sin(Dire_ant/180*pi), cos(Dire_ant/180*pi),0]*Spacing_v;zeros(Num_h,3)]...
        + [zeros(Num_v,3); (0:Num_h-1)'*[0,0,Spacing_h]];
end


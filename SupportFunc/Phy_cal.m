function [r, azi, ele] = Phy_cal(pos_de,pos_arr,Num_ant_de, Num_ant_arr)
%PHY_CAL  calculate 2 the distance between two targets and the azimuth /
        pos_diff = kron(ones(Num_ant_de,1),pos_arr)-kron(pos_de,ones(Num_ant_arr,1));
        r = sqrt(sum(abs(pos_diff).^2, 2));
        azi = atan(pos_diff(:,2)./pos_diff(:,1))+(1-ceil((sign(pos_diff(:,1))+1)/2))*pi...
            -(1-ceil((sign(pos_diff(1))+1)/2)).*(1-ceil((sign(pos_diff(1))+1)/2))*2*pi;
        ele = pos_diff(:,3)./sqrt(pos_diff(:,2).^2+pos_diff(:,1).^2);
end


classdef Chl
    %CHANNEL 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
    end
    
    methods(Static)
        function CSI_LoS = Los(tx,rx,c,fc_DL, fc_UL, fd)
            [r,azi,ele] = Phy_cal(tx.Ant_pos,rx.Ant_pos,tx.Num_trans_ant,rx.Num_rec_ant);
            PL_DL = sqrt(c*tx.G_t*rx.G_r/fc_DL./r.^2);
            PL_UL = sqrt(c*tx.G_t*rx.G_r/fc_UL./r.^2);
            del = r/c;
            dop = v/c*fc;
            
            CSI_LoS = {TF_chl, PL, del, dop, azi, ele};
        end
        
        function CSI_Ref = Ref(tx,blk)
            %Reflection RF chain  generation
            [r,azi,ele] = Phy_cal(tx.Ant_pos,blk.Ant_pos,tx.Num_trans_ant,1);
            PL = sqrt(c*G_t*G_r/fc./r.^2);
            del = r/c;
            dop = v/c*fc;
            CSI_Ref = {Tap_chl, TF_chl, PL, del, dop, azi, ele};
        end
        
        function CSI_BD = Bdr(tx,bd)
            %Reflection RF chain  generation
            [r,azi,ele] = Phy_cal_tx_rx(tx.Ant_pos,bd.Ant_pos,tx.Num_trans_ant,bd.Num_ref_ant);
            PL = sqrt(c*G_t*G_r/fc./r.^2);
            del = r/c;
            dop = v/c*fc;
            CSI_BD = {Tap_chl, TF_chl, PL, del, dop, azi, ele};
        end
    end
end


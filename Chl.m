classdef Chl
    %CHANNEL 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
    end
    
    methods(Static)
        function CSI_LoS = Los(tx,rx,c,fc,fd)
            [r,azi,ele] = Phy_cal(tx.pos,rx.pos);
            PL = sqrt(*G_t*G_r/r^2)
            del = r/c;
            dop = v/c*fc;
            
            
            CSI_LoS = {Tap_chl, TF_chl, del, dop, azi, ele};
        end
        
        function CHL_Ref = Ref(tx,rx,blk)
            %Reflection RF chain  generation
            CHL_Ref = tx - blk - rx;
        end
        
        function CHL_BD = Bdr(tx,rx,bd)
            %Reflection RF chain  generation
            CHL_BD = tx - bd - rx;
        end
    end
end


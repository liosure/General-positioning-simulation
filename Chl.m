classdef Chl
    %CHANNEL �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
    end
    
    methods(Static)
        function CHL_LoS = Los(tx,rx,c,fc,fd)
            [r,azi,ele] = Phy_cal(tx.pos,rx.pos);
            PL = sqrt()
            del = r/c;
            dop = 
            
            
            CHL_LoS = tx-rx;
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


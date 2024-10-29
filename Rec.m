classdef Rec
    %RECEIVER �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        Num_rec_ant
        Num_rec_ant_type
        Num_sym
        Num_subc
        Prop
        Loc
        Sig
        Marker_map
        Color_map
    end
    
    methods
        function obj = Rec(NRA,NSC,NS,LOC,Pro)
            obj.Num_rec_ant = cell2mat(NRA(1));
            obj.Num_rec_ant_type = cell2mat(NRA(2));
            obj.Num_subc = NSC;
            obj.Num_sym = NS;
            obj.Loc = LOC;
            obj.Prop = Pro;
            obj.Marker_map = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.Marker_map('BS')='s';
            obj.Marker_map('UE')='x';
            obj.Color_map = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.Color_map('BS')=[1 0 0];
            obj.Color_map('UE')=[2/3 0 1/3];
        end
        
        function obj = Sig_rec(obj,sig_inc,RBF)
            obj.Sig = RBF'*sig_inc;
        end
        
        function obj = Chl_est(obj)
            %�ŵ����ƣ���ѡ����
        end
        
        function obj = Tdata_demod(obj,varargin)
            %����·ͨ��
        end
        
        function obj = BD_demod(obj)
            %����·ͨ��            
        end
        
        function obj = Par_est(obj)
            %����·ͨ��            
        end
        
        function disp2d(obj,fig)
            figure(fig);
            plot(obj.Loc(1),obj.Loc(2),'Marker',obj.Marker_map(obj.Prop),...
                'LineStyle','none','Color', obj.Color_map(obj.Prop));

        end
        
        function disp3d(obj,fig)
            figure(fig);
            plot3(obj.Loc(1),obj.Loc(2),obj.Loc(3),'Marker',obj.Marker_map(obj.Prop),...
                'LineStyle','none','Color',obj.Color_map(obj.Prop));        
        end
        
        function cell_plot(obj,fig)
            figure(fig)
            theta = linspace(pi/2, 2.5*pi, 7);
            r = sqrt(4/3) * 250;
            x = obj.Loc(1) + r * cos(theta); % x ����
            y = obj.Loc(2) + r * sin(theta); % y ����
            plot(x, y, 'c:', 'LineWidth', 1.5);
        end
    end
end


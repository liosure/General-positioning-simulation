classdef Rec
    %RECEIVER 此处显示有关此类的摘要
    %   此处显示详细说明
    
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
        Ant_pos
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
            %信道估计，可选方法
        end
        
        function obj = Tdata_demod(obj,varargin)
            %主链路通信
        end
        
        function obj = BD_demod(obj)
            %主链路通信            
        end
        
        function obj = Par_est(obj)
            %主链路通信            
        end
        
        function obj = Ant_gen_TX(obj, spacing,opt)
            Num_array = opt{1};
            if Num_array == 1
                varargin = opt{2};
                obj.Ant_pos = feval(obj.Num_rec_ant_type, obj.Loc, spacing, obj.Num_rec_ant, varargin);
            elseif Num_array ==2
                varargin = opt{2};
                obj.Ant_pos(:,:,1) = feval(obj.Num_rec_ant_type, obj.Loc, spacing, obj.Num_rec_ant, varargin);
                varargin = opt{3};
                obj.Ant_pos(:,:,2) = feval(obj.Num_rec_ant_type, obj.Loc, spacing, obj.Num_rec_ant, varargin);
            end
        end
        
        function obj = Ant_gen(obj, spacing,opt)
            obj.Ant_pos = feval(obj.Num_rec_ant_type, obj.Loc, spacing, obj.Num_rec_ant, opt);
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
            x = obj.Loc(1) + r * cos(theta); % x 坐标
            y = obj.Loc(2) + r * sin(theta); % y 坐标
            plot(x, y, 'c:', 'LineWidth', 1.5);
        end
    end
end


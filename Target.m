classdef Target
    %Target 此处显示有关此类的摘要
    %   
    
    properties
        Loc
        Rcs
        Vel
        Trace
        Num_clt
        %角拓展？
    end
    
    methods
        function obj = Target(Loc_init,Rcs_init,Clt)
            obj.Loc = Loc_init';
            obj.Rcs = Rcs_init;
            obj.Num_clt = Clt;
        end
        
        function obj = Gss_clt_gen(obj, Rad, s_rcs) 
            sigma = Rad/3;
            temp_loc = obj.Loc;
            obj.Loc = zeros(3, obj.Num_clt);
            obj.Loc(:,1) = temp_loc;
            obj.Loc(:,2:end) = temp_loc+sigma/sqrt(3)*randn(3,obj.Num_clt-1);
            temp_rcs = obj.Rcs;
            obj.Rcs = zeros(obj.Num_clt, 1);
            obj.Rcs(1) = temp_rcs;
            obj.Rcs(2:end) = sqrt(s_rcs/2)*rand(obj.Num_clt-1,1)+1j*sqrt(s_rcs/2)*rand(obj.Num_clt-1,1);
        end
        
        function obj = Trace_gen(obj, vel,sim_time,Time_step)
            obj.Vel = vel;
            obj.Trace = zeros(3,obj.Num_clt,sim_time);
            obj.Trace(:,:,1) = obj.Loc;
            for time = 2:sim_time
                obj.Trace(:,:,time) = vel*Time_step + obj.Trace(time-1);
            end
        end
        
        function disp2d(obj, fig, varargin)
            if isempty(varargin)
                marker = 'o';
                CLR = [0 0 0];
                markersize = 4;
            else
                marker = cell2mat(varargin(1));
                CLR = cell2mat(varargin(2));
                markersize = cell2mat(varargin(3));
            end
            figure(fig);
            for clt_id = 1:obj.Num_clt
                plot(obj.Loc(1,clt_id),obj.Loc(2,clt_id),'Marker',marker,...
                    'LineStyle','none','Color',CLR,'Markersize',markersize);
                drawnow
            end
        end
        
        function disp3d(obj, fig, varargin)
            if isempty(varargin)
                marker = 'o';
                CLR = [0 0 0];
                markersize = 4;
            else
                marker = cell2mat(varargin(1));
                CLR = cell2mat(varargin(2));
                markersize = cell2mat(varargin(3));
            end
            figure(fig);
            for clt_id = 1:obj.Num_clt
                plot3(obj.Loc(1,clt_id),obj.Loc(2,clt_id),obj.Loc(3,clt_id),...
                    'Marker',marker,'LineStyle','none','Color',CLR,...
                    'Markersize',markersize);
                drawnow
            end
        end
    end
end


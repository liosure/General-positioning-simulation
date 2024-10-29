classdef Transmiter
    %TRANSMIT 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        Num_trans_ant %发射天线数
        Num_trans_ant_type
        Ant_pos
        Num_subc
        Num_sym
        X_data
        Loc
    end
    
    methods
        function obj = Transmiter(NTA,NSC,NS,LC)
            %初始化TRANSMITER, 包括发射天线数，载波数，符号数，位置
            obj.Num_trans_ant = cell2mat(NTA(1));
            obj.Num_trans_ant_type = cell2mat(NTA(2));
            obj.Num_subc = NSC;
            obj.Num_sym = NS;
            obj.Loc = LC;
            obj.Ant_pos = 
        end
        
        function obj = Data_generate(obj,varargin)
            %1-4个输入，分别为调制种类（字符串函数名或句柄）
            if ~exist('varargin','var')
                disp('Method "Transmiter.Data_generate" needs at least one input parameters')
                pause()
            else
                Var_num = numel(varargin);
                SMS_method = cell2mat(varargin(1)); % symbol mapping scheme
                order = 4;
                UAP_flag = true;
                par_addition=[];
                switch Var_num
                    case 2
                        order = cell2mat(varargin(2));
                    case 3
                        order = cell2mat(varargin(2));
                        UAP_flag = cell2mat(varargin(3));
                    case 4
                        order = cell2mat(varargin(2));
                        UAP_flag = cell2mat(varargin(3));
                        par_addition = cell2mat(varargin(4));
                end
                Num_t = obj.Num_subc * obj.Num_sym;
                data_dec = randi([0 order-1],Num_t,1);
                if ischar(SMS_method)
                    obj.X_data = reshape(feval(SMS_method, data_dec, order, ...
                        par_addition,'UnitAveragePower',UAP_flag),[obj.Num_subc,obj.Num_sym]);
                else
                    obj.X_data = reshape(SMS_method(data_dec, order, ...
                        par_addition,'UnitAveragePower',UAP_flag),[obj.Num_subc,obj.Num_sym]);
                end
            end
        end
        
        function st = Signal_generate(obj,vargin)
            % 输入参数为0-4个，由cp长度，导频类型，是否otfs调制，是否reduced-cp结构组成
            % 下为缺省量
            OTFS_flag = false;
            Plt_func = [];
            Len_cp = obj.Num_subc/8;
            RECP_flag = false;
            
            if exist('vargin','var')
                switch numel(vargin)
                    case 1
                        Len_cp = vargin(1);
                    case 2
                        Len_cp = vargin(1);
                        Plt_func = vargin(2);
                    case 3
                        Len_cp = vargin(1);
                        Plt_func = vargin(2);
                        OTFS_flag = vargin(3);
                    case 4
                        Len_cp = vargin(1);
                        Plt_func = vargin(2);
                        OTFS_flag = vargin(3);
                        RECP_flag = vargin(4);
                end
            end
            
            if OTFS_flag 
                data = sqrt(obj.Num_sym)*fft(1/sqrt(obj.Num_subc)*...
                    ifft(obj.X_data,obj.Num_subc,1),obj.Num_sym,2);
            else
                data = obj.X_data;
            end
            
            if ~isempty(Plt_func)
                if ischar(Plt_func)
                    data = feval(Plt_func,data);
                else
                    data = Plt_func(data);
                end
            end
            
            if ~RECP_flag
                CP_mat = [zeros(Len_cp,obj.Num_subc-Len_cp),...
                    eye(Len_cp);eye(obj.Num_subc)];
                st = reshape( CP_mat*1/sqrt(obj.Num_subc)*fft(data),...
                    [(obj.Num_subc+Len_cp) * obj.Num_sym,1]);
            else
                CP_mat = [zeros(Len_cp,obj.Num_subc*obj.Num_subc-Len_cp),...
                    eye(Len_cp);eye(obj.Num_subc * obj.Num_subc)];
                st = CP_mat*reshape(1/sqrt(obj.Num_subc)*fft(data),...
                [(obj.Num_subc) * obj.Num_sym,1]);
            end
            
        end
        
        function Trans_BF = Beam_forming(BFtype,CHL,noise)
            Trans_BF = feval(BFtype,CHL,noise);
        end
        
        function disp2d(obj,fig)
            figure(fig);
            axes1 = axes('Parent',fig);
            hold(axes1,'on');
            plot(obj.Loc(1),obj.Loc(2),'Marker','^','LineStyle','none','Color',[0 0 1]);
            box(axes1,'on');
        end
        
        function disp3d(obj,fig)
            figure(fig);         
            axes1 = axes('Parent',fig);
            hold(axes1,'on');    
            plot3(obj.Loc(1),obj.Loc(2),obj.Loc(3),'Marker','^','LineStyle','none','Color',[0 0 1]);
            view(axes1,[-37.5 30]);
            
        end
        
        function cell_plot(obj,fig,r)
            figure(fig)
            theta = linspace(pi/2, 2.5*pi, 7);
            x = obj.Loc(1) + [sqrt(3)*r/2 + r * cos(theta), -sqrt(3)*r/2 + r * cos(theta([6:7,1:5]))]; % x 坐标
            y = obj.Loc(2) + [r/2 +  r * sin(theta), r/2 +  r * sin(theta([6:7,1:5]))]; % y 坐标
            plot(x, y, 'c:', 'LineWidth', 1.5);
        end
    end
end


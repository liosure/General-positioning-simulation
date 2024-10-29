classdef Backcom < Target
    %BACKCOM 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        Sym_bd
        Bias_bd
        Sig_bd
        Ref_coef
        Prcs_delay
    end
    
    methods
        function obj = Backcom(ref, Delay, Target, BA)
            obj.Loc = Target.Loc;
            obj.Prcs_delay = Delay;
            obj.Ref_coef = ref;
            
        end
        
        function obj = Ant_gen(obj, spacing,opt)
            obj.Ant_pos = feval(obj.Num_bc_ant_type, obj.Loc, spacing, obj.Num_bc_ant, opt);
        end
        
        function obj = BD_sig_gen(obj,tx,varargin)
            obj.Sym_bd = 2*randi([0,1],tx.Num_subc,obj.Num_clt)-1; 
            if ~isempty(varargin)
                pilot = cell2mat(varargin(1));
                para = varargin(2);
                obj.Sym_bd = feval(pilot,para);
            end
        end
        
        function obj = Waveform(obj,wave_mat)
            idx_o = obj.Sym_bd == 1;
            idx_z = obj.Sym_bd == -1;
            obj.Sig_bd = kron(obj.Sym_bd(idx_o),wave_mat(:,1))+kron(obj.Sym_bd(idx_z),wave_mat(:,2));
        end
    end
end


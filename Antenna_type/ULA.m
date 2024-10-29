function Pos_ant = ULA(Pos, Spacing, Num, varargin)
%ULA generate the position for a ULA.
    if isempty(varargin)
        varargin(1) = {'v'};
    end
    if iscell(varargin(1))
        varargin = varargin{1};
    end
    dire = cell2mat(varargin(1));
    if dire == 'h'
        if numel(varargin)==1
            varargin(2) = {0};
        end
        Dire_ant = cell2mat(varargin(2))+90;
        Pos_ant = Pos + (0:Num-1)'*[sin(Dire_ant/180*pi), cos(Dire_ant/180*pi),0]*Spacing;
    elseif dire == 'v'
        Pos_ant = Pos + (0:Num-1)'*[0,0,Spacing];
    else
         disp('Error input direction.')
    end
end


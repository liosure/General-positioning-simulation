function BF_mrt = MRT(CHL,~)
%MRT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    norms = sqrt(sum(abs(CHL).^2, 1));
    BF_mrt = CHL'./norms;
end


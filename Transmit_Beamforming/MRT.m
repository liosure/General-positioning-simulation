function BF_mrt = MRT(CHL,~)
%MRT 此处显示有关此函数的摘要
%   此处显示详细说明
    norms = sqrt(sum(abs(CHL).^2, 1));
    BF_mrt = CHL'./norms;
end


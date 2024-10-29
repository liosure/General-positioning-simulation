function w_mmse = MMSE(CHL, Rn)
    % 输入：
    % CHL - 信道矩阵 (Nr x Nt), Nr 是接收天线数，Nt 是发射天线数
    % Rn   - 噪声，干扰的协方差矩阵
    
    % 输出：
    % w_mmse - MMSE波束赋形权重向量 (Nt x 1)
    % 假设噪声协方差矩阵是单位矩阵乘以噪声功率
    % 计算MMSE权重：
    w_mmse = (CHL' * (CHL * CHL' + Rn)^(-1) * desired_signal) / ...
             (desired_signal' * (CHL * CHL' + Rn)^(-1) * desired_signal);
end



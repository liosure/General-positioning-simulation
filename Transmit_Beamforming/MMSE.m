function w_mmse = MMSE(CHL, Rn)
    % ���룺
    % CHL - �ŵ����� (Nr x Nt), Nr �ǽ�����������Nt �Ƿ���������
    % Rn   - ���������ŵ�Э�������
    
    % �����
    % w_mmse - MMSE��������Ȩ������ (Nt x 1)
    % ��������Э��������ǵ�λ���������������
    % ����MMSEȨ�أ�
    w_mmse = (CHL' * (CHL * CHL' + Rn)^(-1) * desired_signal) / ...
             (desired_signal' * (CHL * CHL' + Rn)^(-1) * desired_signal);
end



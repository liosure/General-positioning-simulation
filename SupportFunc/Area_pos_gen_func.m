function pos_vec = Area_pos_gen_func(cent_pos,r)
%AREA_POS_GEN_FUNC �˴���ʾ�йش˺�����ժҪ
            pos_vec = [cent_pos;[real(r*exp(1j*(2*pi/6.*(0:6)-pi/12).')),imag(r*exp(1j*(2*pi/6.*(0:6)-pi/12).')),zeros(7,1)]];
end


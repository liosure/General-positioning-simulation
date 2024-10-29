close all;
clear all;
allpath = genpath(pwd);
addpath(allpath);
%% initial parameter
for i = 1
    %% Physic parameter
    c = 3e8; fc = 5.5e9; fd = 8*1.5e4;
    %% system_configuration
    Num_BS = 4; cell_num = floor(Num_BS/2); R_cell = 250;
    CP_len = 16; M_order = 16; %CP长度，调制阶数
    Num_ta = {32,'ULA',{cell_num,{'h',30},{'h',150}}}; Num_subc = 128; Num_sym = 64;
    BW = Num_subc*128*fd; T_t = (Num_subc+CP_len)/BW; TW = (Num_subc+CP_len)/BW*Num_sym;% 基本参数
    Num_user = 4; Num_clt = 20;Num_uav_clt = 2;Uav_clt = [8,10];
    %BS 2 - 6 % 用户数 % 环境障碍物 % 无人机集群数 % 各集群无人机数目
    Num_ra_bs = {32,'ULA'};Num_ra_ue = {4,'ULA'};  %BS 32R 用户 4R
    BS_pos = [[0,0,0];[real(sqrt(3)*R_cell*exp(1j*2*pi/6.*(0:5).')),imag(sqrt(3)*R_cell*exp(1j*2*pi/6.*(0:5).')),zeros(6,1)]];
    Pos_slec_vec = Area_pos_gen_func([0,0,0],sqrt(3)*R_cell/2); direcion = [150, 270, 270, 30];
    Sim_t = 64; Time_step = T_t; P_rcs = 1; Ant_spc = 0.5*c/fc; %Antenna Spacing
    %% simulation setup
    f_sys2d = figure(1);
    f_sys3d = figure(2);
end

%% Class generation
for i = 1
    %% Tx % 初始化TRANSMITER, 依次为发射天线数，载波数，符号数，位置
    Tx = Transmiter(Num_ta,Num_subc,Num_sym,[0,0,0]); 
    BF = ones(Tx.Num_trans_ant,1); %预分配内存使用的临时变量
    Tx = Tx.Data_generate('qammod',M_order,true,'gray');
    size_st = size(BF*Tx.Signal_generate(4+CP_len).');
    st = zeros(size_st);
    st_indiv = zeros([size_st,Num_user]);

    %% Rx
    % BS/Radar rec
    for bs_idx = 0:Num_BS
        BS(bs_idx+1) = Rec(Num_ra_bs,Num_subc,Num_sym,BS_pos(bs_idx+1,:),'BS');
    end

    % User
    for ue_idx = 1:Num_user
        UE_pos = cell_rand_pos_gen(Pos_slec_vec,200,R_cell, cell_num); 
        UE(ue_idx) = Rec(Num_ra_bs,Num_subc,Num_sym,UE_pos,'UE');
    end

    %% Target
    %ground clutter
    % 生成均匀随机数

    for tar_idx = 1:Num_clt
        Loc_clt = cell_rand_pos_gen(Pos_slec_vec,200,R_cell, cell_num);%fix
        T(tar_idx) = Target(Loc_clt,sqrt(P_rcs/2)*(randn()+1j*randn()),1);
    end

    for uav_idx = 1:Num_uav_clt
        Loc_clt = cell_rand_pos_gen(Pos_slec_vec,200,R_cell, cell_num); %fix
        Loc_clt(3) = 40*rand()+80;
        vel = ones(3,Uav_clt(uav_idx));
        Uav(uav_idx) = Target(Loc_clt, sqrt(P_rcs/2)*(randn()+1j*randn()), Uav_clt(uav_idx));
        Uav(uav_idx) = Uav(uav_idx).Gss_clt_gen(20, 1) ;
        Uav(uav_idx) = Uav(uav_idx).Trace_gen(vel,Sim_t,Time_step);
    end
end

%% figure Geom map
% Geom_figure_gen_func(Tx,T,BS,UE,Uav,f_sys2d,f_sys3d,...
%     Num_BS,Num_user,Num_clt,Num_uav_clt,R_cell)

%% Channel generator
Tx = Tx.Ant_gen(Ant_spc);
BS(1) = BS(1).Ant_gen_TX(Ant_spc,Tx.Trans_ant_opt);
for bs_idx = 2:Num_BS
    Opt = {'v',direcion(bs_idx)};
    BS(bs_idx) = BS(bs_idx).Ant_gen(Ant_spc,Opt);
end
for ue_idx = 1:Num_user
    Opt = {'v',360*rand(1,1)}; 
    UE(ue_idx) = UE(ue_idx).Ant_gen(Ant_spc,Opt);
end



%% Rec signal generator

%% figure Sig&Chl

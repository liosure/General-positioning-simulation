function Geom_figure_gen_func(Tx,T,BS,UE,Uav,f_sys2d,f_sys3d,Num_BS,Num_user,Num_clt,Num_uav_clt,r)
Tx.disp2d(f_sys2d);BS(2).disp2d(f_sys2d);Tx.cell_plot(f_sys2d,r);
T(1).disp2d(f_sys2d);UE(1).disp2d(f_sys2d);Uav(1).disp2d(f_sys2d,'v',[1/2,1/3,2/3],2);
legend1 = legend('TRx','Rx','Edge','CLT','UE','UAV Cluster');
set(legend1,'AutoUpdate','off');
for tar_idx = 2:Num_clt
    T(tar_idx).disp2d(f_sys2d);
end
for  ue_idx = 2:Num_user
    UE(ue_idx).disp2d(f_sys2d);
    drawnow
end
for uav_idx = 2:Num_uav_clt
    Uav(uav_idx).disp2d(f_sys2d,'v',[1/2,1/3,2/3],2);
end
for bs_idx = 2:Num_BS
    BS(bs_idx+1).disp2d(f_sys2d);
    drawnow
end
% for bs_idx = 1:Num_BS
%     BS(bs_idx+1).cell_plot(f_sys2d);
% end
axis([-500,500,-200,500])

Tx.disp3d(f_sys3d);BS(2).disp3d(f_sys3d);Tx.cell_plot(f_sys3d,r);
T(1).disp3d(f_sys3d);UE(1).disp3d(f_sys3d);Uav(1).disp3d(f_sys3d,'v',[1/2,1/3,2/3],2);
legend1 = legend('TRx','Rx','Edge','CLT','UE','UAV Cluster');
set(legend1,'Position',[0.69385119370309 0.652380959192912 0.210714282148651 0.24404761223566],'AutoUpdate','off');
for tar_idx = 2:Num_clt
    T(tar_idx).disp3d(f_sys3d);
end
for  ue_idx = 2:Num_user
    UE(ue_idx).disp3d(f_sys3d);
end
for uav_idx = 2:Num_uav_clt
    Uav(uav_idx).disp3d(f_sys3d,'v',[1/2,1/3,2/3],2);
end
for bs_idx = 2:Num_BS
    BS(bs_idx+1).disp3d(f_sys3d);
end
% for bs_idx = 1:Num_BS
%     BS(bs_idx+1).cell_plot(f_sys3d);
% end
axis([-500,500,-200,500])
end


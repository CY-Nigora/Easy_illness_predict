%% 运行主函数
%低感染人群模式
[sus,exe,ini,ill,rer,did,sum_people]=illness_model(1000,3.5714e-06,3.5714e-08,6,0.9,0.97,0.03,0.001);
%高感染人群模式
%[sus,exe,ini,ill,rer,did,sum_people]=illness_model(1000,0.6,0.3,0.8,0.9,0.97,0.03,0.001);

%% 分析
k_exe=diff(exe); % exe求导 
k_ini=diff(ini); % ini求导 

[~ , kmax_exe_time]=max(k_exe); % exe斜率最大点
[~ , kmax_ini_time]=max(k_ini); % ini斜率最大点

[max_exe , max_exe_time]=max(exe);           % exe值最大点
[max_ini , max_ini_time]=max(ini);           % ini值最大点
[max_ill , max_ill_time]=max(ill);    % ill_all值最大点

time1=kmax_ini_time - kmax_exe_time; % exe & ini max斜率的时间差
ok_exe_time=max_exe_time - kmax_exe_time;
ok_ini_time=max_ini_time - kmax_ini_time;
ok_ill_time=max_ill_time - kmax_ini_time;


%time1 -> 5 Tage 时间估计
ok_exe=ceil( 11 + (ok_exe_time / time1 )*5 );
ok_ini=ceil( 16 + (ok_ini_time / time1 )*5 );
ok_ill=ceil( 16 + (ok_ill_time / time1 )*5 );

%最大人数估计
ren_exe=ceil(  max_exe  / exe(kmax_exe_time) * 15238);
ren_ini=ceil(  ini(max_ini_time) / ini(kmax_ini_time) * 24324);
ren_ill=ceil(  ill(max_ill_time) / ini(kmax_ini_time) * 24324);
ren_die=floor(floor(did(end))/ did(kmax_ini_time)* 490);

%时间换算
[monat1,tag1]=time_judge(ok_exe);
[monat2,tag2]=time_judge(ok_ini);
[monat3,tag3]=time_judge(ok_ill);

clc;
fprintf('预测疑似病例统计拐点在：        %d 月 %d 日\n',monat1,tag1);
fprintf('预测确诊病例统计拐点在：        %d 月 %d 日\n',monat2,tag2);
fprintf('预测总共(疑似+确诊)统计拐点在： %d 月 %d 日\n',monat3,tag3);
fprintf('\n');
fprintf('预测最大累计确诊病例数：        %d 人\n',ren_ini);
fprintf('预测最大累计疑似病例数：        %d 人\n',ren_exe);
fprintf('预测最大累计死亡病例数：        %d 人\n',ren_die);
%fprintf('预测最大累计总病例(确诊+疑似)数：    %d 人\n',ren_ill);











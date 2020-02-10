%% ����������
%�͸�Ⱦ��Ⱥģʽ
[sus,exe,ini,ill,rer,did,sum_people]=illness_model(1000,3.5714e-06,3.5714e-08,6,0.9,0.97,0.03,0.001);
%�߸�Ⱦ��Ⱥģʽ
%[sus,exe,ini,ill,rer,did,sum_people]=illness_model(1000,0.6,0.3,0.8,0.9,0.97,0.03,0.001);

%% ����
k_exe=diff(exe); % exe�� 
k_ini=diff(ini); % ini�� 

[~ , kmax_exe_time]=max(k_exe); % exeб������
[~ , kmax_ini_time]=max(k_ini); % iniб������

[max_exe , max_exe_time]=max(exe);           % exeֵ����
[max_ini , max_ini_time]=max(ini);           % iniֵ����
[max_ill , max_ill_time]=max(ill);    % ill_allֵ����

time1=kmax_ini_time - kmax_exe_time; % exe & ini maxб�ʵ�ʱ���
ok_exe_time=max_exe_time - kmax_exe_time;
ok_ini_time=max_ini_time - kmax_ini_time;
ok_ill_time=max_ill_time - kmax_ini_time;


%time1 -> 5 Tage ʱ�����
ok_exe=ceil( 11 + (ok_exe_time / time1 )*5 );
ok_ini=ceil( 16 + (ok_ini_time / time1 )*5 );
ok_ill=ceil( 16 + (ok_ill_time / time1 )*5 );

%�����������
ren_exe=ceil(  max_exe  / exe(kmax_exe_time) * 15238);
ren_ini=ceil(  ini(max_ini_time) / ini(kmax_ini_time) * 24324);
ren_ill=ceil(  ill(max_ill_time) / ini(kmax_ini_time) * 24324);
ren_die=floor(floor(did(end))/ did(kmax_ini_time)* 490);

%ʱ�任��
[monat1,tag1]=time_judge(ok_exe);
[monat2,tag2]=time_judge(ok_ini);
[monat3,tag3]=time_judge(ok_ill);

clc;
fprintf('Ԥ�����Ʋ���ͳ�ƹյ��ڣ�        %d �� %d ��\n',monat1,tag1);
fprintf('Ԥ��ȷ�ﲡ��ͳ�ƹյ��ڣ�        %d �� %d ��\n',monat2,tag2);
fprintf('Ԥ���ܹ�(����+ȷ��)ͳ�ƹյ��ڣ� %d �� %d ��\n',monat3,tag3);
fprintf('\n');
fprintf('Ԥ������ۼ�ȷ�ﲡ������        %d ��\n',ren_ini);
fprintf('Ԥ������ۼ����Ʋ�������        %d ��\n',ren_exe);
fprintf('Ԥ������ۼ�������������        %d ��\n',ren_die);
%fprintf('Ԥ������ۼ��ܲ���(ȷ��+����)����    %d ��\n',ren_ill);











function [sus,exe,ini,ill_people,rer,did,sum_people]=illness_model(n,persent1,persent2,beta,xigma,gama,arfa,kesai)
%[sus,exe,ini,rer,did,sum_people]=illness_model(100,0.3,0.1,0.6,0.97,0.97,0.03,0.0001);

%% ��������
%n->alles-������;
%sus->Susceptibel-�׸���Ⱥ;
%exe->Exposed-Ǳ������Ⱥ;
%ini->Infectious-����Ⱦ��Ⱥ;
%rer->Recoverd-������Ⱥ;
%did->Died-��������Ⱥ;
ti = 1; %ʱ�侫��: 1 ��
time_lang=8000; %124 -> ��4 �� ��
%persent1 % persent2 : ��ʼ������Ǳ������Ⱥ�뱻��Ⱦ��Ⱥռ�������İٷֱ�

%% ����������
%����ȫΪ�׸��ߣ�sus=n
sus = zeros(time_lang,1); 
exe = zeros(time_lang,1);
ini = zeros(time_lang,1);
rer = zeros(time_lang,1);
did = zeros(time_lang,1);
sus(1) = n*(1-persent1-persent2);
exe(1) = n*persent1;
ini(1) = n*persent2;

for i=1:time_lang-1
    %���弸���仯����
    c1=kesai*rer(i)/n;
    c2=beta*sus(i)/n^2*exe(i);
    c3=exe(i)*xigma/n;
    c4=arfa*ini(i)/n;
    c5=gama*ini(i)/n;
        
    sus(i+1) = c1-c2+sus(i); %1
    [c1,c2,sus(i+1)]=people_logic(c1,c2,sus(i+1),n);
    
    exe(i+1) = c2-c3+exe(i); %2
    [c2,c3,exe(i+1)]=people_logic(c2,c3,exe(i+1),n);
   
    ini(i+1) = c3-(c4+c5)+ini(i); %3
    [c3,temp,ini(i+1)]=people_logic(c3,(c4+c5),ini(i+1),n);
   
    did(i+1) = c4+did(i);    %4
    [c5,temp,did(i+1)]=people_logic(c5,0,did(i+1),n);
     
    rer(i+1) = c5-c1+rer(i);  %5
    [c5,c1,rer(i+1)]=people_logic(c5,c1,rer(i+1),n);
    
end

ill_people=exe+ini; % �ܻ�������

figure(2);
plot(1:time_lang-1,sus(1:end-1),'linewidth',1.5);
hold on;
plot(1:time_lang-1,exe(1:end-1),'linewidth',1.5);
hold on;
plot(1:time_lang-1,ini(1:end-1),'linewidth',1.5);
hold on;
plot(1:time_lang-1,ill_people(1:end-1),'linewidth',1.5);
hold on;
plot(1:time_lang-1,rer(1:end-1),'linewidth',1.5);
hold on;
plot(1:time_lang-1,did(1:end-1),'linewidth',1.5);
hold off;

xlabel('Tage');
ylabel('Persone');
legend('Susceptibel','Exposed','Infectious','ill-people','Recoverd','Died');
    
    
%% ����
sum_people=ones(time_lang,1);
for i=1:time_lang
sum_people(i)=sus(i)+exe(i)+ini(i)+did(i)+rer(i);
end


clc;

end
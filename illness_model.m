function [sus,exe,ini,ill_people,rer,did,sum_people]=illness_model(n,persent1,persent2,beta,xigma,gama,arfa,kesai)
%[sus,exe,ini,rer,did,sum_people]=illness_model(100,0.3,0.1,0.6,0.97,0.97,0.03,0.0001);

%% 参数解释
%n->alles-总人数;
%sus->Susceptibel-易感人群;
%exe->Exposed-潜伏期人群;
%ini->Infectious-被感染人群;
%rer->Recoverd-康复人群;
%did->Died-死亡的人群;
ti = 1; %时间精度: 1 天
time_lang=8000; %124 -> ≈4 个 月
%persent1 % persent2 : 初始条件下潜伏期人群与被感染人群占总人数的百分比

%% 主函数部分
%首先全为易感者，sus=n
sus = zeros(time_lang,1); 
exe = zeros(time_lang,1);
ini = zeros(time_lang,1);
rer = zeros(time_lang,1);
did = zeros(time_lang,1);
sus(1) = n*(1-persent1-persent2);
exe(1) = n*persent1;
ini(1) = n*persent2;

for i=1:time_lang-1
    %定义几个变化因子
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

ill_people=exe+ini; % 总患病人数

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
    
    
%% 检验
sum_people=ones(time_lang,1);
for i=1:time_lang
sum_people(i)=sus(i)+exe(i)+ini(i)+did(i)+rer(i);
end


clc;

end
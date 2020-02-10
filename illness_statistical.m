
%% 1-参数表
text1=data_read('C:\Users\lenovo\Desktop\illness.xlsx'); %数据存放地址
%excel 数据格式：第一列序号，第二列日期，第三列当日确诊人数，第四列当日疑似人数，第五列累计死亡，第六列累计出院
%C:\Users\lenovo\Desktop\illness.xlsx

%% 2-plot
textt2=text1(:,1);
textt2(1,2:5)=0;
hang=size(text1,1);
for i=1:hang-1
    textt2(i+1,2)=(text1(i+1,2)-text1(i,2))/24; %每小时增速-确诊
    textt2(i+1,3)=(text1(i+1,3)-text1(i,3))/24; %每小时增速-疑似
    textt2(i+1,4)=(text1(i+1,4)-text1(i,4))/(text1(i,2)+text1(i,3))*100; %每小时增速-死亡
    textt2(i+1,5)=(text1(i+1,5)-text1(i,5))/(text1(i,2)+text1(i,3))*100; %每小时增速-出院
end
figure(1);
subplot(1,5,1);
plot(text1(:,1),text1(:,2),'o-','linewidth',1.5); %besimmt
hold on
%plot(text1(:,1),text1(:,3),'o-','linewidth',1.5);
%hold on
plot(text1(:,1),text1(:,4),'o-','linewidth',1.5); %sterben
hold off
xlabel('Tage');
legend('Bestimmt','sterben');
subplot(1,5,2);
[p1,out1]=grey_plot(textt2(:,2),'确诊');
subplot(1,5,3);
[p2,out2]=grey_plot(textt2(:,3),'疑似');
subplot(1,5,4);
[p3,out3]=grey_plot(textt2(:,4),'死亡率(%)');
subplot(1,5,5);
[p4,out4]=grey_plot(textt2(:,5),'出院率(%)');

extra=out1(end-1)-textt2(end,2);

p_b=text1(end,2)+(p1-extra)*24;
p_y=text1(end,3)+p2*24;
p_s=text1(end,4)+p3/100*(text1(end,2)+text1(end,3));
p_a=text1(end,5)+p4/100*(text1(end,2)+text1(end,3));

[monat,tag]=time_judge(hang);

clc;
fprintf('今日为 %d 月 %d 日：\n',monat,tag-1);
fprintf('\t累计确诊人数为： %.4d \n',text1(end,2));
fprintf('\t累计疑似人数为： %.4d \n',text1(end,3));
fprintf('\t累计死亡人数为： %.2d \n',text1(end,4));
fprintf('\t累计出院人数为： %.3d \n',text1(end,5));

fprintf('\n明日为 %d 月 %d 日，以下为预测数据：\n',monat,tag);
fprintf('\t累计确诊人数为： %d ,净增长 %d \n',floor(p_b),floor(p_b)-text1(end,2));
fprintf('\t累计疑似人数为： %d ,净增长 %d \n',floor(p_y),floor(p_y)-text1(end,3));
fprintf('\t累计死亡人数为： %d   ,净增长 %d \n',floor(p_s),floor(p_s)-text1(end,4));
fprintf('\t累计出院人数为： %d  ,净增长 %d \n',floor(p_a),floor(p_a)-text1(end,5));







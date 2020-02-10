
%% 1-������
text1=data_read('C:\Users\lenovo\Desktop\illness.xlsx'); %���ݴ�ŵ�ַ
%excel ���ݸ�ʽ����һ����ţ��ڶ������ڣ������е���ȷ�������������е��������������������ۼ��������������ۼƳ�Ժ
%C:\Users\lenovo\Desktop\illness.xlsx

%% 2-plot
textt2=text1(:,1);
textt2(1,2:5)=0;
hang=size(text1,1);
for i=1:hang-1
    textt2(i+1,2)=(text1(i+1,2)-text1(i,2))/24; %ÿСʱ����-ȷ��
    textt2(i+1,3)=(text1(i+1,3)-text1(i,3))/24; %ÿСʱ����-����
    textt2(i+1,4)=(text1(i+1,4)-text1(i,4))/(text1(i,2)+text1(i,3))*100; %ÿСʱ����-����
    textt2(i+1,5)=(text1(i+1,5)-text1(i,5))/(text1(i,2)+text1(i,3))*100; %ÿСʱ����-��Ժ
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
[p1,out1]=grey_plot(textt2(:,2),'ȷ��');
subplot(1,5,3);
[p2,out2]=grey_plot(textt2(:,3),'����');
subplot(1,5,4);
[p3,out3]=grey_plot(textt2(:,4),'������(%)');
subplot(1,5,5);
[p4,out4]=grey_plot(textt2(:,5),'��Ժ��(%)');

extra=out1(end-1)-textt2(end,2);

p_b=text1(end,2)+(p1-extra)*24;
p_y=text1(end,3)+p2*24;
p_s=text1(end,4)+p3/100*(text1(end,2)+text1(end,3));
p_a=text1(end,5)+p4/100*(text1(end,2)+text1(end,3));

[monat,tag]=time_judge(hang);

clc;
fprintf('����Ϊ %d �� %d �գ�\n',monat,tag-1);
fprintf('\t�ۼ�ȷ������Ϊ�� %.4d \n',text1(end,2));
fprintf('\t�ۼ���������Ϊ�� %.4d \n',text1(end,3));
fprintf('\t�ۼ���������Ϊ�� %.2d \n',text1(end,4));
fprintf('\t�ۼƳ�Ժ����Ϊ�� %.3d \n',text1(end,5));

fprintf('\n����Ϊ %d �� %d �գ�����ΪԤ�����ݣ�\n',monat,tag);
fprintf('\t�ۼ�ȷ������Ϊ�� %d ,������ %d \n',floor(p_b),floor(p_b)-text1(end,2));
fprintf('\t�ۼ���������Ϊ�� %d ,������ %d \n',floor(p_y),floor(p_y)-text1(end,3));
fprintf('\t�ۼ���������Ϊ�� %d   ,������ %d \n',floor(p_s),floor(p_s)-text1(end,4));
fprintf('\t�ۼƳ�Ժ����Ϊ�� %d  ,������ %d \n',floor(p_a),floor(p_a)-text1(end,5));







function [predict,grey]=grey_plot(x,name)%xΪ�����о���,nameΪ�ַ���
hang=size(x,1);
lie=size(x,2);
[grey,c]=greymodel(x);

plot(1:hang,x,'o-','linewidth',1.5);
hold on
plot(1:hang+1,grey,'--','linewidth',1.5);%grey���Ҫ��һ��Ԥ��ֵ
xlabel('Tage');
name2=['v-',name];
name3=[name2,'-'];
name4=[name3,c];
legend(name4,'predict');
hold off
predict=grey(hang+1);
end
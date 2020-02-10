function y=data_read(root)

%root='C:\Users\lenovo\Desktop\illness.xlsx';
[num,text] = xlsread(root);
hang=size(num,1);
y=zeros(hang,5);
y(:,1)=1:hang;
y(:,2:5)=num(:,3:6);


end
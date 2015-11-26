function [us,vs]=OpticalFlow(img1,img2) 
img1=double(img1);
img2=double(img2);

%get image size and adjust for border  获取图像对边界进行调整
[row1,column1]=size(img1);  
row=row1-5; column=column1-5;
z=zeros(row1,column1); v1=z; v2=z;

%initialize        初始化
dsx2=v1; dsx1=v1; dst=v1;
alpha2=625;
imax=20;

%Calculate gradients  计算梯度
dst(5:row,5:column) = ( img2(6:row+1,6:column+1)-img1(6:row+1,6:column+1) + img2(6:row+1,5:column)-img1(6:row+1,5:column)+ img2(5:row,6:column+1)-img1(5:row,6:column+1) + img2(5:row,5:column)-img1(5:row,5:column))/4;
dsx2(5:row,5:column) = ( img2(6:row+1,6:column+1)-img2(5:row,6:column+1) + img2(6:row+1,5:column)-img2(5:row,5:column)+ img1(6:row+1,6:column+1)-img1(5:row,6:column+1) +img1(6:row+1,5:column)-img1(5:row,5:column))/4;
dsx1(5:row,5:column) = ( img2(6:row+1,6:column+1)-img2(6:row+1,5:column) + img2(5:row,6:column+1)-img2(5:row,5:column)+ img1(6:row+1,6:column+1)-img1(6:row+1,5:column) +img1(5:row,6:column+1)-img1(5:row,5:column))/4;


for i=1:imax
   delta=(dsx1.*v1+dsx2.*v2+dst)./(alpha2+dsx1.^2+dsx2.^2);
   v1=v1-dsx1.*delta;
   v2=v2-dsx2.*delta;
end;
u=z;u(5:row,5:column)=v1(5:row,5:column);
v=z;v(5:row,5:column)=v2(5:row,5:column);

xskip=round(row1/100);
[hs,ws]=size(u(1:xskip:row1,1:xskip:column1));
us=zeros(hs,ws); vs=us;

N=xskip^2;
for i=1:hs-1
  for j=1:ws-1
     hk=i*xskip-xskip+1;
     hl=i*xskip;
     wk=j*xskip-xskip+1;
     wl=j*xskip;
     us(i,j)=sum(sum(u(hk:hl,wk:wl)))/N;
     vs(i,j)=sum(sum(v(hk:hl,wk:wl)))/N;
   end;
end;

function [us,vs]=OpticalFlow(img1,img2) 
%得到两幅图像的光流图
img1=double(img1);
img2=double(img2);

%获取图像对边界进行调整
[row,column]=size(img1);  
z=zeros(row,column); 
v1=z;
v2=z;

%初始化
fx=v1;%参考像素点的灰度值沿x方向的偏导数
fy=v1;%参考像素点的灰度值沿x方向的偏导数
fz=v1;%参考像素点的灰度值沿z方向的偏导数
alpha2=625;%反映光流算法的平滑性约束条件的参数
imax=20;%迭代次数

%计算梯度
fx =conv2(img1,0.25*[-1 1;-1 1],'same')+conv2(img2,0.25*[-1 1;-1 1],'same');
fy =conv2(img1,0.25*[-1 -1;1 1],'same')+conv2(img2,0.25*[-1 -1;1 1],'same');
fz=conv2(img1,0.25*ones(2),'same')+conv2(img2,-0.25*ones(2),'same');

%求解光流矢量
for i=1:imax
   delta=(fx.*v1+fy.*v2+fz)./(alpha2+fx.^2+fy.^2);
   v1=v1-fx.*delta;
   v2=v2-fy.*delta;
end;
u=v1;%横向光流矢量
v=v2;%纵向光流矢量

%光流场参数设置
d=round(row/50);%d表示光流场相邻两点之间的距离
[hs,ws]=size(u(1:d:row,1:d:column));%hs,ws表示光流场尺寸
us=zeros(hs,ws); vs=us;

%矩阵us,vs的计算
N=d^2;
for i=1:hs-1
  for j=1:ws-1
     hk=i*d-d+1;
     hl=i*d;
     wk=j*d-d+1;
     wl=j*d;
     us(i,j)=sum(sum(u(hk:hl,wk:wl)))/N;
     vs(i,j)=sum(sum(v(hk:hl,wk:wl)))/N;
  end
end

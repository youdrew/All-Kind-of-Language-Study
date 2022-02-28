% author:Engene_Hsuan (youdrew)
% 下面这个funciton将RGB的三色坐标转换到CIExy图上，对于我：用于验证TencentVP两种工作流程精度上的区别。
% 需要把一个坐标变换函数TransSRGBcv2CIExy，也拷贝到工作路径下。
% 之后需要修改输入Gamut，只需要修改函数TransSRGBcv2CIExy.



function sRGBColorCoord = Trans_sRGBColorCoordToCIExyGraph()
plotChromaticity;
hold on;

%%
%获取参考点点值
disp('现在输入的是参考点值，理论上是一张测试图的红绿蓝三点值')
sRGBColorReferCoordR=[0,0,0];
disp(' 请输入 R');
prompt = ' 输入：';
sRGBColorReferCoordR(1,1) = input(prompt);
disp(' 请输入 G');
prompt = ' 输入：';
sRGBColorReferCoordR(1,2) = input(prompt);
disp(' 请输入 B');
prompt = ' 输入：';
sRGBColorReferCoordR(1,3) = input(prompt);

ReferCoordR=TransSRGBcv2CIExy(sRGBColorReferCoordR(1,1),sRGBColorReferCoordR(1,2),sRGBColorReferCoordR(1,3));
scatter(ReferCoordR(1,1),ReferCoordR(1,2),20,'k');

sRGBColorReferCoordG=[0,0,0];
disp(' 请输入 R');
prompt = ' 输入：';
sRGBColorReferCoordG(1,1) = input(prompt);
disp(' 请输入 G');
prompt = ' 输入：';
sRGBColorReferCoordG(1,2) = input(prompt);
disp(' 请输入 B');
prompt = ' 输入：';
sRGBColorReferCoordG(1,3) = input(prompt);

ReferCoordG=TransSRGBcv2CIExy(sRGBColorReferCoordG(1,1),sRGBColorReferCoordG(1,2),sRGBColorReferCoordG(1,3));
scatter(ReferCoordG(1,1),ReferCoordG(1,2),20,'k');

sRGBColorReferCoordB=[0,0,0];
disp(' 请输入 R');
prompt = ' 输入：';
sRGBColorReferCoordB(1,1) = input(prompt);
disp(' 请输入 G');
prompt = ' 输入：';
sRGBColorReferCoordB(1,2) = input(prompt);
disp(' 请输入 B');
prompt = ' 输入：';
sRGBColorReferCoordB(1,3) = input(prompt);

ReferCoordB=TransSRGBcv2CIExy(sRGBColorReferCoordB(1,1),sRGBColorReferCoordB(1,2),sRGBColorReferCoordB(1,3));
scatter(ReferCoordB(1,1),ReferCoordB(1,2),20,'k');

% 绘制参考三角
triangle_x=[ReferCoordR(1,1),ReferCoordG(1,1), ReferCoordB(1,1),ReferCoordR(1,1)];
triangle_y=[ReferCoordR(1,2),ReferCoordG(1,2), ReferCoordB(1,2),ReferCoordR(1,2)];
fullcolor=fill(triangle_x,triangle_y,'k');
set(fullcolor,'facealpha',0.318);

%%
%获取待评价的点的值
disp('现在获取待评价点的值，理论上是经过实拍之后测试图的红绿蓝三点值')
disp(' 你要输入几个色域');
num = ' 输入：';
ColorNum = input(num);

for i=1:ColorNum
    Color=[ColorNum,3,3];
    sRGBColorCoord=[ColorNum,3,2];
    
    text=['请输入第',num2str(i),'个色域的信息：'];
    disp(text)
    
    for j=1:3
        if j==1
            disp('R:');
        elseif j==2
            disp('G:');
        elseif j==3
            disp('B:');
        else
            disp('循环遍历部分出错。')
        end
        
        for k=1:3
            prompt = ' 输入：';
            Color(i,j,k)=input(prompt);
        end
        Value2=TransSRGBcv2CIExy(Color(i,j,1),Color(i,j,2),Color(i,j,3));
        sRGBColorCoord(i,j,1)=Value2(1,1);
        sRGBColorCoord(i,j,2)=Value2(1,2);
        scatter(sRGBColorCoord(i,j,1),sRGBColorCoord(i,j,2),20,'k');
    end
%画图及计算偏差
%sRGBColorCoord是对应的输入的待评价图像在CIExy上的坐标，输入几个色域都混合成了矩阵，第一个值是每个色域，第二个值是R、G、B三点，第二维一定是3个点，第三维是x，y两个坐标。
triangle_x=[sRGBColorCoord(i,1,1), sRGBColorCoord(i,2,1), sRGBColorCoord(i,3,1),sRGBColorCoord(i,1,1)];
triangle_y=[sRGBColorCoord(i,1,2), sRGBColorCoord(i,2,2), sRGBColorCoord(i,3,2),sRGBColorCoord(i,1,2)];
    if i==1
        fullcolor=fill(triangle_x,triangle_y,'r');
        set(fullcolor,'facealpha',0.318); 
    elseif i==2
        fullcolor=fill(triangle_x,triangle_y,'g');
        set(fullcolor,'facealpha',0.318);
    elseif i==3
        fullcolor=fill(triangle_x,triangle_y,'b');
        set(fullcolor,'facealpha',0.318);
    elseif i==4
        fullcolor=fill(triangle_x,triangle_y,'c');
        set(fullcolor,'facealpha',0.318);
    elseif i==5
        fullcolor=fill(triangle_x,triangle_y,'m');
        set(fullcolor,'facealpha',0.318);
    elseif i==6
        fullcolor=fill(triangle_x,triangle_y,'y');
        set(fullcolor,'facealpha',0.318);
    elseif i==7
        fullcolor=fill(triangle_x,triangle_y,'k');
        set(fullcolor,'facealpha',0.318);
    else
        fullcolor=fill(triangle_x,triangle_y,'w');
        set(fullcolor,'facealpha',0.318);
    end

DeviationR=(abs(ReferCoordR(1,1)-sRGBColorCoord(i,1,1))^2+abs(ReferCoordR(1,2)-sRGBColorCoord(i,1,2))^2)^(1/2);
DeviationG=(abs(ReferCoordG(1,1)-sRGBColorCoord(i,2,1))^2+abs(ReferCoordG(1,2)-sRGBColorCoord(i,2,2))^2)^(1/2);
DeviationB=(abs(ReferCoordB(1,1)-sRGBColorCoord(i,3,1))^2+abs(ReferCoordB(1,2)-sRGBColorCoord(i,3,2))^2)^(1/2);
Deviation=(DeviationR+DeviationG+DeviationB)/3;

text=['！！！！！！！————————————> 第',num2str(i),'个色域的偏差值是(偏差值只做为技术参考数据，偏差值仅仅代表的是色坐标三点与参考色坐标三点在CIExy色度图上的位置差别的平均值，并不代表实际观感)：'];
disp(text)
disp(Deviation)
end
sRGBColorCoord='程序结束';
hold off
end


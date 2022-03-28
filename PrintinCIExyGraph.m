% author:Engene_Hsuan (youdrew)
% 直接在色度图上进行绘制色域 并判断色域偏移了多少
% 依据参考色域进行多次的绘制
% 这个程序用于20220322实验03-2判断色域偏移

function Deviation = PrintinCIExyGraph()


%%
%这里面的内容需要填写

                                  %在这里填写参考色域
ColorReferCoord=[0.6876 0.3104; 
                 0.2366 0.7066;
                 0.1286 0.0678]   %[R;G;B]

ColorCoord=[                 %在这里填写待评价色域
                 0.6872 0.3065   0.2401 0.7034   0.1278 0.0702;   %01个色域
                 0.6889 0.3067   0.2412 0.7014   0.1278 0.0720;   %02个色域
                 0.6891 0.3067   0.2422 0.7006   0.1273 0.0720;   %03个色域
                 0.6900 0.3066   0.2435 0.7021   0.1272 0.0723;   %04个色域
                 0.6904 0.3070   0.2431 0.6998   0.1270 0.0727;   %05个色域
                 0.6903 0.3059   0.2433 0.7006   0.1271 0.0732;   %06个色域
                 0.6910 0.3063   0.2438 0.6999   0.1270 0.0729;   %07个色域
                 0.6892 0.3060   0.2436 0.7005   0.1271 0.0734;   %08个色域
                 0.6909 0.3066   0.2446 0.7002   0.1273 0.0734;   %09个色域
                 0.6890 0.3049   0.2441 0.6989   0.1269 0.0736;   %10个色域
                 0.6905 0.3060   0.2445 0.7002   0.1269 0.0734;   %11个色域
                 0.6898 0.3055   0.2448 0.6976   0.1272 0.0738;   %12个色域
                 ];
NumberOfColorSpace = 12;           %在这里填写有几个待评测的色域





%%
%这里面开始自动循环画图
plotChromaticity;
hold on;

ColorCoverageArea=0;   % 以参考色域大小为1，判断色域覆盖是变大了还是变小了
Deviation=0;           % 色域偏移值。

% 绘制参考图
scatter(ColorReferCoord(1,1),ColorReferCoord(1,2),20,'k');
scatter(ColorReferCoord(2,1),ColorReferCoord(2,2),20,'k');
scatter(ColorReferCoord(3,1),ColorReferCoord(3,2),20,'k');
triangle_x=[ColorReferCoord(1,1),ColorReferCoord(2,1), ColorReferCoord(3,1),ColorReferCoord(1,1)];
triangle_y=[ColorReferCoord(1,2),ColorReferCoord(2,2), ColorReferCoord(3,2),ColorReferCoord(1,2)];
fullcolor=fill(triangle_x,triangle_y,'k');
set(fullcolor,'facealpha',0.318);


% 绘制判断图
for i=1:NumberOfColorSpace
        Color=[ColorCoord(i,1),ColorCoord(i,2);
               ColorCoord(i,3),ColorCoord(i,4);
               ColorCoord(i,5),ColorCoord(i,6)];
        
        % 绘制参考图
        scatter(Color(1,1),Color(1,2),20,'k');
        scatter(Color(2,1),Color(2,2),20,'k');
        scatter(Color(3,1),Color(3,2),20,'k');
        triangle_x=[Color(1,1),Color(2,1), Color(3,1),Color(1,1)];
        triangle_y=[Color(1,2),Color(2,2), Color(3,2),Color(1,2)];
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
              
        %求偏差值
        DeviationR=(abs(ColorReferCoord(1,1)-Color(1,1))^2+abs(ColorReferCoord(1,2)-Color(1,2))^2)^(1/2);
        DeviationG=(abs(ColorReferCoord(2,1)-Color(2,1))^2+abs(ColorReferCoord(2,2)-Color(2,2))^2)^(1/2);
        DeviationB=(abs(ColorReferCoord(3,1)-Color(3,1))^2+abs(ColorReferCoord(3,2)-Color(3,2))^2)^(1/2);
        %求面积大小
        %参考面积
        A1=[ColorReferCoord(1,1) ColorReferCoord(1,2)];
        B1=[ColorReferCoord(2,1) ColorReferCoord(2,2)];
        C1=[ColorReferCoord(3,1) ColorReferCoord(3,2)];
        
        A2=[Color(1,1) Color(1,2)];
        B2=[Color(2,1) Color(2,2)];
        C2=[Color(3,1) Color(3,2)];
        
        S1=area(A1,B1,C1);
        S2=area(A2,B2,C2);
        ColorCoverageArea=S2/S1;
        
        
        Deviation=(DeviationR+DeviationG+DeviationB)/3;
        text=[num2str(i),'. 在经过了',num2str(i*5),'分钟后，偏差值为：',num2str(Deviation)];
        disp(text);
        text2=['   色域大小缩小原来的',num2str(ColorCoverageArea*100),'%'];
        disp(text2);
        
end





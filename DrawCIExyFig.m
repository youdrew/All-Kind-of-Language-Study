
%author:Engene_Hsuan(youdrew)
%没有输入，在程序运行的时候会自行的请求输入。
%最终返回的是一个4*2的矩阵，分别代表的是RGB W的xy色度值

function ColorMatrix=DrawCIExyFig()
plotChromaticity;
hold on;

disp('你要输入几个色域');
num = '输入：';
ColorNum = input(num);
%%
%%———————————————————————————————————获取输入量——————————————————————————————
    for i=1:ColorNum
        ColorMatrix=[0,0;0,0;0,0;0,0;];
        disp('请输入R的x值');
        prompt = '输入：';
        ColorMatrix(1,1) = input(prompt);

        disp('请输入R的y值');
        prompt = '输入：';
        ColorMatrix(1,2) = input(prompt);

        disp('请输入G的x值');
        prompt = '输入：';
        ColorMatrix(2,1) = input(prompt);

        disp('请输入G的y值');
        prompt = '输入：';
        ColorMatrix(2,2) = input(prompt);

        disp('请输入B的x值');
        prompt = '输入：';
        ColorMatrix(3,1) = input(prompt);

        disp('请输入B的y值');
        prompt = '输入：';
        ColorMatrix(3,2) = input(prompt);

        disp('请输入W的x值');
        prompt = '输入：';
        ColorMatrix(4,1) = input(prompt);

        disp('请输入W的y值');
        prompt = '输入：';
        ColorMatrix(4,2) = input(prompt);
        

        
        scatter(ColorMatrix(1,1),ColorMatrix(1,2),36,'k');
        scatter(ColorMatrix(2,1),ColorMatrix(2,2),36,'k');
        scatter(ColorMatrix(3,1),ColorMatrix(3,2),36,'k');
        scatter(ColorMatrix(4,1),ColorMatrix(4,2),36,'k');

        triangle_x=[ColorMatrix(1,1),ColorMatrix(2,1), ColorMatrix(3,1),ColorMatrix(1,1)];
        triangle_y=[ColorMatrix(1,2),ColorMatrix(2,2), ColorMatrix(3,2),ColorMatrix(1,2)];
        
        
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

    end
hold off
end


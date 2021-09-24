%作业整理版本，对应笔记2020（光盘封皮） P094《色彩转换》 P102 《线性代数（线性空间与线性变换）》
%这是一个转换程序，从XYZ-（线性）转换到任意色彩空间之下

%输入值x是一张图片，可以在Matlab应用窗口输入，如：ColorTransFunction('test.tif')以引用一张图片
function TransMatrix=ColorTransFunction(x)
    %%
    %———————————————————————————获取已知量—————————————————————————————————————————————
    %获取图片在XYZ色彩空间下的坐标，XYZ的基默认是1（自然基）； 
    inputpic=x;
    ImageMatrix=imread(inputpic);     %读取测试图，测试图是XYZ 线性
    ImageMatrix=im2double(ImageMatrix);  %归一化，将图像从整数转化为双精度（0-1）内的浮点数
    [RRow,RCol,RDim]=size(ImageMatrix);

    disp('这是一个'+string(RRow)+'*'+string(RCol)+'的画面。是否需要裁切画面,需要输入1，不需要输入0');
    prompt = '输入：';
    Judge = input(prompt);

    if Judge==1
        prompt = '输入横向的裁切，(格式例如：200:400):';
        ColCrop=input(prompt);
        prompt = '输入纵向的裁切，(格式例如：200:400):';
        RowCrop=input(prompt);
        ImageMatrixMini=ImageMatrix(RowCrop,ColCrop,:);     %输入裁切命令，如果图片太大，运行速度慢，需要裁切
        [Row,Col,Dim]=size(ImageMatrixMini);    %提取裁切后的图片的行、列、维度

        ImageMatrixMiniX=ImageMatrix(RowCrop,ColCrop,1);      %提出待转换矩阵的X、Y、Z值来，（维度分割）
        ImageMatrixMiniY=ImageMatrix(RowCrop,ColCrop,2);
        ImageMatrixMiniZ=ImageMatrix(RowCrop,ColCrop,3);

    elseif Judge==0
        ImageMatrixMini=ImageMatrix;
        [Row,Col,Dim]=size(ImageMatrixMini);    %提取裁切后的图片的行、列、维度
        ImageMatrixMiniX=ImageMatrix(:,:,1);      %提出待转换矩阵的X、Y、Z值来，（维度分割）
        ImageMatrixMiniY=ImageMatrix(:,:,2);
        ImageMatrixMiniZ=ImageMatrix(:,:,3);
    else
        ImageMatrixMini=ImageMatrix;
        [Row,Col,Dim]=size(ImageMatrixMini);    %提取裁切后的图片的行、列、维度
        ImageMatrixMiniX=ImageMatrix(:,:,1);      %提出待转换矩阵的X、Y、Z值来，（维度分割）
        ImageMatrixMiniY=ImageMatrix(:,:,2);
        ImageMatrixMiniZ=ImageMatrix(:,:,3);
    end



    %%  
    %获取需要转换到的色彩空间

     disp('请选择您想要转换到的色彩空间');
     disp('默认选项：');
     disp(' 1.ITU-R BT 709')  %使用标准BT.709-6 (06/2015)：https://www.itu.int/rec/R-REC-BT.709-6-201506-I/en
     disp(' 2.ITU-R BT.2100') %使用标准BT.2100-2 (07/2018)：https://www.itu.int/rec/R-REC-BT.2100-2-201807-I/en
     disp(' 3.ITU-R BT.2020')
     disp(' 4.DCI D65')
     disp(' 5.DCI P3')
     disp(' 9.自选输入转换矩阵')
     disp(' 0.自选输入xYy');

    prompt2 = '输入：';
    Judge2 = input(prompt2);

    %几个预设的转换矩阵的值；
    %1.ITU-R BT 709=[xR=0.640 yR=0.330;xG=0.300 yG=0.600;xB=0.150 yB=0.060;xW=0.3127 yW=0.3290;]
    ColorSpaceBT709=[0.640 0.330;0.300 0.600;0.150 0.060;0.3127 0.3290];
    %2.ITU-R BT.2100=[xR=0.708 yR=0.292;xG=0.170 yG=0.797;xB=0.131 yB=0.046;xW=0.3127 yW=0.3290;]
    ColorSpaceBT2100=[0.708 0.292;0.170 0.797;0.131 0.046;0.3127 0.3290];
    %3.ITU-R BT.2020=[xR=0.708 yR=0.292;xG=0.170 yG=0.797;xB=0.131 yB=0.046;xW=0.3127 yW=0.3290;]
    ColorSpaceBT2020=[0.708 0.292;0.170 0.797;0.131 0.046;0.3127 0.3290];
    %4.DCI D65=[xR=0.680 yR=0.320;xG=0.265 yG=0.690;xB=0.150 yB=0.060;xW=0.3127 yW=0.3290;]
    ColorSpaceDCID65=[0.680 0.320;0.265 0.690;0.150 0.060;0.3127 0.3290];
    %5.DCI P3=[xR=0.680 yR=0.320;xG=0.265 yG=0.690;xB=0.150 yB=0.060;xW=0.3140 yW=0.3510;]
    ColorSpaceDCIP3=[0.680 0.320;0.265 0.690;0.150 0.060;0.3140 0.3510];

    ElectedColorSpace=zeros(4,2);

    if Judge2==1
        ElectedColorSpace=ColorSpaceBT709;
    elseif Judge2==2
        ElectedColorSpace=ColorSpaceBT2100;
    elseif Judge2==3
        ElectedColorSpace=ColorSpaceBT2020;
    elseif Judge2==4  
        ElectedColorSpace=ColorSpaceDCID65;
    elseif Judge2==5   
        ElectedColorSpace=ColorSpaceDCIP3;
    elseif Judge2==0
        promptMatrix = '输入xR：';
        promptMatrix1=input(promptMatrix);
        ElectedColorSpace(1,1)=promptMatrix1;
        promptMatrix = '输入yR：';
        promptMatrix2=input(promptMatrix);
        ElectedColorSpace(1,2)=promptMatrix2;
        promptMatrix = '输入xG：';
        promptMatrix3=input(promptMatrix);
        ElectedColorSpace(2,1)=promptMatrix3;
        promptMatrix = '输入yG：';
        promptMatrix4=input(promptMatrix);
        ElectedColorSpace(2,2)=promptMatrix4;
        promptMatrix = '输入xB：';
        promptMatrix5=input(promptMatrix);
        ElectedColorSpace(3,1)=promptMatrix5;
        promptMatrix = '输入yB：';
        promptMatrix6=input(promptMatrix);
        ElectedColorSpace(3,2)=promptMatrix6;
        promptMatrix = '输入xW：';
        promptMatrix7=input(promptMatrix);
        ElectedColorSpace(4,1)=promptMatrix7;
        promptMatrix = '输入yW：';
        promptMatrix8=input(promptMatrix);
        ElectedColorSpace(4,2)=promptMatrix8;
        clear(promptMatrix);
    elseif Judge2==9
        TransMatrix=zeros(3,3);
        disp('请直接输入一个3*3的转换矩阵吧');
        TransMatrix(1,1)=input('第一行第一列1，1：');
        TransMatrix(1,2)=input('第一行第二列1，2：');
        TransMatrix(1,3)=input('第一行第三列1，3：');
        TransMatrix(2,1)=input('第一行第一列2，1：');
        TransMatrix(2,2)=input('第一行第二列2，2：');
        TransMatrix(2,3)=input('第一行第三列2，3：');
        TransMatrix(3,1)=input('第一行第一列3，1：');
        TransMatrix(3,2)=input('第一行第二列3，2：');
        TransMatrix(3,3)=input('第一行第三列3，3：');
    end

    %根据选用的xYy来求色彩转换：

    %R
    xR=ElectedColorSpace(1,1);
    yR=ElectedColorSpace(1,2);
    %G
    xG=ElectedColorSpace(2,1);
    yG=ElectedColorSpace(2,2);
    %B
    xB=ElectedColorSpace(3,1);
    yB=ElectedColorSpace(3,2);
    %W
    xW=ElectedColorSpace(4,1);
    yW=ElectedColorSpace(4,2);

    %%
    %———————————————————————————以上是两个已知亮（XYZ的刺激值）和新色域的四色坐标—————————————————————————————————————————————

    %最终的转换矩阵（[R][G][B]）=([X][Y][Z])([转换矩阵])
    if Judge2==9                                       %获得的是矩阵
        disp('已经识别到了转换矩阵');

    else                                               %获得的是xYy色度值
                                                       %计算规定，但R=G=B=1时候，能呈现出纯白。
        KnownMatrix=zeros(3,3);
        KnownMatrix(1,1)=xR/yR;
        KnownMatrix(1,2)=xG/yG;
        KnownMatrix(1,3)=xB/yB;

        KnownMatrix(2,1)=1;
        KnownMatrix(2,2)=1;
        KnownMatrix(2,3)=1;

        KnownMatrix(3,1)=(1-xR-yR)/yR;
        KnownMatrix(3,2)=(1-xG-yG)/yG;
        KnownMatrix(3,3)=(1-xB-yB)/yB;
        KnownMatrix=KnownMatrix^-1;

        YR=KnownMatrix(1,1)*(xW/yW)+KnownMatrix(1,2)+KnownMatrix(1,3)*((1-xW-yW)/yW);
        YG=KnownMatrix(2,1)*(xW/yW)+KnownMatrix(2,2)+KnownMatrix(2,3)*((1-xW-yW)/yW);
        YB=KnownMatrix(3,1)*(xW/yW)+KnownMatrix(3,2)+KnownMatrix(3,3)*((1-xW-yW)/yW);

        TransMatrix=zeros(3,3);
        TransMatrix(1,1)=(xR/yR)*YR;
        TransMatrix(1,2)=(xG/yG)*YG;
        TransMatrix(1,3)=(xB/yB)*YB;

        TransMatrix(2,1)=YR;
        TransMatrix(2,2)=YG;
        TransMatrix(2,3)=YB;

        TransMatrix(3,1)=((1-xR-yR)/yR)*YR;
        TransMatrix(3,2)=((1-xG-yG)/yG)*YG;
        TransMatrix(3,3)=((1-xB-yB)/yB)*YB;
        TransMatrix=TransMatrix^-1;
    end


    AfterTransImageR=zeros(Row,Col);       %为转换后的图像矩阵腾出空间
    AfterTransImageG=zeros(Row,Col);
    AfterTransImageB=zeros(Row,Col);


    for r = 1:Row
        for c = 1:Col
            AfterTransImageR(r,c)=TransMatrix(1,1)*ImageMatrixMiniX(r,c)+TransMatrix(1,2)*ImageMatrixMiniY(r,c)+TransMatrix(1,3)*ImageMatrixMiniZ(r,c);
            AfterTransImageG(r,c)=TransMatrix(2,1)*ImageMatrixMiniX(r,c)+TransMatrix(2,2)*ImageMatrixMiniY(r,c)+TransMatrix(2,3)*ImageMatrixMiniZ(r,c);
            AfterTransImageB(r,c)=TransMatrix(3,1)*ImageMatrixMiniX(r,c)+TransMatrix(3,2)*ImageMatrixMiniY(r,c)+TransMatrix(3,3)*ImageMatrixMiniZ(r,c);
        end
    end

    %%
    %输出部分

    Mix3Dim(:,:,1)=AfterTransImageR;     %将三个通道混合成一个三个维度的图形矩阵
    Mix3Dim(:,:,2)=AfterTransImageG;
    Mix3Dim(:,:,3)=AfterTransImageB;

    if Judge2==1 %1.ITU-R BT 709
        Gamma=2.4;
    elseif Judge2==2 %2.ITU-R BT.2100 未写 有两个PQ和HLG
        Gamma=2.4;
    elseif Judge2==3 %3.ITU-R BT.2020
        Gamma=2.4;
    elseif Judge2==4 %4.DCI D65
        Gamma=2.6;
    elseif Judge2==5 %5.DCI P3
        Gamma=2.6;
    else
        Gamma=input('请输入该图像的EOTF值，如（2.4）：');
    end

    Mix3Dim = Mix3Dim .^(1/Gamma); %输入gamma值
    Mix3Dim=uint16(Mix3Dim*((2^16)-1)); %uint是告诉Matlab以16位输出这个图片


    imwrite(Mix3Dim,'Mix.tif');
    %imageinfo('ImageMatrixMini.tif');
    %imtool('ImageMatrixMini.tif');

    %%
    %整理
    clear xB xG xR xW yR yG yB yW YR YG YB
    clear AfterTransImageR AfterTransImageG AfterTransImageB 
    clear r c Col Row Dim RCol RDim RRow
    clear prompt prompt2 Judge Judge2
    clear KnownMatrix ImageMatrixMini ImageMatrixMiniX ImageMatrixMiniY ImageMatrixMiniZ ImageMatrix 
    clear Gamma ElectedColorSpace ColorSpaceDCIP3 ColorSpaceDCID65 ColorSpaceBT709 ColorSpaceBT2100 ColorSpaceBT2020
    imshow(Mix3Dim);               %this is show a pic
end

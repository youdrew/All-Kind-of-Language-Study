% 将sRGB下面的三坐标，转换到CIExy下面。


function Coord = TransSRGBcv2CIExy(r,g,b)

A=[0.4124564,0.3575761,0.1804375;0.2126729,0.7151522,0.072175;0.0193339,0.1191920,0.9503041];
B=[r;g;b];
C=A*B;

disp('发起sRGB 2 CIE XYZ的转换，对应的X、Y、Z值是：')
disp(C);

Coord=[0,0];
Coord(1,1)=C(1,1)/(C(1,1)+C(2,1)+C(3,1));
Coord(1,2)=C(2,1)/(C(1,1)+C(2,1)+C(3,1));
end

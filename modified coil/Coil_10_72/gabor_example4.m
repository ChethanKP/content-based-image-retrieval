function[tg Hist]= gabor_example4(image_in)
%tic;		
close all;	
workspace;	
lambda  = 8;%wavelength of sinusoidal factor
theta   = 0;%orientation
psi     = [0 pi/2];%phase shift
gamma   = 0.5;
bw      = 1;
N       = 6;i=1;j=1;
e1=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
m=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
var1=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
tg=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];


RGB = rgb2hsv(image_in);%conversion from rgb to hsv color space

% get image size:
[M1,N1,ttt] = size(RGB);

range = 0.0:0.1:1.0;

Hist = zeros(length(range),length(range),length(range));

for i1=1:M1
    for j1=1:N1

        
        nn1 = round(RGB(i1,j1,1) * 10)+1;
        nn2 = round(RGB(i1,j1,2) * 10)+1;        
        nn3 = round(RGB(i1,j1,3) * 10)+1;
        
        Hist(nn1, nn2, nn3)=Hist(nn1, nn2, nn3) + 1;
        
    end
end
Hist = Hist / (M1*N1);%color feature
img_in=rgb2gray(image_in);%conversion from rgb to gray scale
img_out = zeros(size(img_in,1), size(img_in,2), N);
aa = zeros(size(img_in,1), size(img_in,2));
for n=1:N %n is number of orientation
    for n1=1:4%n1 is scale
   gb = gabor_fn(bw,gamma,psi(1),lambda,theta)...
        + 1i * gabor_fn(bw,gamma,psi(2),lambda,theta);
    % gb is the n-th gabor filter
    img_out(:,:,i) = imfilter(img_in, gb, 'symmetric');%filtering the input image  
    theta = theta + pi/6;
    gamma=gamma+n1;
    [x1,y1,z1]=size(img_out);
    for x=1:1:x1
       for y=1:1:y1
            aa(x,y)=abs(img_out(x,y,i));%absolute value of the matrix aa
       end
    end
    m(i)=mean2(aa);
    for x=1:1:x1
       for y=1:1:y1
            e1(i)=e1(i)+(abs(img_out(x,y,i))-m(i))^2;
       end
    end
   var1(i)=sqrt(e1(i))/(x1*y1);
    tg(j)=m(i);
    j=j+1;
    tg(j)=var1(i);
    j=j+1;
    i=i+1;
    end
end
tg=(tg-min(min(tg)))/(max(max(tg))-min(min(tg)));%texture vector


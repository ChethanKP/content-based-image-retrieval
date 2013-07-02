function[tg Hist]= gabor_example4(image_in)
%tic;		
	
lambda  = 8;%wavelength of sinusoidal factor
theta   = 0;%orientation
psi     = [0 pi/2];
gamma   = 0.5;
bw      = 1;
N       = 6;i=1;j=1;
e=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
e1=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
m=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
var1=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
tg=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];


RGB = rgb2hsv(image_in);

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
%plot(Hist);
Hist = Hist / (M1*N1);
%hist=imhist(image_in);
%imshow(hist);
img_in=rgb2gray(image_in);
%img_in(:,:,2:3) = [];   % discard redundant channels, it's gray anyway
img_out = zeros(size(img_in,1), size(img_in,2), N);
aa = zeros(size(img_in,1), size(img_in,2));
for n=1:N
    for n1=1:4
    gb = gabor_fn(bw,gamma,psi(1),lambda,theta)...
        + 1i * gabor_fn(bw,gamma,psi(2),lambda,theta);
    % gb is the n-th gabor filter
    img_out(:,:,i) = imfilter(img_in, gb, 'symmetric');
   % img_out1(i)=img_out(:,:,i);
    % filter output to the n-th channel
    %figure (i);
    
    theta = theta + pi/6;
    gamma=gamma+n1;
    [x1,y1,z1]=size(img_out);
    for x=1:1:x1
       for y=1:1:y1
            aa(x,y)=abs(img_out(x,y,i));
       end
    end
    %m(i)=e(i)/(x1*y1);
    m(i)=mean2(aa);
    %var1(i)=sqrt(e(i)-m(i))/(x1*y1);
    for x=1:1:x1
       for y=1:1:y1
            e1(i)=e1(i)+(abs(img_out(x,y,i))-m(i))^2;
       end
    end
   var1(i)=sqrt(e1(i))/(x1*y1);
    %var1(i)=var(aa(:));
    tg(j)=m(i);
    j=j+1;
    tg(j)=var1(i);
    j=j+1;
    i=i+1;
    %tg(i)=var(i);
    %imshow(abs(img_out(:,:,n)));
    %img_out_disp1 = (abs(img_out).^2);
   % imshow(img_out_disp1);
    % next orientation
    end
end
tg=(tg-min(min(tg)))/(max(max(tg))-min(min(tg)));

%figure(1);
%imshow(img_in);
%figure(2);
%imshow(image_in);
%title('input image');
%figure(3);
%img_out_disp = sum(abs(img_out).^2, 3).^0.5;
% default superposition method, L2-norm
%img_out_disp = img_out_disp./max(img_out_disp(:));

% normalize
%imshow(img_out_disp);
%title('gabor output, L-2 super-imposed, normalized');
%toc;
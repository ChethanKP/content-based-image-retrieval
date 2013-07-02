function [ rgb,rgb1 ] = seg( inputimage )
J = inputimage;
close all;
i=1;
while i<=3
I=J(:,:,i);%splitting into red,green and blue bands 

[junk threshold] = edge(I, 'sobel');%Find edges in grayscale image using sobel
f = 0.3;
BWs = edge(I,'sobel', threshold * f);%tune the threshold value and calculate edges again to get binary mask

se90 = strel('line', 3, 90);%creating vertical structuring element
se0 = strel('line', 3, 0);%creating horizontal structuring element
BWsdil = imdilate(BWs, [se90 se0]);%dilation using both se

BWdfill = imfill(BWsdil, 'holes');%filling holes

seD = strel('diamond',1);%creating daimond structuring element
BWfinal = imerode(BWdfill,seD);%smoothing the mask
BWfinal = imerode(BWfinal,seD);%smoothing the mask

Segout = I;
Segout1 = I;
Segout(BWfinal) = 0;
if i == 1
    imr=Segout;
end
if i == 2
    img=Segout;
end
if i==3
    imb=Segout;
end



Segout1(~BWfinal) = 0;
if i == 1
    imr1=Segout1;
end
if i == 2
    img1=Segout1;
end
if i==3
    imb1=Segout1;
end

i=i+1;
end
rgb=cat(3,imr,img,imb);%background image
% figure;
% imshow(rgb);
rgb1=cat(3,imr1,img1,imb1);%foreground image
% figure;imshow(rgb1);


end


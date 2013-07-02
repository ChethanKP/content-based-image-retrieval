function [ rgb,rgb1 ] = seg( inputimage )
J = inputimage;
close all;
i=1;
while i<=3
I=J(:,:,i);

[junk threshold] = edge(I, 'sobel');
fudgeFactor = 0.3;
BWs = edge(I,'sobel', threshold * fudgeFactor);

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);

BWdfill = imfill(BWsdil, 'holes');

seD = strel('diamond',1);
BWfinal = imerode(BWdfill,seD);
BWfinal = imerode(BWfinal,seD);

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
rgb=cat(3,imr,img,imb);
% figure;
% imshow(rgb);
rgb1=cat(3,imr1,img1,imb1);
% figure;imshow(rgb1);


end


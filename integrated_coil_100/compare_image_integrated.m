function [ DG count c1] = compare_image_integrated(  )
close all;
originalFolder = pwd; 
[baseFileName, folder] = uigetfile('*.*', 'Specify an image file'); 
fullImageFileName = fullfile(folder, baseFileName);		
cd(originalFolder);  
if ~exist(fullImageFileName, 'file')
		message = sprintf('This file does not exist:\n%s', fullImageFileName);
		uiwait(msgbox(message));
		return;
end
tic;
j1=2;k=2;k1=2;count=0;c1=[0 0 0 0 0];
k2=1;
load('features.mat');
image_in=imread(fullImageFileName);
dg1=compare_image(image_in);
dg2=compare_imager1(image_in);
DG=(dg1+dg2)/2;
[sorted Isorted]=sort(DG);
figure (1);
     subplot(4,3,1);
     imshow(imresize(image_in,[400 400]));
     title('input image');
         img_in=convert1(baseFileName);
    for (i=1:50)
        RGB = imread(names1{Isorted(i)});
        
        if k1>11
         figure(j1);
         j1=j1+1;
         subplot(4,3,1);
         imshow(imresize(image_in,[400 400]));
         title('input image');
         k=2;
         k1=2;k2=k2+1;
        end
         im_out=convert1(names1{Isorted(i)});
        count=count+count1(img_in,im_out);
        c1(k2)=c1(k2)+count1(img_in,im_out);
       subplot(4,3,k);
       k=k+1;
       k1=k1+1;
       
       imshow(imresize(RGB,[400 400]));  
  
    end
     for i=51:72
        im_out=convert1(names1{Isorted(i)});
        count=count+count1(img_in,im_out);
    end

toc;
end


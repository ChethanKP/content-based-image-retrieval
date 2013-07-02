function [ DG count c1] = compare_image()
% close all;
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
wt=0.12;
wc=0.88;j1=2;DG=[];k=2;k1=2;
k2=1;c1=[0 0 0 0 0];
count=0;
f=0;
l=25;
m=1;
u=1;
pe=struct;
ne=struct;
he=struct;
%Isorted=[];
image_in=imread(fullImageFileName);
[tg hist]=gabor_example4(image_in);
load('features.mat');
nfiles=length(Hist1);
for i=1:nfiles
    dt=pdist2(tg1{i},tg,'euclidean');
    sum1=0;
    sum2=0;
    sum3=0;

    [x,y,z]=size(hist);
    for x1=1:x
        for y1=1:y
            for z1=1:z
                sum1=sum1+min(Hist1{i}(x1,y1,z1),hist(x1,y1,z1));
            end
        end
    end
    for x2=1:x
        for y2=1:y
            for z2=1:z
                sum2=sum2+Hist1{i}(x2,y2,z2);
                sum3=sum3+hist(x2,y2,z2);
            end
        end
    end
    sum4=min(sum2,sum3);
    sc=sum1/sum4;
    dc=1-sc;
    DG(i)=(wt*dt)+(wc*dc);     
end
[sorted,Isorted]= sort(DG(:));%sorted contains sorted values and isorted contains corresponding index values
     figureFullScreen();
     figure (1);
     subplot(4,3,1);
     imshow(imresize(image_in,[256 384]));
     title('input image');
      img_in=convert1(baseFileName);
    for (i=1:50)
        RGB = imread(names1{Isorted(i)});
        he=uicontrol('Style', 'pushbutton', 'String', '',...
        'Position', [720 10 60 60],...
        'Callback',@myhome);
        [a,map]=imread('hommy1.jpg');
        [r,c,d]=size(a); 
        x=ceil(r/200); 
        y=ceil(c/350); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(he,'CData',g);
        
        pe=uicontrol('Style', 'pushbutton', 'String', '',...
        'Position', [110 10 60 60],...
        'Callback',{@myprev,m});
        [a,map]=imread('pre1.jpg');
        [r,c,d]=size(a); 
        x=ceil(r/200); 
        y=ceil(c/350); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(pe,'CData',g);

        ne=uicontrol('Style', 'pushbutton', 'String', '',...
        'Position', [1300 10 60 60],...
        'Callback',{@mynext,u});
        [a,map]=imread('nex1.jpg');
        [r,c,d]=size(a); 
        x=ceil(r/200); 
        y=ceil(c/350); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(ne,'CData',g);

        if k1>11
         m=m+1;
         u=u+1;k2=k2+1;
         if(u==5)
             u=1;
         end
         
         figureFullScreen();
         figure(j1);
         j1=j1+1;
         subplot(4,3,1);
         imshow(imresize(image_in,[256 384]));
         title('input image');
         k=2;
         k1=2;
        end
        im_out=convert1(names1{Isorted(i)});
        count=count+count1(img_in,im_out);
        c1(k2)=c1(k2)+count1(img_in,im_out);
       subplot(4,3,k);
       k=k+1;
       k1=k1+1;
       f=f+1;
       imshow(imresize(RGB,[256 384]));
  
    end
    %maximize('all');
    for i=51:72
        im_out=convert1(names1{Isorted(i)});
        count=count+count1(img_in,im_out);
    end
    function myprev(~,~,m)
            m=m-1;
            if(m==0)
                m=5;
            end
            figure (m);
    end

    function mynext(~,~,u)
            u=u+1;
            if(u==6)
                u=1;
            end
            figure (u);
    end

    function myhome(~,~)
             untitled;
    end
toc;
end


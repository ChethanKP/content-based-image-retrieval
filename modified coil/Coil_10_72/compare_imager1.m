function [ DG count c1 ] = compare_imager1()
% close all;	
workspace;
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
wc=0.88;j1=2;DG=[];nResults=100;count=0;c1=[0 0 0 0 0];
k=2;k1=2;k2=1;
f1=0;
l1=25;
m1=1;
u1=1;
pe1=struct;
ne1=struct;
he1=struct;
%Isorted=[];
image_in=imread(fullImageFileName);
[s1,s2]=seg(image_in);

[tga hista]=gabor_example4(s1);
[tgb histb]=gabor_example4(s2);

load('featuresr.mat');
nfiles=length(names1);
for i=1:nfiles
    %tg2=cell2mat(tg1{i});
    dt1=pdist2(tg1{i,1},tga,'euclidean');
    dt2=pdist2(tg1{i,2},tgb,'euclidean');
    suma1=0;
    suma2=0;
    suma3=0;
    sumb1=0;
    sumb2=0;
    sumb3=0;

    [x,y,z]=size(hista);
    for x1=1:x
        for y1=1:y
            for z1=1:z
                suma1=suma1+min(Hist1{i,1}(x1,y1,z1),hista(x1,y1,z1));
                sumb1=sumb1+min(Hist1{i,2}(x1,y1,z1),histb(x1,y1,z1));
            end
        end
    end
    for x2=1:x
        for y2=1:y
            for z2=1:z
                suma2=suma2+Hist1{i,1}(x2,y2,z2);
                sumb2=sumb2+Hist1{i,2}(x2,y2,z2);
                suma3=suma3+hista(x2,y2,z2);
                sumb3=sumb3+histb(x2,y2,z2);
            end
        end
    end
    suma4=min(suma2,suma3);
    sumb4=min(sumb2,sumb3);
    sca=suma1/suma4;
    dc1=1-sca;
    scb=sumb1/sumb4;
    dc2=1-scb;
    DG1(i)=(wt*dt1)+(wc*dc1);
    DG2(i)=(wt*dt2)+(wc*dc2);
    
     
end
    DG=(DG1+DG2)/2;
    [sorted,Isorted]= sort(DG(:));
%     figureFullScreen();
%     figure (1);
%     subplot(4,3,1);
%     imshow(imresize(image_in,[256 384]));
%     title('input image');
    img_in=convert1(baseFileName);
    for i=1:50
        RGB = imread(names1{Isorted(i)});
        
        he1=uicontrol('Style', 'pushbutton', 'String', '',...
        'Position', [680 10 60 60],...
        'Callback',@myhome);
        [a,map]=imread('hommy1.jpg');
        [r,c,d]=size(a); 
        x=ceil(r/200); 
        y=ceil(c/350); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(he1,'CData',g);
        
        pe1=uicontrol('Style', 'pushbutton', 'String', '',...
        'Position', [110 10 60 60],...
        'Callback',{@myprev,m1});
        [a,map]=imread('pre1.jpg');
        [r,c,d]=size(a); 
        x=ceil(r/200); 
        y=ceil(c/350); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(pe1,'CData',g);
        
        ne1=uicontrol('Style', 'pushbutton', 'String', '',...
        'Position', [1250 10 60 60],...
        'Callback',{@mynext,u1});
        [a,map]=imread('nex1.jpg');
        [r,c,d]=size(a); 
        x=ceil(r/200); 
        y=ceil(c/350); 
        g=a(1:x:end,1:y:end,:);
        g(g==255)=5.5*255;
        set(ne1,'CData',g);
        
        
        %str = sprintf('Im %d: %.3f',i,100*Sorted(i))
        if k1>11
            m1=m1+1;
            u1=u1+1;
            if(u1==5)
                 u1=1;
            end
%             figureFullScreen();
%             figure(j1);
%             subplot(4,3,1);
%             imshow(imresize(image_in,[256 384]));
%             title('input image');
            j1=j1+1;
            k=2;
            k1=2;
            k2=k2+1;
        end
        im_out=convert1(names1{Isorted(i)});
        count=count+count1(img_in,im_out);
        c1(k2)=c1(k2)+count1(img_in,im_out);
%         subplot(4,3,k);
%         imshow(image_in);
%         title('input image');
        k=k+1;
        k1=k1+1;
        f1=f1+1;
%         imshow(imresize(RGB,[256 384]));  %title(str);
    % end
    
    end
    for i=51:72
        im_out=convert1(names1{Isorted(i)});
        count=count+count1(img_in,im_out);
    end
        
    function myprev(~,~,m1)
        m1=m1-1;
            if (m1==0)
                m1=5;
            end
            figure (m1);
    end

    function mynext(~,~,u1)
        u1=u1+1;
        if(u1==6)
            u1=1;
        end
            figure (u1);
    end

    function myhome(~,~)
             untitled;
    end
toc;

end


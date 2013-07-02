function [ DG ] = compare_imager1(image_in)

wt=0.15;
wc=0.85;DG=[];

%Isorted=[];
image_in1=image_in;
[s1,s2]=seg(image_in1);

[tga hista]=gabor_example4(s1);
[tgb histb]=gabor_example4(s2);
figure(1);
 
imshow(image_in);
title('input image');
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
    %if(DG(i)<0.4)
     %   k=imread(names1{i});
      %  figure(j1);
       % j1=j1+1;
        %imshow(k);
    %end
     
end
    DG=(DG1+DG2)/2;
    
end


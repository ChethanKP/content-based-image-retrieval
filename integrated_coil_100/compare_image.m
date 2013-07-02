function [ DG ] = compare_image(image_in)


wt=0.12;
wc=0.88;DG=[];

%Isorted=[];
image_in1=image_in;

[tg hist]=gabor_example4(image_in1);
% figure(1);
%  
% imshow(image_in);
% title('input image');
load('features.mat');
nfiles=length(Hist1);
for i=1:nfiles
    %tg2=cell2mat(tg1{i});
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
    %if(DG(i)<0.4)
     %   k=imread(names1{i});
      %  figure(j1);
       % j1=j1+1;
        %imshow(k);
    %end
     
end
  

end


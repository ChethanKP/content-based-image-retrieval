function [  ] = builddatabaser(  )
% Generates a database of features based on the images in the db/ folder.

d = dir('*.png');
names = [];
names1 = [];

Hist1 = [];
tg1 = [];

for i = 1:size(d, 1)
    fprintf('Extracting features for %s... ', d(i).name);
    names = {d(i).name};
    
    names1=[names1;names];
    img = imread([d(i).name]);
    [s1,s2]=seg(img);
    tic;
    [tga Hista] = gabor_example4(s1);
     [tgb Histb] = gabor_example4(s2);
%     Hist=mat2cell(Hist);
    Hist={Hista,Histb};
    Hist1 = [Hist1;Hist];
    tg={tga,tgb};
    tg1 = [tg1; tg];
    i=i+1;
    toc;
end

save featuresr names1 tg1 Hist1

end
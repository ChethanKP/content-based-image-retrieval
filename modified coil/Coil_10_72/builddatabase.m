function [  ] = builddatabase(  )
% Generates a database of features based on the images in the coreal/ folder.

d = dir('*.png');%List folder contents
names = [];
names1 = [];

Hist1 = [];
tg1 = [];

for i = 1:size(d, 1)
    fprintf('Extracting features for %s... ', d(i).name);
    names = {d(i).name};
    
    names1=[names1;names];
    img = imread([d(i).name]);

    tic;
    [tg Hist] = gabor_example4(img);
    %Hist=mat2cell(Hist);
    Hist={Hist};
    Hist1 = [Hist1;Hist];
    tg={tg};
    tg1 = [tg1; tg];
    i=i+1;
    toc;
end

save features names1 Hist1 tg1

end
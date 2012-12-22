%Author: Sascha Wiplinger 0702060
%Version: 21.12.2012
%
%Just creating output for black-and-white- and thinned images.
% Input: path of picture (absolute or relative to bw_thin_test.m), of type char.
% Output: 2 images, one of the b&w-image, the other of the thinned image.
% Return: nothing
function [] = bw_thin_test(path)
    close all;
    img = imread(path);
    total = tic;
    cd graythresh;
    [thresh, bg] = simpleGrayThresh(img);
    cd ../bw;
    bwimg = bw(img, thresh, bg);
    figure;imshow(bwimg);
    thinning = tic;
    cd ../thin;
    timg = thin(bwimg, 0);
    figure; imshow(timg);
    cd ..;
    disp(['Total: ', num2str(toc(total))]);
    disp(['Thinning: ', num2str(toc(thinning))]);
end
function [ bwimg ] = bw (img, thresh, bg)

    bwimg = ones(size(img));
    s = size(img);
    for y = 1:s(2)
        for x = 1:s(1)
            if( img(x,y) < thresh)
                bwimg(x,y,1)=0;
                bwimg(x,y,2)=0;
                bwimg(x,y,3)=0;
            end
        end
    end
    if(bg > thresh)
        bwimg = 1-bwimg;
    end
end
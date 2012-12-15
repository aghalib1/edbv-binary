function [ bwimg ] = bw (img, thresh, bg)

    bwimg = ones(size(img,1),size(img,2));
    for y = 1:size(img,2)
        for x = 1:size(img,1)
            r=0.299*img(x,y,1);
            g=0.587*img(x,y,2);
            b=0.114*img(x,y,3);
            if( r+b+g <= (thresh*255))
                bwimg(x,y)=0;
            end
        end
    end
    if(bg > thresh)
        bwimg = 1-bwimg;
    end
end
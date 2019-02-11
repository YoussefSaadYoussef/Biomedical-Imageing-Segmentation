% canny technique
function RGB_Image = edge_detect(im)
[r ,c ,o] = size(im);
if o > 1
   im = rgb2gray(im);
end 
im = uint8(im);
x = fspecial('gaussian',[15 15],3.5);
f = Otsus_threshs(im);
fs = imfilter(f,x);
[gx,gy] = gradient(double(fs)); 
mag = sqrt(gx.^2+gy.^2); % magnitue of the image 
alpha = rad2deg(atan(gy./gx)); % angles  of the images 
dir = zeros(r,c); % directions depend to angles  of the images 

% finding the directions closest to alpha 
for nrow = 2:r
    for ncol =2:c
        if ((alpha(nrow,ncol)>= -22.5 && alpha(nrow,ncol)<= 22.5) || (alpha(nrow,ncol) >= 157.5 && alpha(nrow,ncol) <= -157.5) )
            dir(nrow,ncol) = '1';
            elseif ((alpha(nrow,ncol) >= -67.5 && alpha(nrow,ncol) <= -22.5)|| (alpha(nrow,ncol) >= 112.5 && alpha(nrow,ncol) <= 157.5))
                dir(nrow,ncol) = '3';
            elseif ((alpha(nrow,ncol) >= 67.5 && alpha(nrow,ncol) <= 112.5)|| (alpha(nrow,ncol) >= -112.5 && alpha(nrow,ncol) <= -67.5)) 
                dir(nrow,ncol) = '2';
            elseif ((alpha(nrow,ncol) >= 22.5 && alpha(nrow,ncol) <= 67.5)|| (alpha(nrow,ncol) >= -157.5 && alpha(nrow,ncol) <= -112.5))  
                dir(nrow,ncol) = '4';
        end
    end
end

% edge of the image from comiation  its magnitude ad angle 
gn = zeros(r,c); 

for mrow = 1:r-1
    for mcol =1:c-1
        if dir(mrow,mcol) == '1'
            if ( (mag(mrow,mcol) < mag(mrow - 1,mcol)) || ( mag(mrow,mcol) < mag(mrow + 1,mcol) ))
                gn(mrow,mcol) = 0 ;
            else
                gn(mrow,mcol) = mag(mrow,mcol) ;
            end
        elseif dir(mrow,mcol) == '2'
            if ( (mag(mrow,mcol) < mag(mrow,mcol - 1)) || ( mag(mrow,mcol) < mag(mrow,mcol + 1) ))
                gn(mrow,mcol) = 0 ;
            else
                gn(mrow,mcol) = mag(mrow,mcol) ;
            end
        elseif dir(mrow,mcol) == '3'
            if ( (mag(mrow,mcol) < mag(mrow + 1,mcol + 1)) || ( mag(mrow,mcol) < mag(mrow -1 ,mcol - 1) ))
                gn(mrow,mcol) = 0 ;
            else
                gn(mrow,mcol) = mag(mrow,mcol) ;
            end
        elseif dir(mrow,mcol) == '4'
            if ( (mag(mrow,mcol) < mag(mrow + 1,mcol - 1)) || ( mag(mrow,mcol) < mag(mrow -1 ,mcol + 1) ))
                gn(mrow,mcol) = 0 ;
            else
                gn(mrow,mcol) = mag(mrow,mcol) ;
            end
        end 
    end
end

% final operation is thresholding 
TL = .1 ;
TH = 3 * TL;
gnh = gn >= TH ;
gnl = gn >= TL ;
gnl = gnl - gnh ;
mask = [1 1 1; 1 0 1; 1 1 1]/8; % to make 8-connectivity 
gnl_8connect = conv2(gnl,mask,'same')>=.998;  %.998 is a tolerance close to 1
img_final = uint8(gnl_8connect + gnh);
% make colored edges 
RGB_Image = zeros(r,c,3);
RGB_Image(:,:,1) = im;
RGB_Image(:,:,2) = im;
RGB_Image(:,:,3) = im;
BWoutline = bwperim(img_final);
[row ,col] = size(BWoutline);
for k=1:length(BWoutline)
    for rr = 1:row
        for cc = 1:col
            if (BWoutline(rr,cc) == 1)
                RGB_Image(rr,cc,1)=255;
                RGB_Image(rr,cc,2)=255;
                RGB_Image(rr,cc,3)=0; 
            end
        end
    end
end
RGB_Image = uint8(RGB_Image);


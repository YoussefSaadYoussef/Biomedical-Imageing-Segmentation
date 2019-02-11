function  im_equalized= hisEqu(im)

if size(im,3)==3

im=rgb2gray(im);
end
im=double(im);

    x=255;

% image histogram
v=zeros(x+1,1);
    for i=1:size(im,1)
      for j=1:size(im,2)
          for k=1:x+1
              if im(i,j)== k-1
                  
                 v(k)= v(k)+1 ;
              end
          end
      end
    end
    
    % Histogram Equalization
    
  veq=v./(size(im,1)*size(im,2));    %pdf
veq(1)=v(1);
for l=2:256 
    veq(l)=veq(l-1)+veq(l);             %CDF
end

veq=round(x.* veq);
im_equalized=zeros(size(im,1),size(im,2));
for i=1:size(im,1)
      for j=1:size(im,2)
          
   im_equalized(i,j)=veq(im(i,j)+1);  %adding 1 to avoid zeros
      end
end

%Showing results

%figure,subplot(2,1,1),imshow(im,[]),title('Original image')


%subplot(2,1,2),imshow(im_equalized,[]),title('Equalized image')



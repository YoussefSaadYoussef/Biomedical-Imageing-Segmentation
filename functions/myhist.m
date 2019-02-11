function v=myhist(im)

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
    
    bar(v,'b')
    ylim([0 max(v(:))])
    xlim([0 280])

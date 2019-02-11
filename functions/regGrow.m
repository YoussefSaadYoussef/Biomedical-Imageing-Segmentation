function  R= regGrow(im)

if size(im,3)==3
im=rgb2gray(im);
end

%get seed
im=double(im);
imshow(im,[])
s=ginput;
s=round(s);

%aveage of multiple seeds
v=0;
for m=1:size(s,1)
    v=v+(im(s(m+size(s,1)),s(m)));
end
s_av = (v /( size(s,1)*size(s,2)/2));


%get range of our intesity
y=zeros(size(im));
for i=1:size(im,1)
      for j=1:size(im,2)
         if abs(double(im(i,j))-s_av) < 30
             y(i,j)=1 ; 
         end
      end
end

%get connected points of first four seeds

    R1=zeros(size(im)); R2=zeros(size(im));
    R3=zeros(size(im)); R4=zeros(size(im));  
    
%1st
m1=s(1,2);
n1=s(1,1);
L=bwlabeln(y,8);
z1=L(m1,n1);
R1=L==z1;

%2nd
if size(s,1) > 1
m2=s(2,2);
n2=s(2,1);
z2=L(m2,n2);
R2=L==z2;
end

%3rd
if   size(s,1) > 2
m3=s(3,2);
n3=s(3,1);
z3=L(m3,n3);
R3=L==z3;
end

%4th
if   size(s,1) > 3
m4=s(4,2);
n4=s(4,1);
z4=L(m4,n4);
R4=L==z4;
end

%sumation of all seeds results
Result=zeros(size(R1));
    for i=1:size(R1,1)
    for j=1:size(R1,2)
        
        Result(i,j)=R1(i,j)+R2(i,j)+R3(i,j)+R4(i,j);
    end
    end
    R=im2bw(Result,0);

%displaying image
imshow(R,[])
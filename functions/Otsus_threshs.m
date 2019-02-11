
% write the fuction on command window and put image in input 
function [final, thrsh] = Otsus_threshs(f)
[m ,n ,c] = size(f);
if c > 1
    f = rgb2gray(f);
end
%to find proability 
num = 0;
p = zeros(255,1);
for i = 0 : 255
    for k = 1 : m*n
        if f(k) == i
            num = num +1 ;
        end
    end
    p(i+1) = num ./ (m*n);
    num = 0;
end

 %global mean 
mug = 0; 
for i = 1 : 255
    mug = mug + (i-1) * p(i);
end
var = zeros(1,256);
% commulative means
for t = 1:255  
    mut1 = 0;
    mut2 = 0;
    p1 = sum(p(1:t));
    p2 = 1 - p1 ; 
    for i = 1 : t
        mut1 = mut1 + (i-1) * p(i);
    end
    mu1 = mut1 / p1 ;
    for i = t+1 : 255
        mut2 = mut2 + (i-1) * p(i);
    end
    mu2 = mut2 / p2 ;
var(t) = p1*((mu1 - mug)^2) + p2*((mu2 - mug)^2);    
end
maximum= max (var);
thresh = find(var == maximum);
thrsh = mean(thresh);
g = f >= thrsh ;
y = strel('disk',3);
final = imopen(g, y);









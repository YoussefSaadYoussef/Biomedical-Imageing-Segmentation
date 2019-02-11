
function  th_img = globalthrsh(f)
[a ,b, c] = size(f);
if c > 1
    f = rgb2gray(f);
end 
f = uint8(f);
T0 = (max(f(:)) + min(f(:)))/2 ;
display(T0) 
%T0 = mean(f(:));
delt = .1;
th_img = f > T0 ;

while delt >= .1
    T = T0;
    G1 = uint8((f > T)) .* f ;
    G2 = uint8((f <= T)) .* f;
    %M1 =  mean(G1(:));
    M1 = (max(G1(:)) + min(G1(:)))/2;
    %M2 =  mean(G2(:));
    M2 = (max(G2(:)) + min(G2(:)))/2;
    T0= 0.5*(M1+M2);
    th_img = f > T0 ;
    delt = abs(T - T0);
    display(T0) ;
end 






